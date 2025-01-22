import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/screens/Auth/messages/conversation_screen.dart';
import 'package:distribution_frontend/screens/Auth/messages/new_conversation_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  static const routeName = '/messages';

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
    initProfile();
    initConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0,
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
        title: const Text(
          'Conversations',
          style: TextStyle(color: colorblack, fontSize: 17),
        ),
        actions: [
          // Container(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: InkWell(
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => NewConversationScreen(
          //             profiles: _profiles,
          //           ),
          //         ),
          //       );
          //     },
          //     child: Image.asset(
          //       'assets/images/add.png',
          //       width: 25,
          //       height: 25,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await initConversations();
        },
        child: SingleChildScrollView(
          child: !_loading
              ? _conversations.isEmpty
                  ?
                  // Container(
                  // padding: EdgeInsets.only(
                  //     top: MediaQuery.of(context).size.height / 2.8),
                  // height: MediaQuery.of(context).size.height - 170,
                  // width: MediaQuery.of(context).size.width,
                  // child:
                  Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 70),
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 15, 20, 0),
                                child: SelectionArea(
                                    child: AnimatedDefaultTextStyle(
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                  duration: Duration(milliseconds: 1410),
                                  curve: Curves.easeInOut,
                                  child: Text(
                                    'Bienvenue dans votre boîte de dialogue \ndaymond, Pour toute question ou préoccupation, \ncliquez sur ce bouton pour échanger avec un agent ',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 100, 0, 120),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         NewConversationScreen(
                                    //       profiles: _profiles,
                                    //     ),
                                    //   ),
                                    // );
                                    await launchURL(
                                        'https://wa.me/+2250707545252?text=Bonjour%20Daymond,%20j\'ai%20une%20question%20?');
                                  },
                                  text: 'Commencer',
                                  options: FFButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        70, 12, 70, 12),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: Color(0xFFFF9700),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
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
                            ],
                          ),

                          Text(
                            'Service WhatsApp',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontSize: 10,
                                ),
                          ),

                          // TextButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => NewConversationScreen(
                          //             profiles: _profiles,
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //     child: const Text(
                          //       'Appuyez pour\ncommencer une conversation!',
                          //       textAlign: TextAlign.center,
                          //     )),
                        ],
                      ),
                    )
                  // )
                  : Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                          children: _conversations.isNotEmpty
                              ? _conversations.map((e) {
                                  return kCardProfile(
                                      e,
                                      e.id,
                                      e.profile.id,
                                      e.profile.status,
                                      e.profile.picturePath ?? imgUserDefault,
                                      e.profile.name,
                                      e.profile.role,
                                      e.lastMessage ?? '',
                                      e.updatedAtFr,
                                      !e.isNew ? 'profil' : 'vous',
                                      e.isNew);
                                }).toList()
                              : []),
                    )
              : Container(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: colorblack,
                  )),
                ),
        ),
      ),
    );
  }

  InkWell kCardProfile(
          Conversation conversation,
          int id,
          int idProfile,
          String status,
          String image,
          String nom,
          String role,
          String message,
          String date,
          String person,
          bool vue) =>
      InkWell(
        onTap: () {
          getConversation(conversation);
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 10, top: 7, bottom: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        margin: const EdgeInsets.only(right: 23),
                        decoration: BoxDecoration(
                          color: colorwhite,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 23,
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                status == 'active' ? Colors.green : colorannule,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 7,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: nom,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              person == 'profil' ? message : 'Vous: $message',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight:
                                    vue ? FontWeight.w400 : FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(date),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
