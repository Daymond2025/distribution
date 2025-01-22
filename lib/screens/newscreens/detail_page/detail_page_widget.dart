import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'detail_page_model.dart';
export 'detail_page_model.dart';

class DetailPageWidget extends StatefulWidget {
  const DetailPageWidget({super.key});

  @override
  State<DetailPageWidget> createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  late DetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF7FBFE),
        appBar: AppBar(
          backgroundColor: Color(0xFFF7FBFE),
          automaticallyImplyLeading: true,
          title: Text(
            'Détails',
            style: TextStyle(
              fontFamily: 'Inter Tight',
              color: Color.fromARGB(255, 24, 24, 24),
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FBFE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://picsum.photos/seed/406/600',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Affichage du titre du produit',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      '12.000 FCFA',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF2295F0),
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFC000),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(17),
                                      topLeft: Radius.circular(17),
                                      topRight: Radius.circular(0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 5, 10, 5),
                                    child: Text(
                                      'état',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FBFE),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'INFORMATION DE LA COMMANDE',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Color.fromARGB(255, 31, 31, 31),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Couleur',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      Text(
                                        'Rouge',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color:
                                              Color.fromARGB(255, 240, 34, 34),
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quantité',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      Text(
                                        '2 Pièces',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Prix',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      Text(
                                        '92 000 FCFA',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Livraison Yamoussoukro',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      Text(
                                        'Hello World',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Color.fromARGB(255, 31, 31, 31),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'A payer',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFFF9700),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '93 500 FCFA',
                                        style: TextStyle(
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
                                        'Comission total 7500 CFA',
                                        style: TextStyle(
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FBFE),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
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
                              color: Color.fromARGB(255, 31, 31, 31),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            'LAMINIE TRAORE',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact 1',
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
                                            'LAMINIE TRAORE',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact 2',
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
                                            'LAMINIE TRAORE',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            'LAMINIE TRAORE',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            'LAMINIE TRAORE',
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FBFE),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'AUTRE DETAILS',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Color.fromARGB(255, 31, 31, 31),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Autre détails',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ].divide(SizedBox(height: 20)),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 255, 255, 255),
                    border: Border.all(
                      color: Color(0xFFE6E6E6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Annuler',
                          options: FFButtonOptions(
                            height: 40,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Color.fromARGB(255, 24, 24, 24),
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          thickness: 2,
                          color: Color.fromARGB(255, 31, 31, 31),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Modifier',
                          options: FFButtonOptions(
                            height: 40,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Color.fromARGB(255, 24, 24, 24),
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
