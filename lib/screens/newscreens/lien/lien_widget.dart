import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_icon_button.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'lien_model.dart';
export 'lien_model.dart';

class LienWidget extends StatefulWidget {
  const LienWidget({
    super.key,
    required this.lien,
  });

  final String lien;

  @override
  State<LienWidget> createState() => _LienWidgetState();
}

class _LienWidgetState extends State<LienWidget> {
  late LienModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LienModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  void _shareLink() {
    Share.share(textSharing + widget.lien);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 40,
                        child: Divider(
                          thickness: 3,
                          color: Color.fromARGB(255, 31, 31, 31),
                        ),
                      ),
                    ],
                  ),
                ),
                // Align(
                //   alignment: AlignmentDirectional(1, -1),
                //   child: FlutterFlowIconButton(
                //     borderColor: FlutterFlowTheme.of(context).secondaryText,
                //     borderRadius: 20,
                //     buttonSize: 30,
                //     fillColor: Color(0xFFF7FBFE),
                //     icon: Icon(
                //       Icons.close_rounded,
                //       color: FlutterFlowTheme.of(context).secondaryText,
                //       size: 12,
                //     ),
                //     onPressed: () {
                //       print('IconButton pressed ...');
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            width: 140,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Votre lien de vente est prêt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/icon_prod.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Color(0xFFFF9700),
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.lien,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF0074FF),
                      fontSize: 7,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Color.fromARGB(0, 255, 255, 255),
            ),
            child: Text(
              'Retrouvez ce lien dans l\'option activité\nEt partager le lien pour vendre ce produit',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                letterSpacing: 0.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
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
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: textSharing + widget.lien));
                          Fluttertoast.showToast(
                              msg: 'Lien copié.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          // Navigator.of(context).pop();
                          // Navigator.of(context).pop();
                        },
                        text: 'Copier le lien',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFFF7FBFE),
                          textStyle: TextStyle(
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
                        onPressed: () {
                          print('Button pressed ...');
                          _shareLink();
                        },
                        text: 'Partager le lien',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFFFF9700),
                          textStyle: TextStyle(
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
        ].divide(SizedBox(height: 20)),
      ),
    );
  }
}
