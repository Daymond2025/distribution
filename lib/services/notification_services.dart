// lib/services/notification_services.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static Future<void> sendPushNotification({
    required int userId,
    required String title,
    required String body,
    required String bearerToken,
    required String deviceType,
  }) async {
    final url = Uri.parse('https://v2.daymondboutique.com/api/v2/send-notification');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'title': title,
          'body': body,
          'device_type': deviceType,
        }),
      );

      if (response.statusCode == 200) {
        print('✅ Notification envoyée avec succès : ${response.body}');
      } else {
        print('❌ Échec de l\'envoi : ${response.statusCode}');
        print('Réponse : ${response.body}');
      }
    } catch (e) {
      print('❌ Erreur réseau ou exception : $e');
    }
  }
}
