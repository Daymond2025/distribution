import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/menu_commandes_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/menu_commandes_moi_screen.dart';
import 'package:flutter/material.dart';

class MenuCommandeScreen extends StatefulWidget {
  const MenuCommandeScreen({super.key});

  @override
  State<MenuCommandeScreen> createState() => _MenuCommandeScreenState();
}

class _MenuCommandeScreenState extends State<MenuCommandeScreen> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colorwhite,
          iconTheme: const IconThemeData(
            color: Colors.black54, //change color on your need
          ),
          title: const Text(
            'MES COMMANDES',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorblack,
            ),
          ),
          centerTitle: true,
          // ignore: prefer_const_literals_to_create_immutables
          actions: [],
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 25.0),
            child: SizedBox(
              width: double.infinity,
              child: TabBar(
                padding: EdgeInsets.only(
                  top: 5,
                ),
                labelColor: colorYellow2,
                unselectedLabelColor: colorblack,
                indicatorColor: colorYellow2,
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                tabs: [
                  SizedBox(
                    height: 30.0,
                    child: Tab(
                      icon: Text(
                        'Pour mes clients',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                    child: Tab(
                      icon: Text(
                        'Pour moi-même',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MenuCommandesClientScreen(),
            MenuCommandesMoiScreen(),
          ],
        ),
      ),
    );
  }
}
