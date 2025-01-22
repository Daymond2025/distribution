// import 'package:distribution_frontend/api_response.dart';
// import 'package:distribution_frontend/constante.dart';
// import 'package:distribution_frontend/models/user.dart';
// import 'package:distribution_frontend/screens/Auth/actualite_screen.dart';
// import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_screen.dart';
// import 'package:distribution_frontend/screens/Auth/profil_screen.dart';
// import 'package:distribution_frontend/screens/Auth/service_assistance_screen.dart';
// import 'package:distribution_frontend/screens/Auth/vainqueur/note_vainqueur_screen.dart';
// import 'package:distribution_frontend/screens/login_screen.dart';
// import 'package:distribution_frontend/services/home_service.dart';
// import 'package:distribution_frontend/services/user_service.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_country_code_picker/fl_country_code_picker.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// import '../screens/Auth/centre_aide_screen.dart';

// class NavBar extends StatefulWidget {
//   const NavBar({Key? key, required this.nom, required this.image})
//       : super(key: key);
//   final String nom;
//   final String image;
//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   final contryPicker = const FlCountryCodePicker();
//   CountryCode? countryCode;
//   String nom = '';
//   String image = '';
//   bool _loading = false;
//   List<dynamic> _icon = [];

//   bool _noCnx = false;

//   Future<void> getIcons() async {
//     ApiResponse response = await getIcon();
//     if (response.error == null) {
//       setState(() {
//         _icon = response.data as List<dynamic>;
//         _loading = true;
//       });
//     } else if (response.error == unauthorized) {
//       logout().then((value) => {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 (route) => false)
//           });
//     } else {}
//   }

//   errorAlert(String text) {
//     var alertStyle = AlertStyle(
//         animationType: AnimationType.fromTop,
//         isCloseButton: false,
//         titleStyle: const TextStyle(color: Colors.black),
//         animationDuration: const Duration(milliseconds: 100),
//         alertBorder:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//         overlayColor: Colors.black54,
//         backgroundColor: Colors.white);

//     Alert(
//       context: context,
//       style: alertStyle,
//       type: AlertType.error,
//       title: text,
//       buttons: [
//         DialogButton(
//           onPressed: () => Navigator.pop(context),
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

//   //show transaction
//   Future<void> showVendeur() async {
//     ApiResponse response = await getUserDetail();

//     EasyLoading.dismiss();

//     if (response.error == null) {
//       setState(() {
//         _noCnx = false;
//         vendeur = response.data as User;
//       });

//       // ignore: use_build_context_synchronously
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProfilScreen(vendeur: vendeur),
//           ));
//     } else if (response.error == unauthorized) {
//       logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false));
//     } else {
//       setState(() {
//         _noCnx = true;
//       });
//     }
//   }

//   chargementAlert() {
//     EasyLoading.instance
//       ..displayDuration = const Duration(milliseconds: 2000)
//       ..indicatorType = EasyLoadingIndicatorType.circle
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

//   @override
//   void initState() {
//     image = widget.image;
//     nom = widget.nom;
//     getIcons();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //temps
//     final currentTime = DateTime.now();
//     final timeFormat = DateFormat('HH:mm');
//     final time = timeFormat.format(currentTime);

//     String _greeting = 'Bonjour';
//     if (int.parse(time.split(':')[0]) > 18) {
//       _greeting = 'Bonsoir';
//     }
//     return !_noCnx
//         ? Drawer(
//         backgroundColor: Colors.white,
//             child: ListView(

//               children: <Widget>[
//                 DrawerHeader(
//                   padding: const EdgeInsets.all(0),
//                   curve: Curves.easeOut,
//                   decoration: const BoxDecoration(
//                     color: colorwhite,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(1.0, 2.0),
//                         blurRadius: 5,
//                         spreadRadius: .2,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.zero,
//                         width: MediaQuery.of(context).size.width,
//                         height: 70,
//                         color: colorYellow,
//                         child: _loading
//                             ? Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: NetworkImage(
//                                       _icon[0]['photo'],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Container(),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           chargementAlert();
//                           showVendeur();
//                         },
//                         child: Stack(
//                           children: [
//                             Container(
//                               padding:
//                                   const EdgeInsets.only(left: 15, right: 85),
//                               height: 90,
//                               alignment: Alignment.centerLeft,
//                               width: MediaQuery.of(context).size.width,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     _greeting,
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontStyle: FontStyle.italic,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 2,
//                                   ),
//                                   Text(
//                                     nom,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(fontSize: 24),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               top: 15,
//                               bottom: 15,
//                               right: 20,
//                               child: Container(
//                                 height: 60,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                     color: colorwhite,
//                                     image: DecorationImage(
//                                       image: NetworkImage(image),
//                                       fit: BoxFit.contain,
//                                     ),
//                                     borderRadius: BorderRadius.circular(32)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   leading: Image.asset(
//                     'assets/images/portefeuille_v3.png',
//                     width: 35,
//                   ),
//                   title: const Text(
//                     'Portefeuille',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                     ),
//                   ),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const PortefeuilleScreen(),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Image.asset(
//                     'assets/images/actu_daymond.png',
//                     width: 35,
//                   ),
//                   title: const Text(
//                     'Actu Daymond',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                     ),
//                   ),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ActualiteScreen(),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Image.asset(
//                     'assets/images/heureux_gagnant.png',
//                     width: 35,
//                   ),
//                   title: const Text(
//                     'Les heureux gagnants',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                     ),
//                   ),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const NoteVainqueurScreen(),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Image.asset(
//                     'assets/images/question.png',
//                     width: 35,
//                   ),
//                   title: const Text(
//                     'Centre d\'aide ',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                     ),
//                   ),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CentreAideScreen(),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Image.asset(
//                     'assets/images/service_assistance.png',
//                     width: 35,
//                   ),
//                   title: const Text(
//                     'Service assistances ',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                     ),
//                   ),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ServiceAssistanceScreen(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : kRessayer(context, () {
//             chargementAlert();
//             showVendeur();
//           });
//   }
// }
