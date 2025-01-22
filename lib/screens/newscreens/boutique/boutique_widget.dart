import 'package:distribution_frontend/screens/newscreens/flutter_flow_icon_button.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/produit_comp/produit_comp_widget.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'boutique_model.dart';
export 'boutique_model.dart';

class BoutiqueWidget extends StatefulWidget {
  const BoutiqueWidget({super.key});

  @override
  State<BoutiqueWidget> createState() => _BoutiqueWidgetState();
}

class _BoutiqueWidgetState extends State<BoutiqueWidget> {
  late BoutiqueModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BoutiqueModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFFF7FBFE),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderRadius: 8,
                    buttonSize: 40,
                    fillColor: Color(0xFFF7FBFE),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 24, 24, 24),
                      size: 24,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                  Text(
                    'Ma boutique',
                    style: TextStyle(
                      fontFamily: 'Inter Tight',
                      color: Color.fromARGB(255, 24, 24, 24),
                      fontSize: 22,
                      letterSpacing: 0.0,
                    ),
                  ),
                ].divide(SizedBox(width: 10)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 8,
                    buttonSize: 40,
                    fillColor: Color(0xFFF7FBFE),
                    icon: FaIcon(
                      FontAwesomeIcons.locationArrow,
                      color: Color.fromARGB(255, 24, 24, 24),
                      size: 24,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 8,
                    buttonSize: 40,
                    fillColor: Color(0xFFF7FBFE),
                    icon: Icon(
                      Icons.more_vert_sharp,
                      color: Color(0xFFFF9000),
                      size: 24,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ].divide(SizedBox(width: 10)),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 255, 255, 255),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/deusv_2.PNG',
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Text(
                    'Mes produits',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    wrapWithModel(
                      model: _model.produitCompModel,
                      updateCallback: () => safeSetState(() {}),
                      child: SizedBox()
                      // ProduitCompWidget(produit:Clon)
                      ,
                    ),
                  ],
                ),
              ].divide(SizedBox(height: 20)),
            ),
          ),
        ),
      ),
    );
  }
}
