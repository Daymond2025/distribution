import 'package:distribution_frontend/models/retraits.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';

import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'list_retraits_model.dart';
export 'list_retraits_model.dart';

class ListRetraitsWidget extends StatefulWidget {
  const ListRetraitsWidget({
    super.key,
    this.retraits,
  });

  final List<Retrait>? retraits;

  @override
  State<ListRetraitsWidget> createState() => _ListRetraitsWidgetState();
}

class _ListRetraitsWidgetState extends State<ListRetraitsWidget> {
  late ListRetraitsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListRetraitsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final elmt = widget!.retraits?.toList() ?? [];

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: elmt.length,
          itemBuilder: (context, elmtIndex) {
            final elmtItem = elmt[elmtIndex];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                () {
                                  switch (elmtItem.operateur) {
                                    case 'Moov':
                                      return 'assets/images/MOOV.png';
                                    case 'Orange':
                                      return 'assets/images/ORANGE.png';
                                    case 'Wave':
                                      return 'assets/images/WAVE.png';
                                    default:
                                      return 'assets/images/MTN.png';
                                  }
                                }(),
                                width: 85,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Retraits',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: () {
                                      switch (elmtItem.statut) {
                                        case 'valide':
                                          return Color(0x6C249689);
                                        case 'enattente':
                                          return Color.fromARGB(
                                              108, 170, 170, 170);
                                        case 'refuse':
                                          return Color.fromARGB(
                                              108, 245, 113, 113);
                                        case 'annule':
                                          return Color.fromARGB(
                                              108, 245, 113, 113);
                                        default:
                                          return Color(0x6C249689);
                                      }
                                    }(),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      () {
                                        switch (elmtItem.statut) {
                                          case 'valide':
                                            return 'Validé';
                                          case 'enattente':
                                            return 'En attente';
                                          case 'refuse':
                                            return 'Refusé';
                                          case 'annule':
                                            return 'Annulé';
                                          default:
                                            return 'Inconnu';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: () {
                                              switch (elmtItem.statut) {
                                                case 'valide':
                                                  return Color.fromARGB(
                                                      108, 0, 122, 108);
                                                case 'enattente':
                                                  return Color.fromARGB(
                                                      108, 29, 29, 29);
                                                case 'refuse':
                                                  return Color.fromARGB(
                                                      108, 255, 11, 11);
                                                case 'annule':
                                                  return Color.fromARGB(
                                                      108, 255, 11, 11);
                                                default:
                                                  return Color.fromARGB(
                                                      108, 0, 0, 0);
                                              }
                                            }(),
                                            fontSize: 10,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ].divide(SizedBox(width: 10)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${elmtItem.montant} FCFA',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).success,
                                    fontSize: 15,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              formatDate(elmtItem.createdAt),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 10,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
