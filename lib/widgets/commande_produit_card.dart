import 'dart:convert';

import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details_commande_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CommandeProduitCard extends StatefulWidget {
  const CommandeProduitCard(
      {super.key,
      required this.titre,
      required this.status,
      required this.orders});
  final String titre;
  final String status;
  final List<Order> orders;

  @override
  State<CommandeProduitCard> createState() => _orderProduitCardState();
}

class _orderProduitCardState extends State<CommandeProduitCard> {
  List<Order> _orders = [];

  //show commande
  Future<void> getOrder(Order order) async {
    EasyLoading.dismiss();
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsCommandeClientScreen(
          order: order,
        ),
      ),
    );
  }

  errorAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  chargementAlert() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
      status: 'Chargement...',
      dismissOnTap: false,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("====NEWS=====");
    setState(() {
      _orders = widget.orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.only(top: 12.0, bottom: 8.0, right: 10, left: 10),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _orders.length,
        itemBuilder: (_, index) {
          String jsonString = jsonEncode(_orders.elementAt(index).toJson());
          print("=== commande ${jsonString}");
          if (_orders.elementAt(index).items.isNotEmpty) {
            return Container(
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: colorwhite,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorwhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClickProduit(
                                product:
                                    _orders.elementAt(index).items[0].product,
                              ),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(_orders
                                                .elementAt(index)
                                                .items[0]
                                                .product
                                                .images[0]))),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            child: Text(
                                              _orders
                                                  .elementAt(index)
                                                  .items[0]
                                                  .product
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              //style: Theme.of(context).textTheme.subtitle1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          widget.status == 'valide'
                                              ? Container(
                                                  padding: EdgeInsets.zero,
                                                  child: Text(
                                                    'GAIN RECU ${NumberFormat("###,###", 'en_US').format(_orders.elementAt(index).items[0].sellerCommission).replaceAll(',', ' ')}  Fr',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: colorvalid,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.zero,
                                                      child: Text(
                                                        '${NumberFormat("###,###", 'en_US').format(_orders.elementAt(index).items[0].total).replaceAll(',', ' ')}  Fr',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: colorBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 20,
                                                      child: Text(
                                                        _orders
                                                                    .elementAt(
                                                                        index)
                                                                    .items[0]
                                                                    .product
                                                                    .reducedPrice !=
                                                                null
                                                            ? '${_orders.elementAt(index).items[0].product.reducedPrice}  Fr'
                                                            : '',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  const Icon(Icons.qr_code),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${_orders.elementAt(index).updatedAtFr} \n${_orders.elementAt(index).updatedAt.substring(11, 16)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () {
                                  chargementAlert();
                                  getOrder(_orders.elementAt(index));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 2.0,
                                    left: 2.0,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: widget.status == 'nouvelle'
                                      ? const BoxDecoration(
                                          color: colorYellow2,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        )
                                      : widget.status == 'attente'
                                          ? const BoxDecoration(
                                              color: colorattente,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            )
                                          : widget.status == 'encours'
                                              ? const BoxDecoration(
                                                  color: colorBlue,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                )
                                              : widget.status == 'valide'
                                                  ? const BoxDecoration(
                                                      color: colorvalid,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5.0),
                                                      ),
                                                    )
                                                  : widget.status ==
                                                          'historique'
                                                      ? const BoxDecoration(
                                                          color:
                                                              colorhistorique,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        )
                                                      : widget.status ==
                                                              'annuleMoi'
                                                          ? const BoxDecoration(
                                                              color:
                                                                  colorannule,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                            )
                                                          : widget.status ==
                                                                  'annuleDaymond'
                                                              ? const BoxDecoration(
                                                                  color:
                                                                      colorannule,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                )
                                                              : const BoxDecoration(
                                                                  color:
                                                                      colorYellow2,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                ),
                                  child: const Text(
                                    'Voir les détails',
                                    style: TextStyle(
                                        fontSize: 15, color: colorwhite),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: <Widget>[
                        _orders.elementAt(index).items[0].product.star == 1
                            ? Container(
                                padding: const EdgeInsets.only(right: 5),
                              )
                            : Container(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: const BoxDecoration(
                            color: colorYellow,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            _orders
                                .elementAt(index)
                                .items[0]
                                .product
                                .state
                                .name,
                            style: const TextStyle(
                              color: colorblack,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*_order['trocs'] != null
                    ? Positioned(
                        top: 30,
                        right: 0,
                        child: Image.asset('assets/images/trocs_1.png', width: 30, height: 30,),
                      )
                    : Container(),*/
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
