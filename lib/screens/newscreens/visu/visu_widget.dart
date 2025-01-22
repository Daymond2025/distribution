import '../flutter_flow_expanded_image_view.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'visu_model.dart';
export 'visu_model.dart';

class VisuWidget extends StatefulWidget {
  const VisuWidget(
      {super.key,
      this.nomarticle,
      this.soustitre,
      this.description,
      this.prixdevente,
      this.livraisonabidjan,
      this.horsabidjan,
      this.etat,
      this.images});

  final String? nomarticle;
  final String? soustitre;
  final String? description;
  final String? prixdevente;
  final String? livraisonabidjan;
  final String? horsabidjan;
  final String? etat;
  final List<dynamic>? images;

  @override
  State<VisuWidget> createState() => _VisuWidgetState();
}

class _VisuWidgetState extends State<VisuWidget> {
  late VisuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VisuModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 80, 0, 40),
            child: Builder(
              builder: (context) {
                final images = widget!.images;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(images!.length, (imagesIndex) {
                      final imagesItem = images[imagesIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FlutterFlowExpandedImageView(
                                image: Image.network(
                                  imagesItem,
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: false,
                                tag: 'imageTag1',
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'imageTag1',
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imagesItem,
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).divide(SizedBox(width: 10)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget!.nomarticle,
                        '-',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.soustitre,
                        '-',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF8D8D8D),
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      '${widget!.prixdevente} FCFA',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF1050FF),
                            fontSize: 20,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Livraison express',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF656565),
                                    fontSize: 11,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Divider(
                                thickness: 2,
                                color: const Color.fromARGB(255, 230, 230, 230),
                              ),
                            ],
                          ),
                        ),
                      ].divide(SizedBox(width: 5)),
                    ),
                    Text(
                      'Abidjan = ${widget!.livraisonabidjan}- Hors Abidjan = ${widget!.horsabidjan}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF7E7E7E),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(height: 10)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Autres détails',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Color(0xFF650000),
                        letterSpacing: 0.0,
                      ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Etat du produit',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget!.etat,
                                '-',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFFFF9000),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ].divide(SizedBox(width: 10)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Taille disponible',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Divider(
                                        thickness: 2,
                                        color: const Color.fromARGB(
                                            255, 230, 230, 230),
                                      ),
                                    ],
                                  ),
                                ),
                              ].divide(SizedBox(width: 5)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFCE8E8),
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
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'Noir',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10)),
                              ),
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Couleur disponible',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Divider(
                                        thickness: 2,
                                        color: const Color.fromARGB(
                                            255, 230, 230, 230),
                                      ),
                                    ],
                                  ),
                                ),
                              ].divide(SizedBox(width: 5)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'Noir',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10)),
                              ),
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ].divide(SizedBox(height: 20)),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 10)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                    child: Text(
                      'Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      valueOrDefault<String>(
                        widget!.description,
                        '-',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 80))
        ],
      ),
    );
  }
}
