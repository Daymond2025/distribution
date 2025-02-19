// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/screens/Auth/clone/clone_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
import 'package:distribution_frontend/screens/newscreens/infocommande/infocommande_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'produit_comp_model.dart';
export 'produit_comp_model.dart';

class ProduitCompWidget extends StatefulWidget {
  ProduitCompWidget({
    Key? key,
    required this.produit,
    required this.vendeur,
  }) : super(key: key);

  final CloneProduct produit;
  final Seller vendeur;

  @override
  State<ProduitCompWidget> createState() => _ProduitCompWidgetState();
}

class _ProduitCompWidgetState extends State<ProduitCompWidget> {
  late ProduitCompModel _model;
  CloneProductService cloneService = CloneProductService();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProduitCompModel());
    // print("===url du produit : ${widget.produit.url}");
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  String btoa(String input) {
    // Convertit la chaîne en bytes, puis l'encode en Base64
    return base64Encode(utf8.encode(input));
  }

  Future<void> deleteClone(int id) async {
    ApiResponse response = await cloneService.deleteClone(id);
    if (response.error == null) {
      AlertComponent().success(context, response.message.toString());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CloneScreen()));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  void _shareLink() {
    print('url du produit ${widget.produit.url}');
    print("id du seller ${widget.vendeur.id}");
    Map<String, dynamic> data = {
      'idSeller': widget.vendeur.id,
      'idProduit': widget.produit.id,
    };

    // Convertir l'objet JSON en chaîne de caractères (stringify)
    String jsonString = jsonEncode(data);

    Share.share(textSharing + widget.produit.url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 155,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
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
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.produit.product!.images[0],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.produit.title,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                            ),
                            Text(
                              widget.produit.price.toString() + ' Fr',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF1050FF),
                                fontSize: 16,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ].divide(SizedBox(height: 10)),
                        ),
                      ),
                    ].divide(SizedBox(width: 10)),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.star_sharp,
                        color: Color.fromARGB(255, 255, 217, 0),
                        size: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFC000),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
                          child: Text(
                            widget.produit.product!.state.name[0]
                                    .toUpperCase() +
                                widget.produit.product!.state.name.substring(1),
                            style: TextStyle(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 20)),
                  ),
                  // Text(
                  //   'Il ya 3min',
                  //   style: TextStyle(
                  //     fontFamily: 'Inter',
                  //     color: Color(0xFF707070),
                  //     letterSpacing: 0.0,
                  //   ),
                  // ),
                ].divide(SizedBox(height: 30)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Divider(
                  thickness: 2,
                  color: Color.fromARGB(255, 238, 238, 238),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FFButtonWidget(
                //   onPressed: () {
                //     print('Button pressed ...');
                //   },
                //   text: 'Menu',
                //   options: FFButtonOptions(
                //     height: 40,
                //     padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                //     color: Color(0xFFD9D9D9),
                //     textStyle: TextStyle(
                //       fontFamily: 'Inter Tight',
                //       color: Color(0xFF7E7E7E),
                //       fontSize: 12,
                //       letterSpacing: 0.0,
                //     ),
                //     elevation: 0,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
                PopupMenuButton(
                  color: const Color(0xFFFFFFFF),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'copy',
                      child: Row(
                        children: [
                          const Icon(Icons.content_copy),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text('Copier le lien'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          // const Icon(Icons.share),
                          Image.asset(
                            'assets/images/share.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text('Partager le produit'),
                        ],
                      ),
                    ),
                    // const PopupMenuItem(
                    //   value: 'update',
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.create),
                    //       const SizedBox(
                    //         width: 6,
                    //       ),
                    //       const Text('Modifier le produit'),
                    //     ],
                    //   ),
                    // ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.trashAlt,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text('Supprimer le produit'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    switch (value) {
                      case 'copy':
                        Map<String, dynamic> data = {
                          'idSeller': widget.vendeur.id,
                          'idProduit': widget.produit.id,
                        };
                        // Convertir l'objet JSON en chaîne de caractères (stringify)
                        String jsonString = jsonEncode(data);
                        await Clipboard.setData(ClipboardData(
                            text: textSharing + widget.produit.url));
                        Fluttertoast.showToast(
                            msg: 'Lien copié.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        break;
                      case 'share':
                        _shareLink();
                        break;
                      case 'update':
                        print('Value is 3');
                        break;
                      default:
                        deleteClone(widget.produit.id);
                        print('Value is something else');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF7E7E7E),
                          fontSize: 12,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF7FBFE),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // child: Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Text(
                  //     'Vues ( 23 )',
                  //     style: TextStyle(
                  //       fontFamily: 'Inter',
                  //       color: Color(0xFF1050FF),
                  //       fontSize: 12,
                  //       letterSpacing: 0.0,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    formatDate(widget.produit.product!.createdAt),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                // FFButtonWidget(
                //   onPressed: () async {
                //     print('Button pressed ...');
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ClickProduit(
                //           product: widget.produit.product,
                //         ),
                //       ),
                //     );
                //     // await showModalBottomSheet(
                //     //   isScrollControlled: true,
                //     //   backgroundColor: Colors.transparent,
                //     //   enableDrag: false,
                //     //   context: context,
                //     //   builder: (context) {
                //     //     return Padding(
                //     //       padding: MediaQuery.viewInsetsOf(context),
                //     //       child: Container(
                //     //         height: MediaQuery.sizeOf(context).height * 0.9,
                //     //         child: InfocommandeWidget(
                //     //           produit: widget.produit,
                //     //         ),
                //     //       ),
                //     //     );
                //     //   },
                //     // ).then((value) => safeSetState(() {}));
                //   },
                //   text: 'Commande (2)',
                //   options: FFButtonOptions(
                //     height: 30,
                //     padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                //     color: Color(0xFFFF9000),
                //     textStyle: TextStyle(
                //       fontFamily: 'Inter Tight',
                //       color: Colors.white,
                //       fontSize: 12,
                //       letterSpacing: 0.0,
                //     ),
                //     elevation: 0,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
