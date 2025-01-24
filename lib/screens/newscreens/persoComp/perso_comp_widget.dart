import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/screens/newscreens/lien/lien_widget.dart';
import 'package:distribution_frontend/screens/newscreens/visu/visu_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:distribution_frontend/services/crypt_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow_expanded_image_view.dart';
import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'perso_comp_model.dart';
export 'perso_comp_model.dart';

class PersoCompWidget extends StatefulWidget {
  const PersoCompWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<PersoCompWidget> createState() => _PersoCompWidgetState();
}

class _PersoCompWidgetState extends State<PersoCompWidget> {
  late PersoCompModel _model;

  late String _type;
  int price = 0;

  bool _link = false;
  String lien = site;

  Seller? seller;

  bool visualise = false;
  bool voirErreur = false;
  bool voirPrice = false;

  Future<Seller?> getSeller() async {
    final prefs = await SharedPreferences.getInstance();
    final sellerJson = prefs.getString('seller');

    if (sellerJson != null) {
      final Map<String, dynamic> sellerMap = jsonDecode(sellerJson);
      print('infos vendeur : ${Seller.fromJson(sellerMap)}');
      setState(() {
        seller = Seller.fromJson(sellerMap);
        // Chiffrer les données
      });
      print('info vendeur id ${seller?.id}');
      // encryptedData = encryptUserId(seller!.id.toString(), key: 'd@ymond2025');
      // print('info vendeur encryptedData ${encryptedData}');
      return Seller.fromJson(sellerMap);
    }
    return null;
  }

  String btoa(String input) {
    // Convertit la chaîne en bytes, puis l'encode en Base64
    return base64Encode(utf8.encode(input));
  }

  _submit() async {
    List<dynamic> data;
    AlertComponent().loading();
    ApiResponse response = await CloneProductService().storeClone(
        widget.product.id,
        _model.nomControllerTextController.text,
        _model.soustitreTextController.text,
        _model.descriptionTextController.text,
        _model.priceTextController.text,
        _model.contactTextController.text);
    AlertComponent().endLoading();

    if (response.error == null) {
      Fluttertoast.showToast(
        msg: 'Produit clone avec succès',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      dynamic ladata = response.data;
      print('le clone id ${ladata['id']}');

      setState(() {
        lien = response.message ?? '';
        _link = !_link;
      });

      Map<String, dynamic> data = {
        'idSeller': seller!.id,
        'idProduit': ladata['id'],
      };
      // Convertir l'objet JSON en chaîne de caractères (stringify)
      String jsonString = jsonEncode(data);

      Navigator.pop(context);
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: LienWidget(
                lien: lien
                // '?data=${encryptUserId(seller!.id.toString(), key: 'd@ymond2025d@ymond2025d@ymond202')}'
                ,
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));
    } else {
      print(response.error);
    }
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PersoCompModel());

    getSeller();
    _model.nomControllerTextController ??=
        TextEditingController(text: widget!.product.name);
    _model.nomControllerFocusNode ??= FocusNode();

    _model.soustitreTextController ??=
        TextEditingController(text: widget!.product.subTitle);
    _model.soustitreFocusNode ??= FocusNode();

    _model.descriptionTextController ??=
        TextEditingController(text: widget!.product.description);
    _model.descriptionFocusNode ??= FocusNode();

    if (widget.product.type == 'grossiste') {
      setState(() {
        price = widget.product.price.min;
      });
    } else {
      setState(() {
        price = widget.product.price.price;
      });
    }

    _model.priceTextController ??= TextEditingController();
    _model.priceFocusNode ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.contactTextController ??= TextEditingController();
    _model.contactFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
      child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
            ),
          ),
          child: Stack(
            children: [
              visualise == false
                  ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 70, 10, 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 40),
                              child: Builder(
                                builder: (context) {
                                  final images = widget!.product.images;

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(images.length,
                                          (imagesIndex) {
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
                                                child:
                                                    FlutterFlowExpandedImageView(
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                              padding: EdgeInsets.all(1),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x33000000),
                                                      offset: Offset(
                                                        0,
                                                        1,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 5),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 200,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .nomControllerTextController,
                                                            focusNode: _model
                                                                .nomControllerFocusNode,
                                                            autofocus: !_model
                                                                .activNom,
                                                            readOnly:
                                                                _model.activNom,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              hintText:
                                                                  'TextField',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .nomControllerTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderRadius: 8,
                                                        buttonSize: 40,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .penAlt,
                                                          color: Color.fromARGB(
                                                              255, 59, 59, 59),
                                                          size: 10,
                                                        ),
                                                        onPressed: () async {
                                                          _model.activNom =
                                                              !_model.activNom;
                                                          _model
                                                              .nomControllerFocusNode
                                                              ?.requestFocus();
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                'Nom de l\'article',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF707070),
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x33000000),
                                                      offset: Offset(
                                                        0,
                                                        1,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 5),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 200,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .soustitreTextController,
                                                            focusNode: _model
                                                                .soustitreFocusNode,
                                                            autofocus: !_model
                                                                .activSub,
                                                            readOnly:
                                                                _model.activSub,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              hintText:
                                                                  'TextField',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .soustitreTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 8,
                                                        buttonSize: 40,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .penAlt,
                                                          color: Color.fromARGB(
                                                              255, 59, 59, 59),
                                                          size: 10,
                                                        ),
                                                        onPressed: () async {
                                                          _model.activSub =
                                                              !_model.activSub;
                                                          _model
                                                              .soustitreFocusNode
                                                              ?.requestFocus();
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                'Sous titre',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF707070),
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x33000000),
                                                      offset: Offset(
                                                        0,
                                                        1,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 5),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 200,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .descriptionTextController,
                                                            focusNode: _model
                                                                .descriptionFocusNode,
                                                            autofocus: !_model
                                                                .activDesc,
                                                            readOnly: _model
                                                                .activDesc,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              hintText:
                                                                  'TextField',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            maxLines: 8,
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .descriptionTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 8,
                                                        buttonSize: 40,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .penAlt,
                                                          color: Color.fromARGB(
                                                              255, 59, 59, 59),
                                                          size: 10,
                                                        ),
                                                        onPressed: () async {
                                                          _model.activDesc =
                                                              !_model.activDesc;
                                                          _model
                                                              .descriptionFocusNode
                                                              ?.requestFocus();
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                'Description',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF707070),
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Generated code for this Container Widget...
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Builder(
                                                      builder: (context) {
                                                        if (!_model.offre) {
                                                          return Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Prix de vente de :',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              Text(
                                                                formatAmount(
                                                                    price),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 10)),
                                                          );
                                                        } else {
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Expanded(
                                                              //   child:
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    TextFormField(
                                                                  controller: _model
                                                                      .priceTextController,
                                                                  focusNode: _model
                                                                      .priceFocusNode,
                                                                  autofocus:
                                                                      false,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    labelText:
                                                                        'À combien souhaitez-vous augmenter le prix de vente ?',
                                                                    labelStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontSize:
                                                                              8,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    hintText:
                                                                        'Prix de vente',
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontSize:
                                                                              10,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFFF9000),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFFF9000),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  cursorColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  validator: _model
                                                                      .priceTextControllerValidator
                                                                      .asValidator(
                                                                          context),
                                                                ),
                                                              ),
                                                              // ),
                                                            ],
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (!_model.offre) {
                                                        return FlutterFlowIconButton(
                                                          borderRadius: 8,
                                                          buttonSize: 40,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          icon: Icon(
                                                            Icons.add_circle,
                                                            color: Color(
                                                                0xFFFF9000),
                                                            size: 24,
                                                          ),
                                                          onPressed: () async {
                                                            _model.offre =
                                                                !_model.offre;
                                                            safeSetState(() {});
                                                          },
                                                        );
                                                      } else {
                                                        return FlutterFlowIconButton(
                                                          borderRadius: 8,
                                                          buttonSize: 40,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          icon: Icon(
                                                            Icons.close_sharp,
                                                            color: Color(
                                                                0xFF656565),
                                                            size: 20,
                                                          ),
                                                          onPressed: () {
                                                            print(
                                                                'IconButton pressed ...');
                                                            _model.offre =
                                                                !_model.offre;
                                                            safeSetState(() {
                                                              _model
                                                                  .priceTextController
                                                                  .text = '';
                                                            });
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Visibility(
                                                  visible: voirPrice,
                                                  child: Text(
                                                      "* Veuillez renseigner un prix de vente supérieur au prix actuel !!",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.red,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Divider(
                                                thickness: 2,
                                                color: const Color.fromARGB(
                                                    255, 230, 230, 230),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      'Votre commission est de',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 12,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child:
                                                          // Generated code for this ConditionalBuilder Widget...
                                                          Builder(
                                                        builder: (context) {
                                                          if (_model.priceTextController
                                                                      .text ==
                                                                  null ||
                                                              _model.priceTextController
                                                                      .text ==
                                                                  '') {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          10,
                                                                          0),
                                                              child: Text(
                                                                formatAmount(widget
                                                                    .product
                                                                    .price
                                                                    .commission),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: Color(
                                                                          0xFFFF9000),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              ),
                                                            );
                                                          } else {
                                                            return Text(
                                                              formatAmount((widget
                                                                          .product
                                                                          .price
                                                                          .commission +
                                                                      ((int.parse(_model.priceTextController.text) -
                                                                              price) *
                                                                          70 /
                                                                          100))
                                                                  .round()),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: Color(
                                                                        0xFFFF9000),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            );
                                                          }
                                                        },
                                                      )),
                                                ],
                                              ),
                                              // Generated code for this Row Widget...
                                              if ((_model.priceTextController
                                                              .text !=
                                                          null &&
                                                      _model.priceTextController
                                                              .text !=
                                                          '') &&
                                                  (int.parse(_model
                                                          .priceTextController
                                                          .text) <
                                                      price))
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.warning_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      'Le prix de vente doit être supérieur à $price Fr',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            fontSize: 9,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ].divide(SizedBox(width: 5)),
                                                )
                                            ].divide(SizedBox(height: 10)),
                                          ),
                                        ),
                                      ),

                                      // Container(
                                      //   width: double.infinity,
                                      //   decoration: BoxDecoration(
                                      //     color: FlutterFlowTheme.of(context)
                                      //         .secondaryBackground,
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         blurRadius: 4,
                                      //         color: Color(0x33000000),
                                      //         offset: Offset(
                                      //           0,
                                      //           2,
                                      //         ),
                                      //       )
                                      //     ],
                                      //     borderRadius: BorderRadius.circular(4),
                                      //   ),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.all(10),
                                      //     child: Column(
                                      //       mainAxisSize: MainAxisSize.max,
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Row(
                                      //           children: [
                                      //             Text(
                                      //               'Prix de vente : ',
                                      //               style: FlutterFlowTheme.of(context)
                                      //                   .bodyMedium
                                      //                   .override(
                                      //                     fontWeight: FontWeight.w600,
                                      //                     fontFamily: 'Inter',
                                      //                     letterSpacing: 0.0,
                                      //                   ),
                                      //             ),
                                      //             Text(
                                      //               widget.product.type == 'grossiste'
                                      //                   ? widget.product.price.min
                                      //                       .toString()
                                      //                   : widget.product.price.price
                                      //                       .toString(),
                                      //               style: FlutterFlowTheme.of(context)
                                      //                   .bodyMedium
                                      //                   .override(
                                      //                     fontFamily: 'Inter',
                                      //                     letterSpacing: 0.0,
                                      //                     fontWeight: FontWeight.w600,
                                      //                   ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Divider(
                                      //           thickness: 2,
                                      //           color: const Color.fromARGB(
                                      //               255, 230, 230, 230),
                                      //         ),
                                      //         Row(
                                      //           mainAxisSize: MainAxisSize.max,
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.spaceBetween,
                                      //           children: [
                                      //             Text(
                                      //               'Votre commission est de',
                                      //               style: FlutterFlowTheme.of(context)
                                      //                   .bodyMedium
                                      //                   .override(
                                      //                     fontFamily: 'Inter',
                                      //                     letterSpacing: 0.0,
                                      //                   ),
                                      //             ),
                                      //             Text(
                                      //               '7000 fr',
                                      //               style: FlutterFlowTheme.of(context)
                                      //                   .bodyMedium
                                      //                   .override(
                                      //                     fontFamily: 'Inter',
                                      //                     color: Color(0xFFFF9000),
                                      //                     letterSpacing: 0.0,
                                      //                     fontWeight: FontWeight.bold,
                                      //                   ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ].divide(SizedBox(height: 5)),
                                      //     ),
                                      //   ),
                                      // ),

                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .contactTextController,
                                                  focusNode:
                                                      _model.contactFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelText:
                                                        'Entrez votre numéro',
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 12,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: 'TextField',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFFF9000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                50, 11, 0, 11),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .contactTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Text(
                                                  '+225 |',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontSize: 12,
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                              visible: voirErreur,
                                              child: Text(
                                                  "* Veuillez renseigner votre numéro de téléphone !!",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Numéro whatsapp',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 10,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              Text(
                                                '( Facultatif )',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 10,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 10)),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Livraison express ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
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
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 100),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Abidjan =',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Text(
                                              formatAmount(
                                                  widget.product.delivery.city),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFFFF9700),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 0, 5, 0),
                                              child: Text(
                                                '-',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              'Hors Abidjan = ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Text(
                                              formatAmount(widget
                                                  .product.delivery.noCity),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                      ),
                                    ].divide(SizedBox(height: 20)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : VisuWidget(
                      images: widget.product.images,
                      nomarticle: _model.nomControllerTextController.text,
                      soustitre: _model.soustitreTextController.text,
                      description: _model.descriptionTextController.text,
                      prixdevente: _model.priceTextController.text == ''
                          ? price.toString()
                          : _model.priceTextController.text,
                      livraisonabidjan: widget.product.delivery.city.toString(),
                      horsabidjan: widget.product.delivery.noCity.toString(),
                      etat: widget.product.state.name),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                            -2,
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
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () {
                                if (visualise == false) {
                                  setState(
                                    () => visualise = true,
                                  );
                                } else {
                                  setState(
                                    () => visualise = false,
                                  );
                                }

                                print('Button pressed ...');
                              },
                              text: visualise ? 'Modifier' : 'Visualiser',
                              options: FFButtonOptions(
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: Color(0xFFFF9700),
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Color(0xFFFF9700),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                print('Button pressed ...');
                                if (_model.contactTextController.text == '') {
                                  setState(() => voirErreur = true);
                                  // Fluttertoast.showToast(
                                  //   msg:
                                  //       'Veuillez mettre un prix de vente supérieur au prix de l\'article',
                                  //   toastLength: Toast.LENGTH_SHORT,
                                  //   gravity: ToastGravity.TOP,
                                  //   timeInSecForIosWeb: 1,
                                  //   backgroundColor: Colors.red,
                                  //   textColor: Colors.white,
                                  //   fontSize: 16.0,
                                  // );
                                } else if (_model.priceTextController.text ==
                                    '') {
                                  setState(() {
                                    _model.priceTextController.text =
                                        price.toString();
                                  });

                                  _submit();
                                } else if (price >
                                    int.parse(
                                        _model.priceTextController.text)) {
                                  setState(() => voirPrice = true);
                                } else {
                                  setState(() {
                                    voirErreur = false;
                                    voirPrice = false;
                                  });
                                  _submit();
                                }
                              },
                              text: 'Enregistrer',
                              options: FFButtonOptions(
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFFFF9700),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0,
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 20)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Stack(
                        children: [
                          // Align(
                          //   alignment: AlignmentDirectional(-1, -1),
                          //   child: FlutterFlowIconButton(
                          //     borderRadius: 8,
                          //     buttonSize: 30,
                          //     icon: Icon(
                          //       Icons.arrow_back,
                          //       color: FlutterFlowTheme.of(context).primaryText,
                          //       size: 20,
                          //     ),
                          //     onPressed: () {
                          //       print('IconButton pressed ...');
                          //     },
                          //   ),
                          // ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                'Personnalisation',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Divider(
                        thickness: 2,
                        color: const Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
