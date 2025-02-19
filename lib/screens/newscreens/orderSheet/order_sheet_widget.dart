import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_screen.dart';
import 'package:distribution_frontend/screens/newscreens/commandeAnnulee/commande_annulee_widget.dart';
import 'package:distribution_frontend/screens/newscreens/commandeAttente/commande_attente_widget.dart';
import 'package:distribution_frontend/screens/newscreens/commandeEnCours/commande_encours_widget.dart';
import 'package:distribution_frontend/screens/newscreens/commandeValidee/commande_validee_widget.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'order_sheet_model.dart';
export 'order_sheet_model.dart';

class OrderSheetWidget extends StatefulWidget {
  const OrderSheetWidget({super.key, this.statut, this.order});

  final String? statut;
  final Order? order;

  @override
  State<OrderSheetWidget> createState() => _OrderSheetWidgetState();
}

class _OrderSheetWidgetState extends State<OrderSheetWidget> {
  late OrderSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 1),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: Material(
          color: Colors.transparent,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Container(
            width: double.infinity,
            // height: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) {
                    if (widget!.statut == 'pending') {
                      return wrapWithModel(
                        model: _model.commandeAttenteModel,
                        updateCallback: () => safeSetState(() {}),
                        child: CommandeAttenteWidget(order: widget.order),
                      );
                    } else if (widget!.statut == 'canceled') {
                      return Container(
                        // height: 200,
                        child: wrapWithModel(
                          model: _model.commandeAnnuleeModel,
                          updateCallback: () => safeSetState(() {}),
                          child: CommandeAnnuleeWidget(order: widget.order),
                        ),
                      );
                    } else if (widget!.statut == 'validated') {
                      return Container(
                        // height: 200,
                        child: wrapWithModel(
                          model: _model.commandeValideeModel,
                          updateCallback: () => safeSetState(() {}),
                          child: CommandeValideeWidget(order: widget.order),
                        ),
                      );
                    } else {
                      return Container(
                        // height: 200,
                        child: wrapWithModel(
                          model: _model.commandeEncoursModel,
                          updateCallback: () => safeSetState(() {}),
                          child: CommandeEncoursWidget(order: widget.order),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 10),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                      switch (widget.statut) {
                        case 'validated':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PortefeuilleScreen(),
                            ),
                          );
                          break;
                        default:
                          Navigator.pop(context);
                      }
                    },
                    text: widget.statut == 'validated'
                        ? 'Voir mon portefeuille'
                        : 'OK',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFFFF9500),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
