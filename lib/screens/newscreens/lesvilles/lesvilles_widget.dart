import 'package:distribution_frontend/models/city.dart';

import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'lesvilles_model.dart';
export 'lesvilles_model.dart';

class LesvillesWidget extends StatefulWidget {
  const LesvillesWidget({
    super.key,
    this.villes,
    required this.onDataChanged,
  });

  final List<City>? villes;
  final Function(dynamic) onDataChanged;

  @override
  State<LesvillesWidget> createState() => _LesvillesWidgetState();
}

class _LesvillesWidgetState extends State<LesvillesWidget> {
  late LesvillesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LesvillesModel());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(
              0,
              -3,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 23,
                  buttonSize: 40,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.arrow_back,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.max,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'ABIDJAN',
                //       style: FlutterFlowTheme.of(context).bodyMedium.override(
                //             fontFamily: 'Inter',
                //             fontSize: 16,
                //             letterSpacing: 0.0,
                //             fontWeight: FontWeight.w600,
                //           ),
                //     ),
                //     Text(
                //       'Selectionnez une ville pour la livraison',
                //       style: FlutterFlowTheme.of(context).bodyMedium.override(
                //             fontFamily: 'Inter',
                //             letterSpacing: 0.0,
                //           ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 70, 20, 20),
            child: Builder(
              builder: (context) {
                final ville = widget!.villes?.toList() ?? [];

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(ville.length, (villeIndex) {
                      final villeItem = ville[villeIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          print('ville choisie : $villeItem');
                          widget.onDataChanged(villeItem);
                          safeSetState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7FBFE),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Text(
                              villeItem.name
                              // getJsonField(
                              //   villeItem,
                              //   r'''$.name'''
// ,
                              // ).toString()
                              ,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }).divide(SizedBox(height: 10)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
