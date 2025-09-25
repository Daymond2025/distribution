import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/ad.dart';
import 'package:distribution_frontend/screens/Auth/accueil_screen.dart';
import 'package:distribution_frontend/screens/Auth/menu_activites_screen.dart';
import 'package:distribution_frontend/screens/Auth/message_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/produits_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/produits_clic_25.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/conversation_service.dart';
import 'package:distribution_frontend/services/home_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.data});
  static const routeName = '/messages';
  final dynamic data;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 3;
  bool isLoading = true;
  late Ad _ad;

  HomeService homeService = HomeService();

  Future<void> adReq() async {
    ApiResponse response = await homeService.getAd();
    if (response.error == null) {
      setState(() {
        data = response.data as dynamic;
        if (data['action'] == true) {
          _ad = Ad.fromJson(data['ad']);
          isLoading = false;
        }
      });

      if (data['action'] == true) {
        _showAdDialog();
      }
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  void _showAdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          child: isLoading
              ? _buildLoadingShimmer()
              : Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: _handleAdClick,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                _ad.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 3,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36.0),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black,
                                ),
                                color: Colors.white),
                            child: const Icon(
                              Icons.close_sharp,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void _handleAdClick() async {
    if (_ad.product != null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClickProduit(product: _ad.product!),
        ),
      );
    } else if (_ad.url != null) {
      Navigator.pop(context);
      final String url = _ad.url!;
      await canLaunch(url) ? launch(url) : print('Could not open link');
    }
  }

  dynamic data = [];

  //One signal
  Future<void> oneSignalInit() async {
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    // OneSignal.shared.setAppId("a7ce67a0-8e3c-4932-8bec-0e6c3245eaba");
    // OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
    //   OSNotificationDisplayType.notification;
    // });
    Future.delayed(const Duration(seconds: 10), () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? oneSignalUserToken =
          sharedPreferences.getString("onesignaltoken");
      // final status = await OneSignal.shared.getDeviceState();
      // if (oneSignalUserToken == null || oneSignalUserToken == '') {
      //   String token = status!.userId ?? '';
      //   sharedPreferences.setString("onesignaltoken", token);
      //   print(await oneSignalToken(token));
      //   log("TOKEN : $token");
      // }
    });
  }

  List<Widget> pages = [
    const AccueilScreen(data: []),
    const ProduitsScreen(),
    const ProduitsClic25Screen(),
    const MenuActivitesScreen(),
    const MessageScreen(),
  ];

  int message = 0;
  int activite = 0;
  Future<void> messagevue() async {
    int vue = await getConverationVue();
    setState(() {
      message = vue;
    });
  }

  List<Widget> appbar = [];

  void upDatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    //oneSignalInit();
    adReq();
    //messagevue();
    //activity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: colorYellow2,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        iconSize: 24,
        onTap: upDatePage,
        items: [
          // ACCUEIL
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: Image.asset(
                _page == 0
                    ? 'assets/images/acceuil_2.png'
                    : 'assets/images/acceuil_1.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'Accueil',
          ),

          // PRODUITS
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: Image.asset(
                _page == 1
                    ? 'assets/images/produit_2.png'
                    : 'assets/images/produit.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'Produits',
          ),

          // MES CLICS
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: const Offset(
                  0, 8), // 👉 déplace vers le bas (tu peux ajuster)
              child: Container(
                width: 44,
                height: 43,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(252, 232, 232, 1),
                  borderRadius: BorderRadius.circular(21.5),
                  border: Border.all(
                    width: 5,
                    color: const Color.fromRGBO(255, 0, 208, 0.17),
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  _page == 2
                      ? 'assets/images/main.png'
                      : 'assets/images/main.png',
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            label: '',
          ),

          // ACTIVITÉS
          BottomNavigationBarItem(
            icon: activite > 0
                ? Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: bottomBarWidth,
                        child: Image.asset(
                          _page == 3
                              ? 'assets/images/activite_2.png'
                              : 'assets/images/activite_1.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(249, 55, 79, 1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            activite.toString(),
                            style: const TextStyle(
                              color: colorwhite,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    width: bottomBarWidth,
                    child: Image.asset(
                      _page == 4
                          ? 'assets/images/activite_2.png'
                          : 'assets/images/activite_1.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
            label: 'Activités',
          ),

          // MESSAGE
          BottomNavigationBarItem(
            icon: message > 0
                ? Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: bottomBarWidth,
                        child: Image.asset(
                          _page == 5
                              ? 'assets/images/message_2.png'
                              : 'assets/images/message_1.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(249, 55, 79, 1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            message.toString(),
                            style: const TextStyle(
                              color: colorwhite,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    width: bottomBarWidth,
                    child: Image.asset(
                      _page == 5
                          ? 'assets/images/message_2.png'
                          : 'assets/images/message_1.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
            label: 'Message',
          ),
        ],
      ),
    );
  }
}
