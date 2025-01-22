import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/commande_produit_card.dart';
import 'package:flutter/material.dart';

class ValideCommandeScreen extends StatefulWidget {
  const ValideCommandeScreen({super.key, required this.titre});
  final String titre;

  @override
  State<ValideCommandeScreen> createState() => _ValideCommandeScreenState();
}

class _ValideCommandeScreenState extends State<ValideCommandeScreen> {
  List<Order> _orders = [];

  bool _loading = false;
  bool _noCnx = false;

  OrderService orderService = OrderService();

  Future<void> fetch() async {
    ApiResponse response =
        await orderService.findAll('person=client&status=validated');
    if (response.error == null) {
      setState(() {
        _orders = response.data as List<Order>;
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
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
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
            ),
            body: _loading
                ? _orders.isNotEmpty
                    ? CommandeProduitCard(
                        titre: 'Commandes validées',
                        status: 'valide',
                        orders: _orders,
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
                            const Text('Pas de commande validée'),
                          ],
                        ),
                      )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        : kRessayer(context, () {
            fetch();
          });
  }
}
