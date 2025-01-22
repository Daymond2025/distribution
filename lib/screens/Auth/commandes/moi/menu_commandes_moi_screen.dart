import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/all_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/card_commande_moi_screen.dart';

import 'package:flutter/material.dart';

class MenuCommandesMoiScreen extends StatefulWidget {
  const MenuCommandesMoiScreen({
    super.key,
  });

  @override
  State<MenuCommandesMoiScreen> createState() => _MenuCommandesMoiScreenState();
}

class _MenuCommandesMoiScreenState extends State<MenuCommandesMoiScreen> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: colorfond,
        appBar: AppBar(
          toolbarHeight: 25,
          backgroundColor: colorwhite,
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 30.0),
            child: SizedBox(
              width: double.infinity,
              child: TabBar(
                labelColor: colorBlue,
                unselectedLabelColor: colorblack,
                indicatorColor: colorBlue,
                labelPadding: EdgeInsets.all(0),
                labelStyle: TextStyle(
                  fontSize: 14,
                ),
                tabs: [
                  SizedBox(
                    height: 40.0,
                    width: 100,
                    child: Tab(
                      text: 'Tout',
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 100,
                    child: Tab(text: 'En préparation'),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 100,
                    child: Tab(text: 'En route'),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 100,
                    child: Tab(text: 'Terminer'),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 100,
                    child: Tab(text: 'Annuler'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            AllCommandeScreen(),
            CardCommandeMoiScreen(status: 'person=seller&status=confirm'),
            CardCommandeMoiScreen(status: 'person=seller&status=in_progress'),
            CardCommandeMoiScreen(status: 'person=seller&status=validated'),
            CardCommandeMoiScreen(status: 'person=seller&status=cancelled'),
          ],
        ),
      ),
    );
  }
}
