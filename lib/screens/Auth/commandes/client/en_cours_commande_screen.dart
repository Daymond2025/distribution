import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/commande_produit_card.dart';
import 'package:flutter/material.dart';

class EnCoursCommandeScreen extends StatefulWidget {
  const EnCoursCommandeScreen({super.key, required this.titre});
  final String titre;

  @override
  State<EnCoursCommandeScreen> createState() => _EnCoursCommandeScreenState();
}

class _EnCoursCommandeScreenState extends State<EnCoursCommandeScreen> {
  List<Order> _orders = [];
  bool _loading = false;
  bool _noCnx = false;
  OrderService orderService = OrderService();

  Future<void> fetch() async {
    ApiResponse response =
        await orderService.findAll('person=client&status=in_progress');
    if (response.error == null) {
      setState(() {
        _orders = response.data as List<Order>;
        _loading = true;
        _noCnx = false;
      });
      print("les commandes $_orders");
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
    print("=====EN COURS=====");
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            appBar: AppBar(
              backgroundColor: colorwhite,
              elevation: 0.9,
              iconTheme: const IconThemeData(
                color: colorblack,
              ),
              title: const Text(
                'Commande en cours',
                style: TextStyle(
                  color: colorBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            body: _loading
                ? _orders.isNotEmpty
                    ? CommandeProduitCard(
                        titre: 'Commandes en cours',
                        status: 'encours',
                        orders: _orders,
                      )
                    : const Center(
                        child: Text('Pas de commandes!'),
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
