import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/commande_produit_card.dart';
import 'package:flutter/material.dart';

class AnnuleCommandeScreen extends StatefulWidget {
  const AnnuleCommandeScreen({super.key, required this.titre});
  final String titre;

  @override
  State<AnnuleCommandeScreen> createState() => _AnnuleCommandeScreenState();
}

class _AnnuleCommandeScreenState extends State<AnnuleCommandeScreen> {
  List<Order> _ordersCancelled = [];
  List<Order> _ordersCancelledDaymond = [];
  bool _loading = false;
  final bool _loading2 = true;

  bool _noCnx = false;
  String controller = '';

  OrderService orderService = OrderService();

  Future<void> fetch() async {
    ApiResponse response =
        await orderService.findAll('person=client&status=canceled');
    if (response.error == null) {
      setState(() {
        _ordersCancelled = response.data as List<Order>;
        _loading = true;
        _noCnx = false;
      });
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
      });
    }
  }

  Future<void> fetchDaymond() async {
    ApiResponse response =
        await orderService.findAll('person=client&status=canceled_by_admin');
    if (response.error == null) {
      setState(() {
        _ordersCancelledDaymond = response.data as List<Order>;
        _loading = true;
        _noCnx = false;
      });
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
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
    fetchDaymond();
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
                            text: 'Par moi',
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                          child: Tab(text: 'Par Daymond'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  _loading
                      ? _ordersCancelled.isNotEmpty
                          ? CommandeProduitCard(
                              titre: 'COMMANDE ANNULEE',
                              status: 'annuleMoi',
                              orders: _ordersCancelled,
                            )
                          : const Center(
                              child: Text('Pas de commande!'),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _loading2
                      ? _ordersCancelledDaymond.isNotEmpty
                          ? CommandeProduitCard(
                              titre: 'COMMANDE ANNULEE',
                              status: 'annuleDaymond',
                              orders: _ordersCancelledDaymond,
                            )
                          : const Center(
                              child: Text('Pas de commande!'),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          )
        : kRessayer(context, () {
            controller == 'me'
                ? fetch()
                : controller == 'daymond'
                    ? fetchDaymond()
                    : print('Veillez contactez l\'administrateur!');
          });
  }
}
