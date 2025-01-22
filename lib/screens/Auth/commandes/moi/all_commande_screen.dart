import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details_commande_moi.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:distribution_frontend/services/commande_service.dart';

class AllCommandeScreen extends StatefulWidget {
  const AllCommandeScreen({
    super.key,
  });

  @override
  State<AllCommandeScreen> createState() => _AllCommandeScreenState();
}

class _AllCommandeScreenState extends State<AllCommandeScreen> {
  List<Order> orders = [];
  bool _isLoading = true;

  String tp = '';

  Future<void> listCommandeMoi() async {
    setState(() {
      _isLoading = true;
    });

    ApiResponse response = await getToutCommandeMoi();
    if (response.error == null) {
      if (mounted) {
        setState(() {
          orders = response.data as List<Order>;
          _isLoading = false;
        });
      }
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _isLoading = !_isLoading;
    //listCommandeMoi();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await listCommandeMoi();
        setState(() {});
      },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orders.isEmpty
              ? const Center(
                  child: Text('Aucune commande disponible'),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 8.0, right: 10, left: 10),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (_, index) {
                        String createdAt = orders.elementAt(index).createdAt;

                        // Convertir la date en différence de temps
                        DateTime maDate = DateTime.parse(createdAt);
                        Duration difference = DateTime.now().difference(maDate);

                        // Déterminer quelle unité de temps afficher en fonction de la différence
                        String timeDifference = '';
                        int mois = difference.inDays ~/ 30;
                        int annees = difference.inDays ~/ 365;
                        if (annees > 0) {
                          timeDifference = '$annees ans';
                        } else if (mois > 0) {
                          timeDifference = '$mois mois';
                        } else if (difference.inDays > 0) {
                          timeDifference = '${difference.inDays} jours';
                        } else if (difference.inHours > 0) {
                          timeDifference = '${difference.inHours} heure';
                        } else if (difference.inMinutes > 0) {
                          timeDifference = '${difference.inMinutes} min';
                        } else {
                          timeDifference = '${difference.inSeconds} sec';
                        }
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: colorwhite,
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: colorwhite,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  bottom: 2,
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: colorwhite,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              child:
                                                                  Image.network(
                                                                orders
                                                                    .elementAt(
                                                                        index)
                                                                    .items[0]
                                                                    .product
                                                                    .images[0]
                                                                    .img,
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                child: Text(
                                                                  orders
                                                                      .elementAt(
                                                                          index)
                                                                      .items[0]
                                                                      .product
                                                                      .name,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    child: Text(
                                                                      '${orders.elementAt(index).items[0].product.price.price} F CFA',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        color:
                                                                            colorBlue,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        280,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      child:
                                                                          Text(
                                                                        'Il y\'a $timeDifference',
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 5,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              30,
                                                      height: 1,
                                                      color: Colors.black12,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              bottom: 5),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 8,
                                                            child: orders
                                                                        .elementAt(
                                                                            index)
                                                                        .status ==
                                                                    0
                                                                ? const SizedBox(
                                                                    child: Text(
                                                                      'En préparation...',
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorBlue,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  )
                                                                : orders.elementAt(index).status ==
                                                                        2
                                                                    ? const SizedBox(
                                                                        child:
                                                                            Text(
                                                                          'En route...',
                                                                          style: TextStyle(
                                                                              color: colorBlue,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      )
                                                                    : orders.elementAt(index).status ==
                                                                            3
                                                                        ? const SizedBox(
                                                                            child:
                                                                                Text(
                                                                              'Terminer',
                                                                              style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          )
                                                                        : orders.elementAt(index).status ==
                                                                                5
                                                                            ? const SizedBox(
                                                                                child: Text(
                                                                                  'Annuler',
                                                                                  style: TextStyle(color: colorannule, fontSize: 14, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              )
                                                                            : const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                          ),
                                                          Expanded(
                                                            flex: 4,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              DetailsCommandeMoi(
                                                                                order: orders.elementAt(index),
                                                                              )),
                                                                );
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 5.0,
                                                                  bottom: 5.0,
                                                                  right: 2.0,
                                                                  left: 2.0,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: orders
                                                                            .elementAt(
                                                                                index)
                                                                            .status ==
                                                                        0
                                                                    ? const BoxDecoration(
                                                                        color:
                                                                            colorYellow,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              4.0),
                                                                        ),
                                                                      )
                                                                    : orders.elementAt(index).status ==
                                                                            2
                                                                        ? const BoxDecoration(
                                                                            color:
                                                                                colorBlue,
                                                                            borderRadius:
                                                                                BorderRadius.all(
                                                                              Radius.circular(4.0),
                                                                            ),
                                                                          )
                                                                        : orders.elementAt(index).status ==
                                                                                3
                                                                            ? const BoxDecoration(
                                                                                color: colorvalid,
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(4.0),
                                                                                ),
                                                                              )
                                                                            : orders.elementAt(index).status == 5
                                                                                ? const BoxDecoration(
                                                                                    color: colorannule,
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(4.0),
                                                                                    ),
                                                                                  )
                                                                                : const BoxDecoration(
                                                                                    color: colorYellow2,
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(4.0),
                                                                                    ),
                                                                                  ),
                                                                child:
                                                                    const Text(
                                                                  'Voir les détails',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          colorwhite),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Positioned(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        orders
                                                    .elementAt(index)
                                                    .items[0]
                                                    .product
                                                    .star ==
                                                1
                                            ? Container(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Image.asset(
                                                  'assets/images/star.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                            left: 5,
                                            top: 2,
                                            bottom: 2,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: colorYellow,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topRight: Radius.circular(6),
                                            ),
                                          ),
                                          child: Text(
                                            orders
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
