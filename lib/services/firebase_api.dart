import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:distribution_frontend/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:distribution_frontend/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Fonction exécutée quand une notif arrive en background
Future<void> onBackgroundMessage(RemoteMessage message) async {
  // Ne pas utiliser debugPrint ici
  // Optionnel : tu peux préparer une notification locale ici, si nécessaire
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.routeName,
      arguments: message,
    );
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) {
          handleMessage(RemoteMessage.fromMap(jsonDecode(payload)));
        }
      },
    );

    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(androidChannel);
  }

  Future<void> initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) return;

      final imageUrl = message.data['image'];

      BigPictureStyleInformation? styleInfo;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        try {
          final imageBytes = await _downloadImage(imageUrl);
          styleInfo = BigPictureStyleInformation(
            ByteArrayAndroidBitmap(imageBytes),
            largeIcon: const DrawableResourceAndroidBitmap('notification_icon'),
            contentTitle: notification.title,
            summaryText: notification.body,
          );
        } catch (e) {
          debugPrint('⚠️ Erreur lors du chargement de l\'image : $e');
        }
      }

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: 'notification_icon',
            styleInformation: styleInfo,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  /// Télécharger l’image depuis une URL pour l’affichage enrichi
  Future<Uint8List> _downloadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Échec du téléchargement de l’image');
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      debugPrint('🎯 Token FCM récupéré: $token');
      return token;
    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération du token FCM: $e');
      return null;
    }
  }

  Future<void> sendTokenToBackend(String token, String bearerToken) async {
    if (token.isEmpty || bearerToken.isEmpty) {
      debugPrint('⚠️ Token ou bearerToken vide, envoi annulé');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://v2.daymondboutique.com/api/v2/fcm-token'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': token,
          'device_type': Platform.isAndroid ? 'android' : 'ios',
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('✅ Token FCM envoyé avec succès au backend');
      } else {
        debugPrint(
            '❌ Échec de l\'envoi du token: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ Exception HTTP lors de l\'envoi du token: $e');
    }
  }

  Future<void> initNotifications() async {
    try {
      // 🔐 1. Demander les permissions utilisateur
      final settings = await _firebaseMessaging.requestPermission();
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          debugPrint('✅ Permission de notifications accordée.');
          break;
        case AuthorizationStatus.denied:
          debugPrint('❌ Permission de notifications refusée.');
          return;
        case AuthorizationStatus.notDetermined:
          debugPrint(
              '⚠️ L’utilisateur n’a pas encore répondu à la demande de permission.');
          return;
        case AuthorizationStatus.provisional:
          debugPrint('ℹ️ Permission de notifications provisoire.');
          break;
      }

      // 🔄 2. Initialiser les services de notification
      await initPushNotifications();
      await initLocalNotifications();

      // 🎯 3. Récupérer le token FCM (et le régénérer si vide)
      String? fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint("⚠️ Token FCM vide, tentative de régénération...");
        await _firebaseMessaging.deleteToken();
        fcmToken = await _firebaseMessaging.getToken();
      }

      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint("❌ Impossible de récupérer un token FCM valide.");
        return;
      }

      debugPrint('📡 Token FCM final : $fcmToken');

      // 🔐 4. Récupérer le bearer token (auth utilisateur)
      final prefs = await SharedPreferences.getInstance();
      final bearerToken = prefs.getString('token');

      if (bearerToken == null || bearerToken.isEmpty) {
        debugPrint('❌ Bearer token manquant. Token FCM non envoyé.');
        return;
      }

      // 📤 5. Envoi au backend
      debugPrint('📤 Envoi automatique du token FCM au backend...');
      await sendTokenToBackend(fcmToken, bearerToken);
    } catch (e, stackTrace) {
      debugPrint('❌ Erreur dans initNotifications : $e');
      debugPrint('📍 StackTrace : $stackTrace');
    }
  }
}
