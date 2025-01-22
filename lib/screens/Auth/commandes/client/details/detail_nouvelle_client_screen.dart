import 'package:distribution_frontend/models/order.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:intl/intl.dart';

//detail nouvelle
class DetailNouvelleClientScreen extends StatefulWidget {
  const DetailNouvelleClientScreen({super.key, required this.commande});
  final dynamic commande;

  @override
  State<DetailNouvelleClientScreen> createState() =>
      _DetailNouvelleClientScreenState();
}

class _DetailNouvelleClientScreenState
    extends State<DetailNouvelleClientScreen> {
  late Order _order;

  @override
  void initState() {
    super.initState();
    _order = widget.commande;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 7, top: 0),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: colorwhite,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Détail de la commande',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    width: 50,
                    child: const Divider(),
                  ),
                  _order.items[0].size != null
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 8,
                                child: Text(
                                  'Taille du produit',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(_order.items[0].size.toString()),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  //couleur
                  _order.items[0].color != null
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 8,
                                child: Text(
                                  'Couleur du produit',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(_order.items[0].color ?? ''),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  //quantite
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 8,
                          child: Text(
                            'Quantité',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('${_order.items[0].quantity} pieces'),
                        ),
                      ],
                    ),
                  ),
                  //quantite
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 8,
                          child: Text(
                            'Prix unitaire du produit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              '${NumberFormat("###,###", 'en_US').format(_order.items[0].price).replaceAll(',', ' ')}  Fr'),
                        ),
                      ],
                    ),
                  ),
                  //Livraiosn
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(
                            'Livraison ${_order.delivery.city.name}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${NumberFormat("###,###", 'en_US').format(_order.items[0].totalFees).replaceAll(',', ' ')}  Fr',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: const Divider(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 8,
                          child: Text(
                            'SOMME TOTAL',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${NumberFormat("###,###", 'en_US').format(_order.items[0].total).replaceAll(',', ' ')}  Fr',
                            style: const TextStyle(
                              fontSize: 16,
                              color: colorBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: colorwhite,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Détail de la livraison',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    width: 50,
                    child: const Divider(),
                  ),
                  //nom & livraison
                  Container(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nom',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                _order.client.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Livraison',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                _order.delivery.city.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //contact1 & contact2
                  Container(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contact 1',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '+225 ${_order.client.phoneNumber}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //contact1 & contact2
                  Container(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date de livraiosn',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                _order.delivery.date,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Heure de livraison',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                _order.delivery.time,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //motif
            Container(
              margin: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                color: colorwhite,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Table(
                defaultColumnWidth:
                    FixedColumnWidth(MediaQuery.of(context).size.width - 20),
                border: TableBorder.all(
                  color: colorwhite,
                  style: BorderStyle.solid,
                  borderRadius: BorderRadius.circular(6),
                  width: 1,
                ),
                children: [
                  TableRow(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: MediaQuery.of(context).size.width - 20,
                            height: 30,
                            child: const Text(
                              'Autres détails',
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Divider(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Text(
                          _order.detail ?? '',
                          style:
                              const TextStyle(fontSize: 18, color: colorannule),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
