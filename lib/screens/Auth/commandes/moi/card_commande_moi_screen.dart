import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details_commande_moi.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class CardCommandeMoiScreen extends StatefulWidget {
  const CardCommandeMoiScreen({
    super.key,
    required this.status,
  });

  final String status;

  @override
  State<CardCommandeMoiScreen> createState() => _CardCommandeMoiScreenState();
}

class _CardCommandeMoiScreenState extends State<CardCommandeMoiScreen> {
  List<dynamic> commandes = [];
  bool _isLoading = true;
  int _status = 0;

  String tp = '';
  Future<void> listCommandeMoi() async {
    setState(() {
      _isLoading = true;
    });

    ApiResponse response = await getCommandeMoi(1);
    if (response.error == null) {
      if (mounted) {
        setState(() {
          commandes = response.data as List<dynamic>;
          _isLoading = false;
        });
      }
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
      _status = 1;
    });
    //listCommandeMoi();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        //await listCommandeMoi();
        setState(() {});
      },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : commandes.isEmpty
              ? const Center(
                  child: Text('Aucune commande disponible '),
                )
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 10, left: 10),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: commandes.length,
                          itemBuilder: (_, index) {
                            String createdAt =
                                commandes.elementAt(index)['created_at'];

                            DateTime maDate = DateTime.parse(createdAt);
                            Duration difference =
                                DateTime.now().difference(maDate);

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
                              timeDifference = '${difference.inHours} heures';
                            } else if (difference.inMinutes > 0) {
                              timeDifference =
                                  '${difference.inMinutes} minutes';
                            } else {
                              timeDifference =
                                  '${difference.inSeconds} secondes';
                            }
                            return Column(
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
                                      child: Stack(
                                        children: [
                                          Column(
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
                                                                commandes
                                                                            .elementAt(index)['produit']['photoprods']
                                                                            .length ==
                                                                        0
                                                                    ? imgProdDefault
                                                                    : '${commandes.elementAt(index)['produit']['photoprods'][0]['photo']}',
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
                                                                  '${commandes.elementAt(index)['produit']['nom']}',
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
                                                                      commandes.elementAt(index)['produit']['type'] ==
                                                                              'commission'
                                                                          ? '${commandes.elementAt(index)['produit']['prix_vente']} F CFA'
                                                                          : commandes.elementAt(index)['produit']['type'] == 'grossiste'
                                                                              ? '${commandes.elementAt(index)['produit']['prix_grossiste_unitaire']} F CFA'
                                                                              : '${commandes.elementAt(index)['produit']['prix_louer']} F CFA',
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
                                                                        310,
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
                                                        top: 5,
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
                                                            child: _status == 0
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
                                                                : _status == 2
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
                                                                    : _status ==
                                                                            3
                                                                        ? const SizedBox(
                                                                            child:
                                                                                Text(
                                                                              'Terminer',
                                                                              style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          )
                                                                        : _status ==
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
                                                                                order: commandes.elementAt(index),
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
                                                                decoration: _status ==
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
                                                                    : _status ==
                                                                            2
                                                                        ? const BoxDecoration(
                                                                            color:
                                                                                colorBlue,
                                                                            borderRadius:
                                                                                BorderRadius.all(
                                                                              Radius.circular(4.0),
                                                                            ),
                                                                          )
                                                                        : _status ==
                                                                                3
                                                                            ? const BoxDecoration(
                                                                                color: colorvalid,
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(4.0),
                                                                                ),
                                                                              )
                                                                            : _status == 5
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
                                          ),
                                          Positioned(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                commandes.elementAt(
                                                            index)['troc'] ==
                                                        null
                                                    ? const SizedBox()
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Image.asset(
                                                          'assets/images/trocs_1.png',
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                commandes.elementAt(index)[
                                                                'produit']
                                                            ['etoile'] ==
                                                        1
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Image.asset(
                                                          'assets/images/star.png',
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                      )
                                                    : Container(),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 5,
                                                    left: 5,
                                                    top: 2,
                                                    bottom: 2,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: colorYellow,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(6),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    '${commandes.elementAt(index)['produit']['etat']['nom']}',
                                                    style: const TextStyle(
                                                      color: colorblack,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                )
                              ],
                            );
                          })),
                ),
    );
  }
}
