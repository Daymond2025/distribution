import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/newscreens/persoComp/perso_comp_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:distribution_frontend/models/product.dart';

import 'article_comp_model.dart';
export 'article_comp_model.dart';

class ArticleCompWidget extends StatefulWidget {
  const ArticleCompWidget({
    super.key,
    this.article,
  });

  final dynamic article;

  @override
  State<ArticleCompWidget> createState() => _ArticleCompWidgetState();
}

class _ArticleCompWidgetState extends State<ArticleCompWidget> {
  late ArticleCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArticleCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<void> handleCloneAndCopyLink(
      BuildContext context, Product product) async {
    final response = await CloneProductService().cloneAndCopyLink(
      productId: product.id ?? 0,
      title: product.name ?? '',
      subTitle: product.subTitle ?? '',
      description: product.description ?? '',
      price: product.price.price, // un int (ou double)
      commission: product.price.commission ?? 0,
    );

    if (response.error == null) {
      Fluttertoast.showToast(
        msg: "Lien copié dans le presse-papiers !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:
            Color(0xFF4CAF50), // Vert cohérent (Material Green 500)
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Erreur : ${response.error}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
    }
  }

  Future<void> showLienDeVentePopup(
      BuildContext context, Product product) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // 🟧 Conteneur principal
              Container(
                margin: EdgeInsets.only(top: 12, right: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFFA500), width: 3),
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                padding: EdgeInsets.fromLTRB(20, 28, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Créer un lien de vente',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 32),

                    // ⚡ Copier & ✏️ Personnaliser
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 17, 141, 241),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Image.asset(
                                  'assets/images/flash.png',
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: 120,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(0, 116, 255, 1),
                                      Color.fromRGBO(0, 215, 251, 1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () async {
                                    await handleCloneAndCopyLink(
                                        context, product);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Copier",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(255, 102, 0, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Image.asset(
                                  'assets/images/edite.png',
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(255, 144, 0, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  minimumSize: Size(140, 36),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        child:
                                            PersoCompWidget(product: product),
                                      );
                                    },
                                  );
                                },
                                child: FittedBox(
                                  child: Text("Personnaliser",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ❌ Bouton de fermeture bien rentré
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, size: 14),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    splashRadius: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    this.widget.article.images[0],
                    width: double.infinity,
                    height: 128,
                    fit: BoxFit.cover,
                  ),
                ),
                // Generated code for this Row Widget...
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFC000),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(4),
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
                        child: Text(
                          this.widget.article.state.name,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0,
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(97, 0, 0, 0),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 217, 0),
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            AutoSizeText(
              this.widget.article.name,
              maxLines: 1,
              // minFontSize: 10,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    color: Color(0xFF707070),
                    fontSize: 13,
                    letterSpacing: 0.0,
                  ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  '${NumberFormat("###,###", 'en_US').format(this.widget.article.price.price).replaceAll(',', ' ')} Fr  ',
                  minFontSize: 11,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                AutoSizeText(
                  this.widget.article.reducedPrice != null &&
                          this.widget.article.reducedPrice != 0
                      ? this.widget.article.reducedPrice.toString()
                      : '',
                  minFontSize: 11,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Color(0xFF656565),
                        fontSize: 11,
                        letterSpacing: 0.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Commission',
                  minFontSize: 11,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        letterSpacing: 0.0,
                      ),
                ),
                AutoSizeText(
                  '${NumberFormat("###,###", 'en_US').format(this.widget.article.price.commission).replaceAll(',', ' ')} Fr  ',
                  minFontSize: 11,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Color(0xFFFF9000),
                        fontSize: 12,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            FFButtonWidget(
              onPressed: () async {
                await showLienDeVentePopup(context, widget.article);
              },

              //onPressed: () async {
              //print('Button pressed ...');

              //await showModalBottomSheet(
              //isScrollControlled: true,
              //backgroundColor: Colors.transparent,
              //enableDrag: false,
              //context: context,
              //builder: (context) {
              //return Padding(
              //padding: MediaQuery.viewInsetsOf(context),
              //child: Container(
              //height: MediaQuery.sizeOf(context).height * 0.9,
              //child: PersoCompWidget(
              //product: widget!.article,
              //),
              //),
              //);
              //},
              //).then((value) => safeSetState(() {}));

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ClickProduit(
              //       product: this.widget.article,
              //     ),
              //   ),
              // );
              //,
              text: 'Vendre ce produit',
              options: FFButtonOptions(
                width: double.infinity,
                height: 30,
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: Color(0xFFFF9000),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Inter Tight',
                      color: Colors.white,
                      letterSpacing: 0.0,
                      fontSize: 12,
                    ),
                elevation: 0,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ].divide(SizedBox(height: 10)),
        ),
      ),
    );
  }
}
