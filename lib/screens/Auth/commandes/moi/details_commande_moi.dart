import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details/detail_nouvelle_moi_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details/detail_encours_moi_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details/detail_valide_moi_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details/detail_annule_daymond_moi_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';

import 'package:flutter/material.dart';

class DetailsCommandeMoi extends StatefulWidget {
  const DetailsCommandeMoi({
    super.key,
    required this.order,
  });
  final Order order;

  @override
  State<DetailsCommandeMoi> createState() => _DetailsCommandeMoiState();
}

class _DetailsCommandeMoiState extends State<DetailsCommandeMoi> {
  dynamic _order = '';

  Future<void> _vueCommande(int id) async {
    ApiResponse response = await vueCommandez(id);
    if (response.error == null) {
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _vueCommande(widget.order.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _order['troc'] == null
          ? colorwhite
          : const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        backgroundColor: colorwhite,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: colorblack,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: _order['status'] == 0
            ? const Text(
                'Ma commande en préparation',
                style: TextStyle(
                  color: colorblack,
                  fontSize: 19,
                ),
              )
            : _order['status'] == 2
                ? const Text(
                    'Ma commande en route',
                    style: TextStyle(
                      color: colorblack,
                    ),
                  )
                : _order['status'] == 3
                    ? const Text(
                        'Ma commande terminée',
                        style: TextStyle(
                          color: colorblack,
                        ),
                      )
                    : _order['status'] == 5
                        ? const Text(
                            'Ma commande annulée',
                            style: TextStyle(
                              color: colorblack,
                            ),
                          )
                        : Container(),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            alignment: Alignment.center,
            child: Text(
              _order['status'] == 0
                  ? _order['created_at'].substring(11, 16)
                  : _order['status'] == 1
                      ? _order['heure_attente'] != null
                          ? _order['heure_attente'].substring(0, 5)
                          : ''
                      : _order['status'] == 2
                          ? _order['heure_encours'] != null
                              ? _order['heure_encours'].substring(0, 5)
                              : ''
                          : _order['status'] == 3
                              ? _order['heure_valide'] != null
                                  ? _order['heure_valide'].substring(0, 5)
                                  : ''
                              : _order['heure_annule'] != null
                                  ? _order['heure_annule'].substring(0, 5)
                                  : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
          ),
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //DETAIL COMMANDE ATTENTE
              widget.order.status == 0
                  ? DetailNouvelleMoiScreen(order: _order)
                  : //DETAIL COMMANDE EN COURS
                  widget.order.status == 2
                      ? DetailEncoursMoiScreen(order: _order)
                      : //DETAIL COMMANDE VALIDE
                      widget.order.status == 3
                          ? DetailValideMoiScreen(order: _order)
                          : //DETAIL COMMANDE ANNULE Daymond
                          widget.order.status == 5
                              ? DetailAnnuleDaymondMoiScreen(order: _order)
                              : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
