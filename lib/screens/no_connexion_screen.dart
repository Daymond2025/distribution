import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class NoConnexionScreen extends StatefulWidget {
  const NoConnexionScreen({super.key});

  @override
  State<NoConnexionScreen> createState() => _NoConnexionScreenState();
}

class _NoConnexionScreenState extends State<NoConnexionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/connexion.png'),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Oups !',
              style: TextStyle(
                color: colorBlue,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Vous n\'êtes pas connecté à internet vérifier votre connexion et',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black26,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const LoadingScreen()),
                  (route) => false),
              child: const Text(
                'Réessayez',
                style: TextStyle(
                  color: colorBlue,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
