import 'dart:io';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/screens/Auth/clone/product_clone_screen.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_icon_button.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/produit_comp/winning_clone_card.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:distribution_frontend/services/click_bonus_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MesClicsScreen extends StatefulWidget {
  const MesClicsScreen({super.key});

  @override
  State<MesClicsScreen> createState() => _MesClicsScreenState();
}

class _MesClicsScreenState extends State<MesClicsScreen> {
  bool _loading = true;
  bool _noCnx = false;
  List<CloneProduct> _clones = [];
  CloneProductService cloneService = CloneProductService();
  UserService userService = UserService();
  ClickBonusService clickBonusService = ClickBonusService();

  File? _imageFile;

  Seller? seller;

  bool modif = false;

  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  Future<void> index() async {
    ApiResponse response = await cloneService.winningClones();

    if (response.error == null) {
      setState(() {
        _clones =
            response.data as List<CloneProduct>; // si ton backend renvoie ça
        _loading = false;
        _noCnx = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      setState(() {
        _noCnx = true;
      });
    }
  }

  Future<void> deleteClone(int id) async {
    ApiResponse response = await cloneService.deleteClone(id);
    if (response.error == null) {
      index();
      AlertComponent().success(context, response.message.toString());
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

  @override
  void initState() {
    super.initState();
    index();
    getSeller();

    textFieldFocusNode ??= FocusNode();
  }

  Future getImage(int type) async {
    final pickedFile = await ImagePicker().pickImage(
        source: type == 1 ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<Seller?> getSeller() async {
    final prefs = await SharedPreferences.getInstance();
    final sellerJson = prefs.getString('seller');

    if (sellerJson != null) {
      final Map<String, dynamic> sellerMap = jsonDecode(sellerJson);

      print('infos vendeur : ${sellerMap}');
      setState(() {
        seller = Seller.fromJson(sellerMap);
        // Chiffrer les données
      });
      textController ??=
          TextEditingController(text: seller?.nom_boutique ?? 'DAYMOND');
      // print('info vendeur id ${seller?.toString()}');
      // encryptedData = encryptUserId(seller!.id.toString(), key: 'd@ymond2025');
      // print('info vendeur encryptedData ${encryptedData}');
      return Seller.fromJson(sellerMap);
    }
    return null;
  }

  void editSeller() async {
    File? image = _imageFile == null ? null : _imageFile;

    ApiResponse response = await userService.updateBoutique(
      image,
      textController.text,
    );

    AlertComponent().endLoading();

    if (response.error == null) {
      await AlertComponent()
          .textAlert(response.data.toString(), Colors.black54);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoadingScreen()),
          (route) => false);
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else {
      AlertComponent().error(context, response.error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            //appBar: AppBar(
            //elevation: 0.5,
            //backgroundColor: colorwhite,
            //leading: IconButton(
            //icon: const Icon(Icons.arrow_back),
            //onPressed: () => Navigator.pop(context),
            //color: colorblack,
            //),
            //title: Column(
            //mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.start,
            //children: [
            //const Text(
            //'Mes Produits Clics',
            //style: TextStyle(
            //color: colorblack,
            //fontWeight: FontWeight.w400,
            //fontSize: 15),
            //),
            // Generated code for this ConditionalBuilder Widget...
            //Padding(
            //padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            //child: Builder(
            //builder: (context) {
            //if (!modif) {
            //return Text(
            //seller?.nom_boutique ?? 'DAYMOND',
            //style: FlutterFlowTheme.of(context)
            //.bodyMedium
            //.override(
            //fontFamily: 'Inter',
            //letterSpacing: 0.0,
            //fontWeight: FontWeight.w900,
            //color: Color(0xFFFF9000)),
            //);
            //} else {
            //return Container(
            //width: 200,
            //child: Container(
            //width: 200,
            //child: TextFormField(
            //controller: textController,
            //focusNode: textFieldFocusNode,
            //autofocus: true,
            //obscureText: false,
            //decoration: InputDecoration(
            //isDense: true,
            //labelStyle: FlutterFlowTheme.of(context)
            //.labelMedium
            //.override(
            //fontFamily: 'Inter',
            //letterSpacing: 0.0,
            //),
            //hintText: 'TextField',
            //hintStyle: FlutterFlowTheme.of(context)
            //.labelMedium
            //.override(
            //fontFamily: 'Inter',
            //letterSpacing: 0.0,
            //),
            //enabledBorder: UnderlineInputBorder(
            //borderSide: BorderSide(
            //color: Color(0xFFFF9000),
            //width: 1,
            //),
            //borderRadius: BorderRadius.circular(8),
            //),
            //focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(
            //color: Color(0xFFFF9000),
            //width: 1,
            //),
            //borderRadius: BorderRadius.circular(8),
            //),
            //errorBorder: UnderlineInputBorder(
            //borderSide: BorderSide(
            //color:
            //FlutterFlowTheme.of(context).error,
            //width: 1,
            //),
            //borderRadius: BorderRadius.circular(8),
            //),
            //focusedErrorBorder: UnderlineInputBorder(
            //borderSide: BorderSide(
            //color:
            //FlutterFlowTheme.of(context).error,
            //width: 1,
            //),
            //borderRadius: BorderRadius.circular(8),
            //),
            //filled: true,
            //fillColor: FlutterFlowTheme.of(context)
            //.secondaryBackground,
            //),
            //style: FlutterFlowTheme.of(context)
            //.bodyMedium
            //.override(
            //fontFamily: 'Inter',
            //letterSpacing: 0.0,
            //),
            //cursorColor:
            //FlutterFlowTheme.of(context).primaryText,
            //validator: textControllerValidator
            //.asValidator(context),
            //),
            // ),
            //);
            //}
            //},
            //),
            //)
            //],
            //),
            //actions: [
            // Generated code for this IconButton Widget...
            // InkWell(
            //   child: Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         color: const Color.fromARGB(255, 245, 245, 245),
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(10),
            //         child: Image.asset(
            //           'assets/images/share.png',
            //           width: 19,
            //           height: 19,
            //         ),
            //       )),
            // ),
            // FlutterFlowIconButton(
            //   borderColor: Colors.transparent,
            //   borderRadius: 8,
            //   buttonSize: 40,
            //   fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            //   icon: Icon(
            //     Icons.share,
            //     color: FlutterFlowTheme.of(context).primaryText,
            //     size: 24,
            //   ),
            //   onPressed: () {
            //     print('IconButton pressed ...');
            //   },
            // ),
            //PopupMenuButton(
            //color: const Color(0xFFFFFFFF),
            //shape: RoundedRectangleBorder(
            //borderRadius: BorderRadius.circular(20.0),
            //),
            //child: const Padding(
            //padding: EdgeInsets.only(right: 10),
            //child: Icon(
            //Icons.more_vert_outlined,
            //),
            //),
            //itemBuilder: (context) => [
            //const PopupMenuItem(
            //value: 'write',
            //child: Row(
            //children: [
            // const Icon(Icons.person),
            // const SizedBox(
            //   width: 6,
            // ),
            //const Text('Partager ma boutique'),
            //],
            //),
            //),
            //const PopupMenuItem(
            //value: 'clone',
            //child: Row(
            //children: [
            // const Icon(Icons.category),
            // const SizedBox(
            //   width: 6,
            // ),
            //const Text('Modifier la boutique'),
            //],
            //),
            //),
            //],
            //onSelected: (val) {
            //if (val == 'write') {
            //} else if (val == 'clone') {
            //setState(() {
            //modif = true;
            //});
            //}
            //},
            //)
            //]),
            body: _loading
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ===== NOUVELLE BANNIÈRE UNIQUE =====
                            Container(
                              width: double.infinity,
                              height:
                                  105, // ajuste si ton image est plus grande/petite
                              child: Stack(
                                children: [
                                  // Image unique de la bannière
                                  Positioned.fill(
                                    child: Image.asset(
                                      "assets/images/nouvelle_banniere1.png", // ton image complète
                                      fit: BoxFit
                                          .cover, // ou BoxFit.fill selon le rendu attendu
                                    ),
                                  ),

                                  // Bouton retour au-dessus
                                  Positioned(
                                    left: 5,
                                    top: 10,
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ====== Texte "Mes produits" ======
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 0, 0),
                              child: Text(
                                'Mes produits',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),

                            // ====== Liste des produits ======
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: _clones.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _clones.length,
                                      itemBuilder: (_, index) {
                                        final clone = _clones[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: WinningCloneCard(
                                            clone: clone,
                                            vendeur: seller as Seller,
                                            onDelete: () =>
                                                deleteClone(clone.id),
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        'Vide!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              _loading ? colorblack : colorfond,
                                        ),
                                      ),
                                    ),
                            ),
                          ].divide(const SizedBox(height: 20)),
                        ),
                      ),
                    ),
                  ),
          )
        : kRessayer(context, () {
            index();
          });
  }

  Stack cardClone(CloneProduct clone) {
    if (clone.product != null) {
      return Stack(
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: colorwhite, // Fond blanc pour un design épuré
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductCloneScreen(
                    clone: clone,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        clone.product!.images[0],
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clone.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${clone.price} CFA",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                deleteClone(clone.id);
              },
            ),
          ),
        ],
      );
    } else {
      return Stack();
    }
  }
}
