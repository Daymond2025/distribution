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
import 'package:distribution_frontend/screens/newscreens/produit_comp/produit_comp_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloneScreen extends StatefulWidget {
  const CloneScreen({super.key});

  @override
  State<CloneScreen> createState() => _CloneScreenState();
}

class _CloneScreenState extends State<CloneScreen> {
  bool _loading = true;
  bool _noCnx = false;
  List<CloneProduct> _clones = [];
  CloneProductService cloneService = CloneProductService();
  UserService userService = UserService();

  File? _imageFile;

  Seller? seller;

  bool modif = false;

  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  Future<void> index() async {
    ApiResponse response = await cloneService.allProducts();
    if (response.error == null) {
      setState(() {
        _clones = response.data as List<CloneProduct>;
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
            appBar: AppBar(
                elevation: 0.5,
                backgroundColor: colorwhite,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: colorblack,
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ma boutique',
                      style: TextStyle(
                          color: colorblack,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    // Generated code for this ConditionalBuilder Widget...
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: Builder(
                        builder: (context) {
                          if (!modif) {
                            return Text(
                              seller?.nom_boutique ?? 'DAYMOND',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFFF9000)),
                            );
                          } else {
                            return Container(
                              width: 200,
                              child: Container(
                                width: 200,
                                child: TextFormField(
                                  controller: textController,
                                  focusNode: textFieldFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'TextField',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF9000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF9000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
                actions: [
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
                  PopupMenuButton(
                    color: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.more_vert_outlined,
                      ),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'write',
                        child: Row(
                          children: [
                            // const Icon(Icons.person),
                            // const SizedBox(
                            //   width: 6,
                            // ),
                            const Text('Partager ma boutique'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'clone',
                        child: Row(
                          children: [
                            // const Icon(Icons.category),
                            // const SizedBox(
                            //   width: 6,
                            // ),
                            const Text('Modifier la boutique'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (val) {
                      if (val == 'write') {
                      } else if (val == 'clone') {
                        setState(() {
                          modif = true;
                        });
                      }
                    },
                  )
                ]),
            body: _loading
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 10),
                            Container(
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
                              ),
                              child: Stack(
                                  alignment: AlignmentDirectional(1, 1),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: _imageFile == null
                                                ? seller?.couverture != null
                                                    ? Image.network(
                                                        seller!.couverture,
                                                      ).image
                                                    : Image.asset(
                                                        'assets/images/assistant.png',
                                                      ).image
                                                : FileImage(_imageFile!),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    modif
                                        ? Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0,
                                                    0,
                                                    valueOrDefault<double>(
                                                      modif ? 40.0 : 10.0,
                                                      0.0,
                                                    ),
                                                    valueOrDefault<double>(
                                                      modif ? 40.0 : 10.0,
                                                      0.0,
                                                    )),
                                            child: FlutterFlowIconButton(
                                              borderRadius: 100,
                                              buttonSize: 40,
                                              fillColor: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              icon: Icon(
                                                Icons.add_rounded,
                                                color: Color(0xFFFF9000),
                                                size: 24,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                                setState(() {
                                                  modif = true;
                                                });
                                                getImage(1);
                                              },
                                            ),
                                          )
                                        : Container(),
                                    if (modif)
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FlutterFlowIconButton(
                                            showLoadingIndicator: true,
                                            borderRadius: 100,
                                            buttonSize: 40,
                                            fillColor: Color(0xE0249689),
                                            icon: Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              editSeller();
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                          FlutterFlowIconButton(
                                            borderRadius: 100,
                                            buttonSize: 40,
                                            fillColor: Color(0xDBFF3643),
                                            icon: Icon(
                                              Icons.highlight_off,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                              setState(() {
                                                modif = false;
                                                _imageFile = null;
                                              });
                                            },
                                          ),
                                        ].divide(SizedBox(height: 40)),
                                      ),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                        CloneProduct clone = _clones[index];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 5),
                                          child: ProduitCompWidget(
                                              produit: clone,
                                              vendeur: seller as Seller),
                                        );

                                        // cardClone(clone);
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
                          ].divide(SizedBox(height: 20)),
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
                      clone.product.images[0],
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
  }
}
