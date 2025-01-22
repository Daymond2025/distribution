import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/intro/daymond_intro_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/no_connexion_screen.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  static const routeName = '/';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  UserService userService = UserService();

  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DaymondIntroScreen()),
          (route) => false);
    } else {
      ApiResponse response = await userService.getUserDetail();
      if (response.error == null) {
        //ApiResponse data = await getHome();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else if (response.error == unauthorized) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DaymondIntroScreen()),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NoConnexionScreen()),
            (route) => false);
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: colorwhite),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/logo_.png',
                        fit: BoxFit.contain),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitDoubleBounce(color: colorYellow2, size: 50.0),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        'Daymond',
                        style: TextStyle(
                          color: colorYellow2,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
