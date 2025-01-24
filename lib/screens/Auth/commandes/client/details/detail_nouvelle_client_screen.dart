import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'INFORMATION DE LA COMMANDE',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
