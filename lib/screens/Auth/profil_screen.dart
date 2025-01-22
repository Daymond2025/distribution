import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/models/user.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/screens/Auth/update_profil_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key, required this.seller});
  final Seller seller;

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  bool click = false;

  late Seller seller;

  List<dynamic> _commissions = [];

  int etoiles = 0;
  double nbX7 = 0;
  int nbActuel = 0;

  @override
  void initState() {
    super.initState();
    seller = widget.seller;
    etoiles = seller.stars;
    nbX7 = etoiles / 7;
    nbActuel = -7 * nbX7.floor() + etoiles;
    if (seller.recruiter != null) {
      commissions();
    }
  }

  logoutConfirmAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromLeft,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        isOverlayTapDismiss: false,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () {
            chargementAlert();
            logoutSeller();
            Navigator.of(context).pop();
          },
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Confirmé",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 154, 2),
              fontSize: 20,
            ),
          ),
        )
      ],
    ).show();
  }

  deleteConfirmAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromLeft,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        isOverlayTapDismiss: false,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () {
            chargementAlert();
            deleteVendeur();
            Navigator.of(context).pop();
          },
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Confirmé",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void deleteVendeur() async {
    ApiResponse response = await deleteVendeurUser();

    EasyLoading.dismiss();

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoadingScreen(),
        ),
        (route) => false,
      );

      Fluttertoast.showToast(
          msg: 'Votre compte a été supprimé.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.error);
    }
  }

  Future<void> logoutSeller() async {
    bool response = await logout();

    EasyLoading.dismiss();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
      (route) => false,
    );

    Fluttertoast.showToast(
        msg: 'Vous êtes deconnecté.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> commissions() async {
    ApiResponse response = await getCommissions();
    if (response.error == null) {
      setState(() {
        _commissions = response.data as List<dynamic>;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  chargementAlert() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
      status: 'Chargement...',
      dismissOnTap: false,
    );
  }

  //parrainage
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: const Text(
                          'Mon Leader',
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF707070)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 40),
                        width: 25,
                        height: 1.5,
                        color: Colors.grey.shade100,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 50),
                    width: 25,
                    height: 2,
                    color: Colors.black,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      seller.recruiter!.picture ??
                                          imgUserDefault),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  ' ${seller.recruiter!.firstName} ${seller.recruiter!.lastName}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                const Text(
                                  'Votre recruteur',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color.fromARGB(255, 106, 106, 106)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: double.infinity,
                        color: click
                            ? const Color.fromARGB(255, 249, 249, 249)
                            : colorfond,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Niveau',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${_commissions.length}/5',
                                  style: const TextStyle(color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        _commissions.isNotEmpty
                                            ? click = !click
                                            : click = click;
                                      },
                                    );
                                  },
                                  icon: click
                                      ? const Icon(Icons.arrow_drop_up)
                                      : const Icon(Icons.arrow_drop_down_sharp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            spreadRadius: 0.5,
                            offset: Offset(0, 1),
                          ),
                        ]),
                      ),
                      click
                          ? SingleChildScrollView(
                              child: Column(
                                children: _commissions
                                    .map(
                                      (e) => Container(
                                        padding: const EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: colorfond,
                                        ),
                                        width: double.infinity,
                                        child: Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black12,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        image: DecorationImage(
                                                          image: NetworkImage(e[
                                                                      'produit']
                                                                  ['photoprods']
                                                              [0]['photo']),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5),
                                                          child: Text(
                                                            e['produit']['nom'],
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          child: Text(
                                                            '1000  Fr',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  '${e['updated_at'].substring(8, 10)}/${e['updated_at'].substring(5, 7)}/${e['updated_at'].substring(0, 4)}',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(247, 251, 254, 1),
        iconTheme: const IconThemeData(color: colorblack),
        title: const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            'Mon Profil',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
          ),
        ),
        actions: [
          seller.recruiter != null
              ? InkWell(
                  onTap: () {
                    openDialog();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      image: DecorationImage(
                        image: NetworkImage(
                          seller.recruiter!.picture ?? imgUserDefault,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              : Container(),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            icon: const Icon(
              Icons.more_vert,
              size: 25,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.black87,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Modifier',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black87,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Se déconnecter',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black87,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Supprimer',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfilScreen(
                      seller: seller,
                    ),
                  ),
                );
              }
              if (value == 2) {
                logoutConfirmAlert(
                    'Etes vous sure de vouloir deconnecter votre compte?');
              }
              if (value == 3) {
                deleteConfirmAlert(
                    ' Voulez-vous vraiment supprimer votre compte Daymond définitivement');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 7,
                    spreadRadius: 2,
                    offset: Offset(0, 1),
                  )
                ],
                color: Color(0xFFFFC000),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                height: 210,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        image: DecorationImage(
                          image: NetworkImage(
                            seller.picture ?? imgUserDefault,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${seller.firstName} ${seller.lastName}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: colorwhite,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Membre depuis le ${seller.createdAt.substring(8, 10)}/${seller.createdAt.substring(5, 7)}/${seller.createdAt.substring(0, 4)} à ${seller.createdAt.substring(11, 16)}',
                        style: const TextStyle(
                          color: colorwhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/ci.png',
                        width: 25,
                        height: 25,
                      ),
                      title: Text(
                        seller.country,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/ville.png',
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        seller.city,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/profession.png',
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        seller.job.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/telephonne.png',
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        seller.phoneNumber,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: Icon(
                        Icons.mail,
                        color:
                            seller.email != null ? Colors.black45 : colorannule,
                      ),
                      title: Text(
                        seller.email != null
                            ? seller.email.toString()
                            : 'Confirmer votre mail',
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              seller.email != null ? colorblack : colorannule,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        width: 200,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: nbActuel > 0
                                        ? colorYellow
                                        : const Color(
                                            0x3CFFC107,
                                          ),
                                    size: 23),
                                Icon(
                                  Icons.star,
                                  color: nbActuel > 1
                                      ? colorYellow
                                      : const Color(
                                          0x3CFFC107,
                                        ),
                                  size: 23,
                                ),
                                Icon(
                                  Icons.star,
                                  color: nbActuel > 2
                                      ? colorYellow
                                      : const Color(
                                          0x3CFFC107,
                                        ),
                                  size: 23,
                                ),
                                Icon(
                                  Icons.star,
                                  color: nbActuel > 3
                                      ? colorYellow
                                      : const Color(
                                          0x3CFFC107,
                                        ),
                                  size: 23,
                                ),
                                Icon(
                                  Icons.star,
                                  color: nbActuel > 4
                                      ? colorYellow
                                      : const Color(
                                          0x3CFFC107,
                                        ),
                                  size: 23,
                                ),
                                Icon(
                                  Icons.star,
                                  color: nbActuel > 5
                                      ? colorYellow
                                      : const Color(
                                          0x3CFFC107,
                                        ),
                                  size: 23,
                                ),
                                Icon(
                                  Icons.star,
                                  color: nbActuel > 6
                                      ? colorYellow
                                      : const Color(
                                          0x3CFFC107,
                                        ),
                                ),
                              ],
                            ),
                            nbX7.floor() != 0
                                ? Container(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '* ${nbX7.floor()}',
                                      style: const TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:distribution_frontend/api_response.dart';
// import 'package:distribution_frontend/constante.dart';
// import 'package:distribution_frontend/models/seller.dart';
// import 'package:distribution_frontend/models/user.dart';
// import 'package:distribution_frontend/screens/loading_screen.dart';
// import 'package:distribution_frontend/screens/login_screen.dart';
// import 'package:distribution_frontend/services/user_service.dart';
// import 'package:flutter/material.dart';
// import 'package:distribution_frontend/screens/Auth/update_profil_screen.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class ProfilScreen extends StatefulWidget {
//   const ProfilScreen({super.key, required this.seller});
//   final Seller seller;

//   @override
//   State<ProfilScreen> createState() => _ProfilScreenState();
// }

// class _ProfilScreenState extends State<ProfilScreen> {
//   bool click = false;

//   late Seller seller;

//   List<dynamic> _commissions = [];

//   int etoiles = 0;
//   double nbX7 = 0;
//   int nbActuel = 0;

//   @override
//   void initState() {
//     super.initState();
//     seller = widget.seller;
//     etoiles = seller.stars;
//     nbX7 = etoiles / 7;
//     nbActuel = -7 * nbX7.floor() + etoiles;
//     if (seller.recruiter != null) {
//       commissions();
//     }
//   }

//   logoutConfirmAlert(String text) {
//     var alertStyle = AlertStyle(
//         animationType: AnimationType.fromLeft,
//         isCloseButton: false,
//         titleStyle: const TextStyle(color: Colors.black),
//         animationDuration: const Duration(milliseconds: 100),
//         alertBorder:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//         overlayColor: Colors.black54,
//         isOverlayTapDismiss: false,
//         backgroundColor: Colors.white);

//     Alert(
//       context: context,
//       style: alertStyle,
//       type: AlertType.info,
//       title: text,
//       buttons: [
//         DialogButton(
//           onPressed: () {
//             chargementAlert();
//             logoutSeller();
//             Navigator.of(context).pop();
//           },
//           width: 120,
//           color: Colors.orange.shade100,
//           child: const Text(
//             "Confirmé",
//             style: TextStyle(color: Colors.orange, fontSize: 20),
//           ),
//         ),
//         DialogButton(
//           onPressed: () => Navigator.of(context).pop(),
//           width: 120,
//           color: Colors.orange.shade100,
//           child: const Text(
//             "Retour",
//             style: TextStyle(color: Colors.orange, fontSize: 20),
//           ),
//         )
//       ],
//     ).show();
//   }

//   deleteConfirmAlert(String text) {
//     var alertStyle = AlertStyle(
//         animationType: AnimationType.fromLeft,
//         isCloseButton: false,
//         titleStyle: const TextStyle(color: Colors.black),
//         animationDuration: const Duration(milliseconds: 100),
//         alertBorder:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//         overlayColor: Colors.black54,
//         isOverlayTapDismiss: false,
//         backgroundColor: Colors.white);

//     Alert(
//       context: context,
//       style: alertStyle,
//       type: AlertType.info,
//       title: text,
//       buttons: [
//         DialogButton(
//           onPressed: () {
//             chargementAlert();
//             deleteVendeur();
//             Navigator.of(context).pop();
//           },
//           width: 120,
//           color: Colors.orange.shade100,
//           child: const Text(
//             "Confirmé",
//             style: TextStyle(color: Colors.orange, fontSize: 20),
//           ),
//         ),
//         DialogButton(
//           onPressed: () => Navigator.of(context).pop(),
//           width: 120,
//           color: Colors.orange.shade100,
//           child: const Text(
//             "Retour",
//             style: TextStyle(color: Colors.orange, fontSize: 20),
//           ),
//         )
//       ],
//     ).show();
//   }

//   void deleteVendeur() async {
//     ApiResponse response = await deleteVendeurUser();

//     EasyLoading.dismiss();

//     if (response.error == null) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => const LoadingScreen(),
//         ),
//         (route) => false,
//       );

//       Fluttertoast.showToast(
//           msg: 'Votre compte a été supprimé.',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     } else {
//       print(response.error);
//     }
//   }

//   Future<void> logoutSeller() async {
//     bool response = await logout();

//     EasyLoading.dismiss();

//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => const LoadingScreen(),
//       ),
//       (route) => false,
//     );

//     Fluttertoast.showToast(
//         msg: 'Vous êtes deconnecté.',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }

//   Future<void> commissions() async {
//     ApiResponse response = await getCommissions();
//     if (response.error == null) {
//       setState(() {
//         _commissions = response.data as List<dynamic>;
//       });
//     } else if (response.error == unauthorized) {
//       logout().then((value) => {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 (route) => false)
//           });
//     } else {}
//   }

//   chargementAlert() {
//     EasyLoading.instance
//       ..displayDuration = const Duration(milliseconds: 2000)
//       ..indicatorType = EasyLoadingIndicatorType.doubleBounce
//       ..loadingStyle = EasyLoadingStyle.light
//       ..indicatorSize = 45.0
//       ..radius = 10.0
//       ..userInteractions = false
//       ..dismissOnTap = false;

//     EasyLoading.show(
//       status: 'Chargement...',
//       dismissOnTap: false,
//     );
//   }

//   //parrainage
//   Future openDialog() => showDialog(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) => Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height - 40,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 13),
//                         child: const Text(
//                           'Mon Leader',
//                           style:
//                               TextStyle(fontSize: 20, color: Color(0xFF707070)),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 40),
//                         width: 25,
//                         height: 1.5,
//                         color: Colors.grey.shade100,
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(left: 50),
//                     width: 25,
//                     height: 2,
//                     color: Colors.black,
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(36),
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                       seller.recruiter!.picture ?? imgUserDefault),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   ' ${seller.recruiter!.firstName} ${seller.recruiter!.lastName}',
//                                   style: const TextStyle(
//                                       fontSize: 16, color: Colors.black),
//                                 ),
//                                 const Text(
//                                   'Votre recruteur',
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       color:
//                                           Color.fromARGB(255, 106, 106, 106)),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 10),
//                         width: double.infinity,
//                         color: click
//                             ? const Color.fromARGB(255, 249, 249, 249)
//                             : colorfond,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Niveau',
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 18),
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   '${_commissions.length}/5',
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     setState(
//                                       () {
//                                         _commissions.isNotEmpty
//                                             ? click = !click
//                                             : click = click;
//                                       },
//                                     );
//                                   },
//                                   icon: click
//                                       ? const Icon(Icons.arrow_drop_up)
//                                       : const Icon(Icons.arrow_drop_down_sharp),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 1,
//                             spreadRadius: 0.5,
//                             offset: Offset(0, 1),
//                           ),
//                         ]),
//                       ),
//                       click
//                           ? SingleChildScrollView(
//                               child: Column(
//                                 children: _commissions
//                                     .map(
//                                       (e) => Container(
//                                         padding: const EdgeInsets.all(7.0),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: colorfond,
//                                         ),
//                                         width: double.infinity,
//                                         child: Container(
//                                           height: 50,
//                                           decoration: const BoxDecoration(
//                                             border: Border(
//                                               bottom: BorderSide(
//                                                 width: 1,
//                                                 color: Colors.black12,
//                                               ),
//                                             ),
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       margin: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 20),
//                                                       width: 40,
//                                                       height: 40,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(12),
//                                                         image: DecorationImage(
//                                                           image: NetworkImage(e[
//                                                                       'produit']
//                                                                   ['photoprods']
//                                                               [0]['photo']),
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical: 5),
//                                                           child: Text(
//                                                             e['produit']['nom'],
//                                                             style: const TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                         ),
//                                                         const Expanded(
//                                                           child: Text(
//                                                             '1000  Fr',
//                                                             style: TextStyle(
//                                                               color:
//                                                                   Colors.blue,
//                                                               fontSize: 14,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: Text(
//                                                   '${e['updated_at'].substring(8, 10)}/${e['updated_at'].substring(5, 7)}/${e['updated_at'].substring(0, 4)}',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                     .toList(),
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color.fromRGBO(247, 251, 254, 1),
//         iconTheme: const IconThemeData(color: colorblack),
//         title: const Padding(
//           padding: EdgeInsets.only(left: 0),
//           child: Text(
//             'Mon Profil',
//             style:
//                 TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
//           ),
//         ),
//         actions: [
//           seller.recruiter != null
//               ? InkWell(
//                   onTap: () {
//                     openDialog();
//                   },
//                   child: Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(48),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           seller.recruiter!.picture ?? imgUserDefault,
//                         ),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(),
//           PopupMenuButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             icon: const Icon(
//               Icons.more_vert,
//               size: 25,
//               color: Colors.black,
//             ),
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: 1,
//                 child: Container(
//                   padding: EdgeInsets.zero,
//                   child: const Row(
//                     children: [
//                       Icon(
//                         Icons.edit,
//                         color: Colors.black87,
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Modifier',
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 2,
//                 child: Container(
//                   padding: EdgeInsets.zero,
//                   child: const Row(
//                     children: [
//                       Icon(
//                         Icons.logout,
//                         color: Colors.black87,
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Se déconnecter',
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//                 PopupMenuItem(
//                 value: 2,
//                 child: Container(
//                   padding: EdgeInsets.zero,
//                   child: const Row(
//                     children: [
//                       Icon(
//                         Icons.logout,
//                         color: Colors.black87,
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Se déconnecter',
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             ],
//             onSelected: (value) {
//               if (value == 1) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UpdateProfilScreen(
//                       seller: seller,
//                     ),
//                   ),
//                 );
//               }
//               if (value == 2) {
//                 logoutConfirmAlert(
//                     'Etes vous sure de vouloir deconnecter votre compte?');
//               }
//               // if (value == 3) {
//               //   deleteConfirmAlert(
//               //       'Etes vous sure de vouloir supprimer votre compte?');
//               // }
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.sizeOf(context).width,
//               decoration: const BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 7,
//                     spreadRadius: 2,
//                     offset: Offset(0, 1),
//                   )
//                 ],
//                 color: Color(0xFFFFC000),
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(30),
//                   bottomLeft: Radius.circular(30),
//                 ),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.only(top: 20),
//                 alignment: Alignment.center,
//                 height: 210,
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 90,
//                       height: 90,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(48),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                             seller.picture ?? imgUserDefault,
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Text(
//                         '${seller.firstName} ${seller.lastName}',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: colorwhite,
//                           fontSize: 24,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Text(
//                         'Membre depuis le ${seller.createdAt.substring(8, 10)}/${seller.createdAt.substring(5, 7)}/${seller.createdAt.substring(0, 4)} à ${seller.createdAt.substring(11, 16)}',
//                         style: const TextStyle(
//                           color: colorwhite,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.zero,
//                     child: ListTile(
//                       leading: Image.asset(
//                         'assets/images/ci.png',
//                         width: 25,
//                         height: 25,
//                       ),
//                       title: Text(
//                         seller.country,
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.zero,
//                     child: ListTile(
//                       leading: Image.asset(
//                         'assets/images/ville.png',
//                         width: 27,
//                         height: 27,
//                       ),
//                       title: Text(
//                         seller.city,
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.zero,
//                     child: ListTile(
//                       leading: Image.asset(
//                         'assets/images/profession.png',
//                         width: 27,
//                         height: 27,
//                       ),
//                       title: Text(
//                         seller.job.toString(),
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.zero,
//                     child: ListTile(
//                       leading: Image.asset(
//                         'assets/images/telephonne.png',
//                         width: 27,
//                         height: 27,
//                       ),
//                       title: Text(
//                         seller.phoneNumber,
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.zero,
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.mail,
//                         color: seller.email != null
//                             ? Colors.black45
//                             : colorannule,
//                       ),
//                       title: Text(
//                         seller.email != null
//                             ? seller.email.toString()
//                             : 'Confirmer votre mail',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color:
//                               seller.email != null ? colorblack : colorannule,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 40),
//               alignment: Alignment.center,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.zero,
//                         width: 200,
//                         height: 30,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.star,
//                                     color: nbActuel > 0
//                                         ? colorYellow
//                                         : const Color(
//                                             0x3CFFC107,
//                                           ),
//                                     size: 23),
//                                 Icon(
//                                   Icons.star,
//                                   color: nbActuel > 1
//                                       ? colorYellow
//                                       : const Color(
//                                           0x3CFFC107,
//                                         ),
//                                   size: 23,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: nbActuel > 2
//                                       ? colorYellow
//                                       : const Color(
//                                           0x3CFFC107,
//                                         ),
//                                   size: 23,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: nbActuel > 3
//                                       ? colorYellow
//                                       : const Color(
//                                           0x3CFFC107,
//                                         ),
//                                   size: 23,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: nbActuel > 4
//                                       ? colorYellow
//                                       : const Color(
//                                           0x3CFFC107,
//                                         ),
//                                   size: 23,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: nbActuel > 5
//                                       ? colorYellow
//                                       : const Color(
//                                           0x3CFFC107,
//                                         ),
//                                   size: 23,
//                                 ),
//                                 Icon(
//                                   Icons.star,
//                                   color: nbActuel > 6
//                                       ? colorYellow
//                                       : const Color(
//                                           0x3CFFC107,
//                                         ),
//                                 ),
//                               ],
//                             ),
//                             nbX7.floor() != 0
//                                 ? Container(
//                                     padding: const EdgeInsets.only(left: 5),
//                                     child: Text(
//                                       '* ${nbX7.floor()}',
//                                       style: const TextStyle(
//                                         color: colorblack,
//                                       ),
//                                     ),
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
