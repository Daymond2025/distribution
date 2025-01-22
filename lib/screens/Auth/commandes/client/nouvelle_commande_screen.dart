import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/commande_produit_card.dart';
import 'package:flutter/material.dart';

class NouvelleCommandeScreen extends StatefulWidget {
  const NouvelleCommandeScreen({super.key, required this.titre});
  final String titre;

  @override
  State<NouvelleCommandeScreen> createState() => _NouvelleCommandeScreenState();
}

class _NouvelleCommandeScreenState extends State<NouvelleCommandeScreen> {
  List<Order> _ordersNew = [];
  List<Order> _ordersPending = [];
  bool _loading = false;
  bool _loading2 = true;
  OrderService orderService = OrderService();

  bool _noCnx = false;
  String controller = '';

  Future<void> fetchNew() async {
    ApiResponse response =
        await orderService.findAll('person=client&status=confirm');
    if (response.error == null) {
      setState(() {
        _ordersNew = response.data as List<Order>;
        _loading = true;
        _noCnx = false;
      });
      print("les commandes $_ordersNew");
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      print(response.error);
      setState(() {
        _noCnx = true;
        controller = 'nouvelle';
      });
    }
  }

  Future<void> fetchPending() async {
    ApiResponse response =
        await orderService.findAll('person=client&status=pending');
    if (response.error == null) {
      setState(() {
        _ordersPending = response.data as List<Order>;
        _loading2 = true;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      setState(() {
        _noCnx = true;
        controller = 'attente';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNew();
    fetchPending();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: colorfond,
              appBar: AppBar(
                backgroundColor: colorwhite,
                iconTheme: const IconThemeData(
                  color: colorblack,
                ),
                elevation: 0.9,
                title: Text(
                  widget.titre,
                  style: const TextStyle(
                    color: colorblack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                centerTitle: true,
                bottom: const PreferredSize(
                  preferredSize: Size(double.infinity, 25.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TabBar(
                      labelColor: colorYellow2,
                      unselectedLabelColor: colorblack,
                      indicatorColor: colorYellow2,
                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      tabs: [
                        SizedBox(
                          height: 25.0,
                          child: Tab(
                            text: 'Nouvelles commandes',
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                          child: Tab(text: 'Commandes en attentes'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  _loading
                      ? _ordersNew.isNotEmpty
                          ? CommandeProduitCard(
                              titre: 'Nouvelle commande',
                              status: 'nouvelle',
                              orders: _ordersNew,
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/pas_commande.png',
                                    height: 200,
                                    width: 200,
                                  ),
                                  const Text('Pas de nouvelle commande'),
                                ],
                              ),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _loading2
                      ? _ordersPending.isNotEmpty
                          ? CommandeProduitCard(
                              titre: 'Commande attente',
                              status: 'attente',
                              orders: _ordersPending,
                            )
                          : const Center(
                              child: Text('Pas de commandes!'),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          )
        : kRessayer(context, () {
            controller == 'nouvelle'
                ? fetchNew()
                : controller == 'attente'
                    ? fetchPending()
                    : print('Veillez contactez l\'administrateur!');
          });
  }
}
