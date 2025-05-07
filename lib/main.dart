import 'package:distribution_frontend/screens/Auth/notifications/notification_screen.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/register_screen.dart';
import 'package:distribution_frontend/seller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseApi().initNotifications();
  final appLinks = AppLinks(); // AppLinks is singleton

// Subscribe to all events (initial link and further)
  final sub = appLinks.uriLinkStream.listen((uri) {
    // Do something (navigation, ...)
    print('=====uri: ${uri.toString()}');
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SellerProvider()),
      ],
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
    // openAppSettings();
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
      supportedLocales: const [
        Locale('fr', ''),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: LoadingScreen.routeName,
      navigatorKey: navigatorKey,
      routes: {
        LoadingScreen.routeName: (context) => const LoadingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        NotificationScreen1.routeName: (context) => const NotificationScreen1(),
      },
      builder: EasyLoading.init(),
    );
  }
}
