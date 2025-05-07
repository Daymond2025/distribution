import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/annulation/annule_nouvelle_commande_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/update/formulaire_update_commande_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
import 'package:distribution_frontend/screens/newscreens/orderSheet/order_sheet_widget.dart';
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
    print("statut de la commande : ${_order.status}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_order.status == 'new') {
        showBas();
      }
    });
  }

  showBas() async {
    await showBottomSheet(
      context: context,
      // isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              // height: 150,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ajuste la hauteur en fonction du contenu
                children: [
                  Container(
                    // height: 0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AnnuleNouvelleComandeClientScreen(
                                          id: _order.id),
                                ),
                              );
                            },
                            text: 'Annuler',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child:
                              VerticalDivider(thickness: 2, color: Colors.grey),
                        ),
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () {
                              print(
                                  'PRODUIT TYPE ${_order.items[0].product.type}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FormulaireUpdateCommandeScreen(
                                          id: _order.id,
                                          commande: _order,
                                          typeProduit:
                                              _order.items[0].product.type,
                                          idProduit: _order.items[0].product.id,
                                        )),
                              );
                            },
                            text: 'Modifier',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  // Container()
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  showInfos(Order order, String status) async {
    print("order status : ${status}");
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
                  OrderSheetWidget(statut: status, order: order),
                  // Container()
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            children: [
              // Generated code for this commande Widget...
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(
                          0,
                          2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'INFORMATIONS DE LA COMMANDE',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: const Color.fromARGB(255, 233, 233, 233),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _order.items[0].color != null
                                ? Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7FBFE),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Couleur',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            'Rouge',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            _order.items[0].size != null
                                ? Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7FBFE),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Taille',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            'Rouge',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Quantité',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '${_order.items[0].quantity} Pièce(s)',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Prix',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '${NumberFormat("###,###", 'en_US').format(_order.items[0].price).replaceAll(',', ' ')}  Fr',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Livraison ${_order.delivery.city.name}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '${NumberFormat("###,###", 'en_US').format(_order.items[0].totalFees).replaceAll(',', ' ')}  Fr',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: const Color.fromARGB(255, 233, 233, 233),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'A payer',
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFFFF9700),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '${NumberFormat("###,###", 'en_US').format(_order.items[0].total).replaceAll(',', ' ')}  Fr',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFFFF9700),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Comission total ${NumberFormat("###,###", 'en_US').format(_order.items[0].orderCommission).replaceAll(',', ' ')} Fr',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFFFF9700),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Generated code for this livraison Widget...
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(
                          0,
                          2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'INFORMATION DE LIVRAISON',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: const Color.fromARGB(255, 233, 233, 233),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nom à mettre sur la facture',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF8D8D8D),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      _order.client.name,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF8D8D8D),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '+225 ${_order.client.phoneNumber}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lieu de livraison',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF8D8D8D),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      _order.delivery.city.name,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FBFE),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date de livraison',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF8D8D8D),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '${_order.delivery.date} ${_order.delivery.time}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ),
                    ],
                  ),
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
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(
                        0,
                        2,
                      ),
                    )
                  ],
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
                                'AUTRES DETAILS',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    // fontSize: 20,
                                    // color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                            style: const TextStyle(
                                fontSize: 18, color: colorannule),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Row(
                  children: [
                    Text('Historique'),
                  ],
                ),
              ),

              Column(
                children: [
                  Visibility(
                    visible: _order.pending?.date != null,
                    child: InkWell(
                      onTap: () {
                        showInfos(widget.commande, 'pending');
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Commande mise En attente",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                "${_order.pending?.date}  à ${_order.pending?.time}",
                                style: TextStyle(fontSize: 9),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _order.inProgress?.date != null,
                    child: InkWell(
                      onTap: () {
                        showInfos(widget.commande, 'in_progress');
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Commande mise En Cours",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                "${_order.inProgress?.date}  à ${_order.inProgress?.time}",
                                style: TextStyle(fontSize: 9),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _order.canceled?.date != null,
                    child: InkWell(
                      onTap: () {
                        showInfos(widget.commande, 'canceled');
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Commande mise En Annulé",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                "${_order.canceled?.date}  à ${_order.canceled?.time}",
                                style: TextStyle(fontSize: 9),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _order.validated?.date != null,
                    child: InkWell(
                      onTap: () {
                        showInfos(widget.commande, 'validated');
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Commande mise En Validé",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                "${_order.validated?.date}  à ${_order.validated?.time}",
                                style: TextStyle(fontSize: 9),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ].divide(SizedBox(height: 10)),
              ),
            ],
          ),
        ),
      ),
      // _order.status == 'new'
      //     ? Align(
      //         alignment: AlignmentDirectional(0, 1),
      //         child: Container(
      //           // height: 150,
      //           padding: EdgeInsets.all(16.0),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      //           ),
      //           child: Column(
      //             mainAxisSize: MainAxisSize
      //                 .min, // Ajuste la hauteur en fonction du contenu
      //             children: [
      //               Container(
      //                 // height: 0,
      //                 width: double.infinity,
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   border: Border.all(
      //                     color: Color(0xFFE6E6E6),
      //                   ),
      //                 ),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Expanded(
      //                       child: FFButtonWidget(
      //                         onPressed: () {
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                               builder: (context) =>
      //                                   AnnuleNouvelleComandeClientScreen(
      //                                       id: _order.id),
      //                             ),
      //                           );
      //                         },
      //                         text: 'Annuler',
      //                         options: FFButtonOptions(
      //                           height: 40,
      //                           padding: EdgeInsetsDirectional.fromSTEB(
      //                               16, 0, 16, 0),
      //                           iconPadding:
      //                               EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      //                           color: Colors.white,
      //                           textStyle: FlutterFlowTheme.of(context)
      //                               .titleSmall
      //                               .override(
      //                                 fontFamily: 'Inter Tight',
      //                                 color: FlutterFlowTheme.of(context)
      //                                     .primaryText,
      //                                 letterSpacing: 0.0,
      //                               ),
      //                           elevation: 0,
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 50,
      //                       child: VerticalDivider(
      //                           thickness: 2, color: Colors.grey),
      //                     ),
      //                     Expanded(
      //                       child: FFButtonWidget(
      //                         onPressed: () {
      //                           print(
      //                               'PRODUIT TYPE ${_order.items[0].product.type}');
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                                 builder: (context) =>
      //                                     FormulaireUpdateCommandeScreen(
      //                                       id: _order.id,
      //                                       commande: _order,
      //                                       typeProduit:
      //                                           _order.items[0].product.type,
      //                                       idProduit:
      //                                           _order.items[0].product.id,
      //                                     )),
      //                           );
      //                         },
      //                         text: 'Modifier',
      //                         options: FFButtonOptions(
      //                           height: 40,
      //                           padding: EdgeInsetsDirectional.fromSTEB(
      //                               16, 0, 16, 0),
      //                           iconPadding:
      //                               EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      //                           color: Colors.white,
      //                           textStyle: FlutterFlowTheme.of(context)
      //                               .titleSmall
      //                               .override(
      //                                 fontFamily: 'Inter Tight',
      //                                 color: FlutterFlowTheme.of(context)
      //                                     .primaryText,
      //                                 letterSpacing: 0.0,
      //                               ),
      //                           elevation: 0,
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               )
      //               // Container()
      //             ],
      //           ),
      //         ),
      //       )
      //     : Container(),
    ]);
  }
}
