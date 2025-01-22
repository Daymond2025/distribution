import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/screens/Auth/messages/conversation_screen.dart';
import 'package:distribution_frontend/screens/Auth/messages/new_conversation_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';

import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'message_model.dart';
export 'message_model.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key});

  static const routeName = '/messages';

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late MessageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProfileService profileService = ProfileService();
  List<Profile> _profiles = [];
  List<Conversation> _conversations = [];

  bool _loading = true;

  int vendeurId = 0;

  //show
  late Conversation _conversation;

  Future<void> initProfile() async {
    ApiResponse response = await profileService.getProfile();
    if (response.error == null) {
      setState(() {
        _profiles = response.data as List<Profile>;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  Future<void> initConversations() async {
    vendeurId = await getVendeurId();
    ApiResponse response = await profileService.getConversations();

    if (response.error == null) {
      setState(() {
        _conversations = response.data as List<Conversation>;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  Future<void> getConversation(Conversation conversation) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(
          conversation: conversation,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageModel());
    initProfile();
    initConversations();
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              // context.pop();
            },
          ),
          title: Text(
            'Message',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Color(0xFF242424),
                  fontSize: 22,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 55,
                  child: Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/call_center_agent.png',
                          width: 216,
                          height: 200,
                          fit: BoxFit.contain,
                          alignment: Alignment(0, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: SelectionArea(
                      child: AnimatedDefaultTextStyle(
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    duration: Duration(milliseconds: 1410),
                    curve: Curves.easeInOut,
                    child: Text(
                      'Bienvenue dans votre boîte de dialogue \ndaymond, Pour toute question ou préoccupation, \ncliquez sur ce bouton pour échanger avec un agent ',
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 200),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewConversationScreen(
                            profiles: _profiles,
                          ),
                        ),
                      );
                      // await launchURL(
                      //     'https://wa.me/+2250707545252?text=Bonjour%20Daymond,%20j\'ai%20une%20questions%20?');
                    },
                    text: 'Commencer',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(70, 12, 70, 12),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFFFF9700),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Text(
                  'Service WhatsApp',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
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
