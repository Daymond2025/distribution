import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/clone/clone_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/menu_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/historique_screen.dart';
import 'package:distribution_frontend/screens/Auth/mes_clics_screen.dart.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/home_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuActivitesScreen extends StatefulWidget {
  const MenuActivitesScreen({super.key});

  @override
  State<MenuActivitesScreen> createState() => _MenuActivitesScreenState();
}

class _MenuActivitesScreenState extends State<MenuActivitesScreen> {
  DateTime timeBackPressed = DateTime.now();
  dynamic _count = [];
  int _orderCount = 0;
  int _favoriteCount = 0;
  int _cloneCount = 0;

  HomeService homeService = HomeService();

  bool _noCnx = false;

  Future<void> index() async {
    ApiResponse response = await homeService.menu();
    if (response.error == null) {
      setState(() {
        _count = response.data as dynamic;
        print(_count);
        _orderCount = _count['orders_count'];
        _favoriteCount = _count['favorites_count'];
        _cloneCount = _count['clones_count'];
        _noCnx = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // setState(() {
      //   _noCnx = true;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    index();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: AppBar(
        elevation: 0.95,
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          color: Colors.black87, //change color on your need
        ),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/activity.png',
              width: 20,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                    Icons.error); // Remplacez par une autre image ou icône.
              },
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Mes activités',
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ],
        ),
      ),
      body: !_noCnx
          ? WillPopScope(
              onWillPop: () async {
                final differeance = DateTime.now().difference(timeBackPressed);
                timeBackPressed = DateTime.now();
                if (differeance >= const Duration(seconds: 2)) {
                  const String msg = 'Voulez-vous quitter l\'application?';
                  Fluttertoast.showToast(
                    msg: msg,
                    backgroundColor: const Color.fromARGB(179, 10, 10, 10),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  return false;
                } else {
                  return true;
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MenuCommandeScreen(),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/Groupe43.png',
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/commande.png',
                                          height: 34,
                                          width: 34,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Mes commandes',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // ignore: sort_child_properties_last
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: colorannule,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Text(
                                      _orderCount.toString(),
                                      style: const TextStyle(color: colorwhite),
                                    ),
                                  ),
                                  right: 18,
                                  top: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CloneScreen(),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/Groupe43.png',
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/images.jpg',
                                          height: 60,
                                          width: 60,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Ma boutique',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // ignore: sort_child_properties_last
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: colorannule,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Text(
                                      _cloneCount.toString(),
                                      style: const TextStyle(color: colorwhite),
                                    ),
                                  ),
                                  right: 18,
                                  top: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const HistoriqueScreen(),
                                    ),
                                  ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/Groupe43.png',
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/Bonus.png',
                                            height: 36,
                                            width: 36,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Mes bonus',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // ignore: sort_child_properties_last
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: colorannule,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Text(
                                        _favoriteCount.toString(),
                                        style:
                                            const TextStyle(color: colorwhite),
                                      ),
                                    ),
                                    right: 18,
                                    top: 10,
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MesClicsScreen(),
                                    ),
                                  ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/Groupe43.png',
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/main.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Mes clics',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const HistoriqueScreen(),
                                    ),
                                  ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/Groupe43.png',
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/favorie_gris.png',
                                            height: 36,
                                            width: 36,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Mes favories',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // ignore: sort_child_properties_last
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: colorannule,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Text(
                                        _favoriteCount.toString(),
                                        style:
                                            const TextStyle(color: colorwhite),
                                      ),
                                    ),
                                    right: 18,
                                    top: 10,
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PortefeuilleScreen(),
                                    ),
                                  ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/Groupe43.png',
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/portefeuille_v3.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Mon portefeuille',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    
                  ],
                ),
              ),
            )
          : kRessayer(context, () {
              index();
            }),
    );
  }
}

class CardActiviteMenu extends StatelessWidget {
  const CardActiviteMenu(
      {super.key, required this.title, this.notification, required this.icon});
  final String title;
  final String? notification;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/Groupe43.png',
          height: 130,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 34,
                  color: Colors.black54,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        notification == null
            ? Container()
            : Positioned(
                // ignore: sort_child_properties_last
                child: Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorannule,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    notification.toString(),
                    style: const TextStyle(color: colorwhite),
                  ),
                ),
                right: 18,
                top: 10,
              )
      ],
    );
  }
}
