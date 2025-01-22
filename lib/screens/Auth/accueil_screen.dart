import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/models/slide.dart';
import 'package:distribution_frontend/screens/Auth/actualite_screen.dart';
import 'package:distribution_frontend/screens/Auth/categorie_screen.dart';
import 'package:distribution_frontend/screens/Auth/centre_aide_screen.dart';
import 'package:distribution_frontend/screens/Auth/notifications/notification_screen.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/all_produits_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/recent_vendu_screen.dart';
import 'package:distribution_frontend/screens/Auth/profil_screen.dart';
import 'package:distribution_frontend/screens/Auth/service_assistance_screen.dart';
import 'package:distribution_frontend/screens/Auth/vainqueur/note_vainqueur_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/home_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:distribution_frontend/widgets/search_product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({
    super.key,
    required this.data,
  });
  final dynamic data;

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  bool pays = true;
  bool _loading = true;
  List<Product> _productsR = [];
  List<String> crystalV = ['', '', '', ''];
  List<Product> _productsV = [];
  int post = 0;

  late Seller seller;

  List<Slide> _covers = [];

  dynamic data = [];

  bool _loadingAcc = false;

  HomeService homeService = HomeService();

  Future<void> showVendeur() async {
    EasyLoading.dismiss();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilScreen(seller: seller),
        ));
  }

  Future<void> dataReq() async {
    ApiResponse response = await homeService.getDashboard();
    final prefs = await SharedPreferences.getInstance();
    if (response.error == null) {
      setState(() {
        data = response.data as dynamic;
        prefs.setString('seller', jsonEncode(data['seller']));

        seller = Seller.fromJson(data['seller']);

        _covers = (data['slides'] as List)
            .map((item) => Slide.fromJson(item))
            .toList();

        _productsR = data['recent_products'].isEmpty
            ? []
            : (data['recent_products'] as List)
                .map((item) => Product.fromJson(item))
                .toList();

        _productsV = data['sold_products'].isEmpty
            ? []
            : (data['sold_products'] as List)
                .map((item) => Product.fromJson(item))
                .toList();

        _loadingAcc = true;
        _loading = false;
      });
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

  errorAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
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

  chargementAlert() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
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

  @override
  void initState() {
    dataReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    String salutation;
    if (timeBackPressed.hour >= 0 && timeBackPressed.hour < 12) {
      salutation = 'Bonjour';
    } else {
      salutation = 'Bonsoir';
    }

    return Scaffold(
      //navbar
      drawer: _loading
          ? const Drawer()
          : Drawer(
              shape: LinearBorder(),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        chargementAlert();
                        showVendeur();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: const Border(
                            bottom: BorderSide(width: 0.5, color: Colors.grey),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/logo_login.png',
                                  height: 35,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  salutation,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  _loadingAcc
                                      ? '${seller.firstName} ${seller.lastName}'
                                      : '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  seller.picture ?? imgUserDefault),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main content with menu items
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMenuItem(
                            context,
                            icon: Icons.account_balance_wallet,
                            text: 'Portefeuille',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PortefeuilleScreen(),
                              ),
                            ),
                          ),
                          // _buildMenuItem(
                          //   context,
                          //   icon: Icons.new_releases,
                          //   text: 'Actu Daymond',
                          //   onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const ActualiteScreen(),
                          //     ),
                          //   ),
                          // ),
                          // _buildMenuItem(
                          //   context,
                          //   icon: Icons.emoji_events,
                          //   text: 'Les heureux gagnants',
                          //   onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const NoteVainqueurScreen(),
                          //     ),
                          //   ),
                          // ),
                          _buildMenuItem(
                            context,
                            icon: Icons.school,
                            text: 'Formation',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CentreAideScreen(),
                              ),
                            ),
                          ),
                          _buildMenuItem(
                            context,
                            icon: Icons.headset_mic,
                            text: 'Service assistances',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ServiceAssistanceScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Version Number at the Bottom
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'V2.4',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchR()),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 25,
                color: Color.fromRGBO(49, 49, 51, 1),
              ),
            ),
            // IconButton(
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const NotificationScreen1(),
            //     ),
            //   ),
            //   icon: const Icon(
            //     Icons.notifications,
            //     size: 25,
            //     color: Color.fromRGBO(49, 49, 51, 1),
            //   ),
            // ),
            // const SizedBox(
            //   width: 5,
            // ),
            InkWell(
              onTap: () {
                setState(() {
                  post = 0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActualiteScreen(),
                  ),
                );
              },
              child: Image.asset(
                post == 1
                    ? 'assets/images/actu.gif'
                    : 'assets/images/actu_daymond.png',
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(
              width: 5,
            )
          ],
          iconTheme: const IconThemeData(
            size: 25, //change size on your need
            color: colorblack, //change color on your need
          ),
          elevation: 0.3,
        ),
      ),
      body: !_loading
          ? RefreshIndicator(
              onRefresh: () async {
                await dataReq();
              },
              child: WillPopScope(
                onWillPop: () async {
                  final differeance =
                      DateTime.now().difference(timeBackPressed);
                  timeBackPressed = DateTime.now();
                  if (differeance >= const Duration(seconds: 2)) {
                    const String msg = 'Voulez-vous quitter l\'application?';
                    Fluttertoast.showToast(
                      msg: msg,
                      backgroundColor: const Color.fromARGB(179, 10, 10, 10),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    return false;
                  } else {
                    return true;
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              //couvertures
                              SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 0,
                                  ),
                                  color: colorwhite,
                                  child: carousel_slider.CarouselSlider(
                                      items: _covers.map((cover) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return InkWell(
                                              onTap: () {
                                                if (cover.product != null) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ClickProduit(
                                                        product: cover.product!,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        cover.picture),
                                                    fit: BoxFit.fill,
                                                    onError: (exception,
                                                            stackTrace) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                      options: carousel_slider.CarouselOptions(
                                        height: 170,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 0.975,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 10),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.3,
                                        scrollDirection: Axis.horizontal,
                                      )),
                                ),
                              ),

                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, left: 5.0, top: 5),
                                    decoration:
                                        const BoxDecoration(color: colorwhite),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CategorieScreen(),
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 20.0,
                                                left: 20.0,
                                                top: 8.0,
                                                bottom: 8.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: colorYellow2,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/categorie_1.png',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                const Text(
                                                  'Sélectionnez la catégorie',
                                                  style: TextStyle(
                                                    color: colorwhite,
                                                  ),
                                                ),
                                                const Text(''),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //Produits les plus vendus parties
                                        Container(
                                          padding: const EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 5,
                                          ),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: colorYellow,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Text('PRODUITS GAGNANTS'),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30),
                                                  child: Image.asset(
                                                    'assets/images/voir_plus.png',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ),
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RecentVenduScreen(
                                                      type: 'Produits gagnants',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: !_loading
                                                    ? _productsV
                                                        .map(
                                                          (product) =>
                                                              produitsCarroussel(
                                                            context,
                                                            product,
                                                            product.id,
                                                            product.images
                                                                    .isEmpty
                                                                ? imgProdDefault
                                                                : product
                                                                    .images[0],
                                                            product.price
                                                                .commission,
                                                            product.stock,
                                                            product.invisible,
                                                          ),
                                                        )
                                                        .toList()
                                                    : crystalV
                                                        .map((e) =>
                                                            produitLoadingCarroussel())
                                                        .toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Les plus recents partis
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 5.0,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                    ),
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(172, 255, 255, 255)),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 5,
                                          ),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: colorYellow,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Text('LES PLUS RECENTS'),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  child: Image.asset(
                                                    'assets/images/voir_plus.png',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const RecentVenduScreen(
                                                        type: 'Plus récents',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 0.60,
                                              // mainAxisExtent:
                                              //     !_loading ? 280 : 280,
                                            ),
                                            itemCount: !_loading
                                                ? _productsR.length
                                                : 4,
                                            itemBuilder: (_, index) {
                                              return !_loading
                                                  ? InkWell(
                                                      onTap: () => {},
                                                      child: produitsCard(
                                                        context,
                                                        _productsR
                                                            .elementAt(index),
                                                        _productsR
                                                            .elementAt(index)
                                                            .id,
                                                        _productsR
                                                            .elementAt(index)
                                                            .name,
                                                        _productsR
                                                            .elementAt(index)
                                                            .price
                                                            .price,
                                                        _productsR
                                                            .elementAt(index)
                                                            .reducedPrice,
                                                        _productsR
                                                            .elementAt(index)
                                                            .state
                                                            .name,
                                                        _productsR
                                                            .elementAt(index)
                                                            .star,
                                                        _productsR
                                                                .elementAt(
                                                                    index)
                                                                .images
                                                                .isEmpty
                                                            ? imgProdDefault
                                                            : _productsR
                                                                .elementAt(
                                                                    index)
                                                                .images[0],
                                                        _productsR
                                                            .elementAt(index)
                                                            .stock,
                                                        _productsR
                                                            .elementAt(index)
                                                            .unavailable,
                                                      ),
                                                    )
                                                  : produitLoadingCard3x3();
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllProduitScreen(),
                                              ),
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: const Color.fromRGBO(
                                                      252, 245, 245, 1)),
                                              child: const Text(
                                                'VOIR PLUS',
                                                style: TextStyle(
                                                  color: colorYellow,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : _buildLoadingView(),
    );
  }

  Widget _buildLoadingView() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 280,
        ),
        itemBuilder: (context, index) {
          return _buildLoadingCard();
        },
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 20,
            width: 100,
            color: Colors.grey.shade100,
          ),
          const SizedBox(height: 8),
          Container(
            height: 20,
            width: 60,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87, size: 28),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
    );
  }
}
