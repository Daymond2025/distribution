import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/annulation/annule_nouvelle_commande_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/renvoie/formulaire_renvoie_commande_annule_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/update/formulaire_update_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/messages/add_new_conversation_screen.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/produit_similaire_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/recent_vendu_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
import 'package:distribution_frontend/screens/newscreens/orderSheet/order_sheet_widget.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_nouvelle_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_attente_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_encours_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_valide_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_annule_daymond_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_annule_moi_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details/detail_troc_client_screen.dart';

class DetailsCommandeClientScreen extends StatefulWidget {
  const DetailsCommandeClientScreen({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<DetailsCommandeClientScreen> createState() =>
      _DetailsCommandeClientScreenState();
}

class _DetailsCommandeClientScreenState
    extends State<DetailsCommandeClientScreen> {
  ProfileService profileService = ProfileService();

  late Order _order;

  List<Profile> _profiles = [];
  late Profile _profile;

  showInfos(Order order) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ajuste la hauteur en fonction du contenu
                children: [
                  OrderSheetWidget(statut: order.status, order: order),
                  // Container()
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //message
  Future<void> getProfiles() async {
    ApiResponse response = await profileService.getProfile();
    if (response.error == null) {
      setState(() {
        _profiles = response.data as List<Profile>;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

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

  void _showConversation() async {
    final List<int>? results = await showDialog(
      context: context,
      builder: (BuildContext context) => AddNewConversationScreen(
        profile: _profile,
        idCategory: _order.id.toString(),
        category: 'order',
      ),
    );

    if (results != null) {
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    print("===order status : ${_order.status}");
    _vueCommande(widget.order.id);
    if (widget.order.status == 5 || widget.order.status == 5) {
      getProfiles();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_order.status != 'new') {
        showInfos(_order);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: AppBar(
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
        title: const Text(
          'Détails',
          style: TextStyle(
            color: colorblack,
          ),
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            alignment: Alignment.center,
            child: Text(
              ['news, postpone, confirm', 'dont_pick_up']
                      .contains(_order.status)
                  ? _order.createdAtFr
                  : _order.status == 'pending'
                      ? _order.pending!.time!
                      : _order.status == 'in_progress'
                          ? _order.inProgress!.time!
                          : _order.status == 'validated'
                              ? _order.validated!.time!
                              : _order.status == 'cancelled'
                                  ? _order.canceled!.time!
                                  : _order.createdAtFr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: const BoxDecoration(
                          color: colorwhite,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(78, 158, 158, 158),
                              blurRadius: 5,
                              offset: Offset(1, 2),
                            ),
                            BoxShadow(
                              color: Color.fromARGB(75, 158, 158, 158),
                              blurRadius: 5,
                              offset: Offset(2, 1),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClickProduit(
                                product: _order.items[0].product,
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
                                            image: NetworkImage(_order
                                                .items[0].product.images[0]))),
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                                              _order.items[0].product.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              //style: Theme.of(context).textTheme.subtitle1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.zero,
                                                  child: Text(
                                                    '${NumberFormat("###,###", 'en_US').format(_order.items[0].product.price.price).replaceAll(',', ' ')}  Fr',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: colorBlue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 20,
                                                child: Text(
                                                  _order.items[0].product
                                                              .reducedPrice !=
                                                          null
                                                      ? '${_order.items[0].product.reducedPrice}  Fr'
                                                      : '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    decoration: TextDecoration
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
                      Positioned(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            _order.items[0].product.star == 1
                                ? const Icon(
                                    Icons.star,
                                    color: colorYellow,
                                    size: 18,
                                  )
                                : Container(),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: const BoxDecoration(
                                color: colorYellow,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                              ),
                              child: Text(
                                _order.items[0].product.state.name,
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
                  //DETAIL COMMANDE TROC
                  // ['news, postpone, confirm', 'dont_pick_up']
                  //         .contains(_order.status)
                  // ? //DETAIL COMMANDE NOUVELLE
                  DetailNouvelleClientScreen(
                    commande: _order,
                  )
                  // : //DETAIL COMMANDE ATTENTE
                  // _order.status == 'pending'
                  //     ? DetailNouvelleClientScreen(
                  //         commande: _order,
                  //       )
                  //     : //DETAIL COMMANDE EN COURS
                  //     _order.status == 'in_progress'
                  //         ? DetailEncoursClientScreen(
                  //             commande: _order,
                  //           )
                  //         : //DETAIL COMMANDE VALIDER
                  //         _order.status == 'validated'
                  //             ? DetailValideClientScreen(
                  //                 commande: _order,
                  //               )
                  //             : //DETAIL COMMANDE ANNULE MOI
                  //             _order.status == 'cancelled'
                  //                 ? DetailAnnuleMoiClientScreen(
                  //                     commande: _order,
                  //                   )
                  //                 : //DETAIL COMMANDE ANNULE DAYMOND
                  //                 _order.status == 'cancelled_by_admin'
                  //                     ? DetailAnnuleDaymondClientScreen(
                  //                         commande: _order,
                  //                       )
                  //                     : DetailNouvelleClientScreen(
                  //                         commande: _order,
                  //                       )
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomSheet:

      //DETAIL COMMANDE ATTENTE
      // _order.status == 'pending'
      //     ? Container(
      //         color: colorwhite,
      //         height: 40,
      //         child: InkWell(
      //           onTap: () => Navigator.of(context).pop(),
      //           child: Container(
      //             padding: EdgeInsets.zero,
      //             child: Row(
      //               children: <Widget>[
      //                 Expanded(
      //                   flex: 1,
      //                   child: Container(
      //                     padding: const EdgeInsets.only(
      //                       top: 10,
      //                       bottom: 10,
      //                     ),
      //                     margin: const EdgeInsets.only(
      //                         bottom: 10, left: 10, right: 10),
      //                     decoration: const BoxDecoration(
      //                       color: colorattente,
      //                       borderRadius: BorderRadius.all(
      //                         Radius.circular(6),
      //                       ),
      //                     ),
      //                     child: const Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Text(
      //                           'OK',
      //                           style: TextStyle(
      //                             color: colorwhite,
      //                             fontSize: 14,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     : //DETAIL COMMANDE VALIDE
      //     _order.status == 'validated'
      //         ? Container(
      //             color: colorwhite,
      //             height: 50,
      //             child: InkWell(
      //               onTap: () => Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => const PortefeuilleScreen(),
      //                 ),
      //               ),
      //               child: Container(
      //                 padding: EdgeInsets.zero,
      //                 child: Row(
      //                   children: <Widget>[
      //                     Expanded(
      //                       flex: 1,
      //                       child: Container(
      //                         padding: const EdgeInsets.only(
      //                           top: 10,
      //                           bottom: 10,
      //                         ),
      //                         margin: const EdgeInsets.only(
      //                             bottom: 10, left: 10, right: 10),
      //                         decoration: const BoxDecoration(
      //                           color: colorvalid,
      //                           borderRadius: BorderRadius.all(
      //                             Radius.circular(6),
      //                           ),
      //                         ),
      //                         child: const Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.center,
      //                           children: [
      //                             Text(
      //                               'CONSULTER MON PORTEFEUILLE',
      //                               style: TextStyle(
      //                                 color: colorwhite,
      //                                 fontSize: 14,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           )
      //         : //DETAIL COMMANDE EN COURS
      //         _order.status == 'in_progress'
      //             ? Container(
      //                 decoration: const BoxDecoration(
      //                   border: Border(
      //                     top: BorderSide(
      //                       width: 1,
      //                       color: Colors.transparent,
      //                     ),
      //                   ),
      //                 ),
      //                 height: 40,
      //                 alignment: Alignment.center,
      //                 child: Row(
      //                   children: [
      //                     Expanded(
      //                       flex: 1,
      //                       child: InkWell(
      //                         splashColor: colorBlue100,
      //                         onTap: (() => Navigator.of(context).pop()),
      //                         child: Container(
      //                           width:
      //                               MediaQuery.of(context).size.width / 2,
      //                           alignment: Alignment.center,
      //                           child: const Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.center,
      //                             children: <Widget>[
      //                               SizedBox(
      //                                 width: 5,
      //                               ),
      //                               Text(
      //                                 'Retour à la liste',
      //                                 style: TextStyle(
      //                                   fontSize: 15,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     Container(
      //                       height: 20,
      //                       width: 2,
      //                       color: colorfond,
      //                     ),
      //                     Expanded(
      //                       flex: 1,
      //                       child: InkWell(
      //                         splashColor: colorBlue100,
      //                         onTap: () => Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) =>
      //                                 ProduitSimilaireScreen(
      //                               id: _order
      //                                   .items[0].product.subCategoryId,
      //                             ),
      //                           ),
      //                         ),
      //                         child: Container(
      //                           width:
      //                               MediaQuery.of(context).size.width / 2,
      //                           alignment: Alignment.center,
      //                           child: const Text(
      //                             'Produits similaires',
      //                             style: TextStyle(
      //                               fontSize: 15,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               )
      //             : //DETAIL COMMANDE ANNULE MOI
      //             _order.status == 'cancelled'
      //                 ? Container(
      //                     decoration: const BoxDecoration(
      //                       border: Border(
      //                         top: BorderSide(
      //                           width: 2,
      //                           color: colorfond,
      //                         ),
      //                       ),
      //                     ),
      //                     height: 40,
      //                     alignment: Alignment.center,
      //                     child: Row(
      //                       children: [
      //                         Expanded(
      //                           flex: 1,
      //                           child: InkWell(
      //                             onTap: () => Navigator.pop(context),
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               width: MediaQuery.of(context)
      //                                       .size
      //                                       .width /
      //                                   2,
      //                               child:
      //                                   const Text('Retour à la liste'),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   )
      //                 : //DETAIL COMMANDE ANNULE DAYMOND
      //                 _order.status == 'cancelled_by_admin'
      //                     ? Container(
      //                         decoration: const BoxDecoration(
      //                           border: Border(
      //                             top: BorderSide(
      //                               width: 2,
      //                               color: colorfond,
      //                             ),
      //                           ),
      //                         ),
      //                         height: 40,
      //                         alignment: Alignment.center,
      //                         child: Row(
      //                           children: [
      //                             Expanded(
      //                               flex: 1,
      //                               child: InkWell(
      //                                 onTap: () => Navigator.pop(context),
      //                                 child: Container(
      //                                   alignment: Alignment.center,
      //                                   width: MediaQuery.of(context)
      //                                           .size
      //                                           .width /
      //                                       2,
      //                                   child: const Text(
      //                                       'Retour à la liste'),
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       )
      //                     : Container(
      //                         height: 0,
      //                         width: double.infinity,
      //                         decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           border: Border.all(
      //                             color: Color(0xFFE6E6E6),
      //                           ),
      //                         ),
      //                         child: Row(
      //                           mainAxisSize: MainAxisSize.max,
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.center,
      //                           children: [
      //                             Expanded(
      //                               child: FFButtonWidget(
      //                                 onPressed: () {
      //                                   Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                       builder: (context) =>
      //                                           AnnuleNouvelleComandeClientScreen(
      //                                               id: _order.id),
      //                                     ),
      //                                   );
      //                                 },
      //                                 text: 'Annuler',
      //                                 options: FFButtonOptions(
      //                                   height: 40,
      //                                   padding: EdgeInsetsDirectional
      //                                       .fromSTEB(16, 0, 16, 0),
      //                                   iconPadding: EdgeInsetsDirectional
      //                                       .fromSTEB(0, 0, 0, 0),
      //                                   color: Colors.white,
      //                                   textStyle: FlutterFlowTheme.of(
      //                                           context)
      //                                       .titleSmall
      //                                       .override(
      //                                         fontFamily: 'Inter Tight',
      //                                         color: FlutterFlowTheme.of(
      //                                                 context)
      //                                             .primaryText,
      //                                         letterSpacing: 0.0,
      //                                       ),
      //                                   elevation: 0,
      //                                   borderRadius:
      //                                       BorderRadius.circular(8),
      //                                 ),
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: 50,
      //                               child: VerticalDivider(
      //                                   thickness: 2, color: Colors.grey),
      //                             ),
      //                             Expanded(
      //                               child: FFButtonWidget(
      //                                 onPressed: () {
      //                                   print(
      //                                       'PRODUIT TYPE ${_order.items[0].product.type}');
      //                                   Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                         builder: (context) =>
      //                                             FormulaireUpdateCommandeScreen(
      //                                               id: _order.id,
      //                                               commande: _order,
      //                                               typeProduit: _order
      //                                                   .items[0]
      //                                                   .product
      //                                                   .type,
      //                                               idProduit: _order
      //                                                   .items[0]
      //                                                   .product
      //                                                   .id,
      //                                             )),
      //                                   );
      //                                 },
      //                                 text: 'Modifier',
      //                                 options: FFButtonOptions(
      //                                   height: 40,
      //                                   padding: EdgeInsetsDirectional
      //                                       .fromSTEB(16, 0, 16, 0),
      //                                   iconPadding: EdgeInsetsDirectional
      //                                       .fromSTEB(0, 0, 0, 0),
      //                                   color: Colors.white,
      //                                   textStyle: FlutterFlowTheme.of(
      //                                           context)
      //                                       .titleSmall
      //                                       .override(
      //                                         fontFamily: 'Inter Tight',
      //                                         color: FlutterFlowTheme.of(
      //                                                 context)
      //                                             .primaryText,
      //                                         letterSpacing: 0.0,
      //                                       ),
      //                                   elevation: 0,
      //                                   borderRadius:
      //                                       BorderRadius.circular(8),
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       )
    );
  }
}
