import 'package:country_flags/country_flags.dart';
import 'package:distribution_frontend/models/country.dart';

import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'pays_popup_model.dart';
export 'pays_popup_model.dart';

class PaysPopupWidget extends StatefulWidget {
  const PaysPopupWidget({
    super.key,
    this.pays,
    this.paysChoisi,
    required this.onDataChanged,
  });

  final List<dynamic>? pays;
  final dynamic paysChoisi;
  final Function(Country) onDataChanged;

  @override
  State<PaysPopupWidget> createState() => _PaysPopupWidgetState();
}

class _PaysPopupWidgetState extends State<PaysPopupWidget> {
  late PaysPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaysPopupModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF7FBFE),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(
              0,
              -2,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Text(
                    'Choisir ton pays',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 20),
            child: Builder(
              builder: (context) {
                final pays = widget!.pays?.toList() ?? [];

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: pays.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10),
                  itemBuilder: (context, paysIndex) {
                    final paysItem = pays[paysIndex];
                    // print(paysItem.flag);
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          // FFAppState().pays = paysItem;
                          widget.onDataChanged(paysItem);
                          safeSetState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: (widget!.paysChoisi != null) &&
                                    (getJsonField(
                                          widget!.paysChoisi,
                                          r'''$.id''',
                                        ) ==
                                        getJsonField(
                                          paysItem,
                                          r'''$.id''',
                                        ))
                                ? Color(0xFFFF9000)
                                : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CountryFlag.fromCountryCode(
                                  paysItem.code,
                                  width: 60,
                                  height: 60,
                                  shape: const Circle(),
                                )
                                // Container(
                                //   width: 80,
                                //   height: 80,
                                //   clipBehavior: Clip.antiAlias,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //   ),
                                //   child: Image.network(
                                //     // getJsonField(
                                //     //   paysItem,
                                //     //   r'''$.flag''',
                                //     // ).toString()
                                //     paysItem.flag,
                                //     fit: BoxFit.cover,
                                //   ),
                                // )
                                ,
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // getJsonField(
                                        //   paysItem,
                                        //   r'''$.name''',
                                        // ).toString()
                                        paysItem.name,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (paysItem.isActive == 1) {
                                            return Text(
                                              'Services disponible en\ncote d\'ivoire',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            Color(0xFF1050FF),
                                                        fontSize: 10,
                                                        letterSpacing: 0.0,
                                                      ),
                                            );
                                          } else {
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Services momentanément indisponible au ${paysItem.name}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Text(
                                                  'Vendez en Côte d\'Ivoire',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            Color(0xFF1050FF),
                                                        fontSize: 10,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ].divide(SizedBox(height: 10)),
                                  ),
                                ),
                              ].divide(SizedBox(width: 15)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
