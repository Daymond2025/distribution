import 'package:distribution_frontend/screens/Auth/notifications/notification_screen.dart';
import 'notification_screen.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/register_screen.dart';
import 'package:distribution_frontend/seller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';
import 'package:distribution_frontend/services/firebase_api.dart';
import 'package:in_app_update/in_app_update.dart'; // InAppUpdatePlugin
//import 'notification_screen.dart';
import 'firebase_options.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notifications lorsque l'app est lancé pour la première fois , ou lors de la mise a jour de l'app
  await FirebaseApi().initNotifications();

  final appLinks = AppLinks(); // AppLinks is singleton

  // Subscribe to all events (initial link and further)
  final sub = appLinks.uriLinkStream.listen((uri) {
    // Do something (navigation, ...)
    print('=====uri: ${uri.toString()}');
  });
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SellerProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //FirebaseMessaging _firebaseMessaging;
  @override
  void initState() {
    super.initState();
    _checkForMandatoryUpdate(); // 👈 Appel de la vérification au démarrage
    // openAppSettings();
  }

  // Verifier si il y a une mise a jour
  Future<void> _checkForMandatoryUpdate() async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable &&
          updateInfo.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      } else {
        debugPrint("✅ Aucune mise à jour obligatoire disponible.");
      }
    } catch (e) {
      debugPrint("❌ Erreur lors de la vérification de mise à jour : $e");
      // Tu peux ici afficher une boîte de dialogue pour bloquer l'accès si tu veux forcer absolument.
    }
  }

  // void openAppSettings() async {
  //   final intent = AndroidIntent(
  //     action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
  //     data: 'package:com.daymondboutique.distribution_frontend',
  //   );
  //   await intent.launch();
  // }

  @override
  Widget build(BuildContext context) {
    // Obtention des dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'Distribution',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr', '')],
      debugShowCheckedModeBanner: false,
      initialRoute: LoadingScreen.routeName,
      navigatorKey: navigatorKey,
      routes: {
        LoadingScreen.routeName: (context) => const LoadingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        NotificationScreen1.routeName: (context) => const NotificationScreen1(),
        NotificationScreen.routeName: (context) => const NotificationScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
