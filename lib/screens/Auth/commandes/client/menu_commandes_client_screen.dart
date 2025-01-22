import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/annule_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/en_cours_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/nouvelle_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/valide_commande_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class MenuCommandesClientScreen extends StatefulWidget {
  const MenuCommandesClientScreen({
    super.key,
  });

  @override
  State<MenuCommandesClientScreen> createState() =>
      _MenuCommandesClientScreenState();
}

class _MenuCommandesClientScreenState extends State<MenuCommandesClientScreen> {
  dynamic data = '';
  int news = 0;
  int pending = 0;
  int in_progress = 0;
  int validated = 0;
  int cancelled = 0;

  OrderService orderService = OrderService();

  Future<void> countOrder() async {
    ApiResponse response = await orderService.count();
    print("object");
    if (response.error == null) {
      setState(() {
        data = response.data as dynamic;
        news = data['total_confirm'];
        pending = data['total_pending'];
        in_progress = data['total_in_progress'];
        validated = data['total_validated'];
        cancelled = data['total_cancelled'];
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    countOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            // ignore: avoid_print
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NouvelleCommandeScreen(
                  titre: 'POUR MES CLIENTS',
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 18,
                right: 18,
              ),
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                color: colorYellow2,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Nouvelles commandes',
                    style: TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                            top: 3.0,
                            bottom: 3.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            color: colorattente,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            pending.toString(),
                            style: const TextStyle(
                              color: colorwhite,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 3.0,
                            bottom: 3.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          decoration: const BoxDecoration(
                            color: colorwhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            news.toString(),
                            style: const TextStyle(
                              color: colorYellow,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EnCoursCommandeScreen(
                  titre: 'POUR MES CLIENTS',
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 18,
                right: 18,
              ),
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: colorBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Commandes en cours',
                    style: TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    in_progress.toString(),
                    style: const TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ValideCommandeScreen(
                  titre: 'POUR MES CLIENTS',
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 18,
                right: 18,
              ),
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: colorvalid,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Commandes validées',
                    style: TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    validated.toString(),
                    style: const TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            // ignore: avoid_print
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnnuleCommandeScreen(
                  titre: 'POUR MES CLIENTS',
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 18,
                right: 18,
              ),
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: colorannule,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Commandes annulées',
                    style: TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    cancelled.toString(),
                    style: const TextStyle(
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
