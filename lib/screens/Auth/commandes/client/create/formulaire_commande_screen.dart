import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/models/city.dart';
import 'package:distribution_frontend/services/city_service.dart';
import 'package:distribution_frontend/widgets/select_ambassador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormulaireCommandeScreen extends StatefulWidget {
  const FormulaireCommandeScreen({
    super.key,
    required this.product,
    required this.category,
  });
  final Product product;
  final String category;

  @override
  State<FormulaireCommandeScreen> createState() =>
      _FormulaireCommandeScreenState();
}

class _FormulaireCommandeScreenState extends State<FormulaireCommandeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _localisationController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  final bool _noCnx = false;

  String _date = '';
  String _heure = '';

  bool opentaille = false;
  String taille = '';

  bool opencouleur = false;
  String couleur = '';

  DateTime dateTime = DateTime.now();
  int _nbcmd = 1;

  int _ambassadorId = 0;
  String _ambassadorCompany = '';

  int unitPriceDelivery = 0;
  String cityId = '';

  int prixTotal = 0;

  bool _loading = false;

  Seller? seller;

  Future<Seller?> getSeller() async {
    final prefs = await SharedPreferences.getInstance();
    final sellerJson = prefs.getString('seller');

    if (sellerJson != null) {
      final Map<String, dynamic> sellerMap = jsonDecode(sellerJson);
      print('infos vendeur : ${Seller.fromJson(sellerMap)}');
      setState(() {
        seller = Seller.fromJson(sellerMap);
      });
      print('info vendeur id ${seller?.id}');
      return Seller.fromJson(sellerMap);
    }
    return null;
  }

  void onChange(String value) {
    setState(() {
      prixTotal = value == ''
          ? unitPriceDelivery * _nbcmd
          : (int.parse(value) + unitPriceDelivery) * _nbcmd;
    });
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

  Future<void> createCommand() async {
    ApiResponse response = await storeCommandeClient(
      widget.product.id,
      cityId,
      _nomController.text,
      _contactController.text,
      _nbcmd,
      _date,
      _heure,
      _prixController.text,
      _ambassadorId,
      _detailController.text,
      taille,
      couleur,
    );

    EasyLoading.dismiss();

    setState(() {
      _loading = !_loading;
    });

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);

      showDialogConfirmation();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    }
  }

  void _showMultipleSelect() async {
    List<String> data = [];
    final results = await showDialog(
        context: context,
        builder: (BuildContext context) => SelectAmbassador(
            items: cities, currentCity: widget.product.shop.city.id));

    if (results != null) {
      print('results $results');
      setState(() {
        data = results as List<String>;
        cityId = results[0];
        _localisationController.text = results[1];

        unitPriceDelivery = results[2] == 'true'
            ? widget.product.delivery.city
            : widget.product.delivery.noCity;

        if (data.length > 3) {
          _ambassadorId = int.parse(results[3]);
          _ambassadorCompany = '${results[4]} ${results[5]}';
        } else {
          _ambassadorId = 0;
          _ambassadorCompany =
              results[2] == 'true' ? 'Livraison à domicile' : '';
        }

        onChange(_prixController.text);
      });
    } else {}
  }

  //initialize
  List<City> cities = [];
  getCities() async {
    ApiResponse response = await CityService().getCityAndFocalPoint();

    if (response.error == null) {
      setState(() {
        cities = response.data as List<City>;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false),
          });
    } else {}
  }

  @override
  void initState() {
    super.initState();

    getCities();
    getSeller();
    print('info vendeur id ${seller?.id}');

    _nomController.text = '';

    if (widget.product.type == 'grossiste') {
      prixTotal = widget.product.price.min;
    } else {
      _prixController.text = widget.product.price.price.toString();
      prixTotal = widget.product.price.price + 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle:
                    const TextStyle(color: colorblack, fontSize: 17),
                title: const Text('Formulaire de commande'),
                backgroundColor: colorwhite,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClickProduit(
                            product: widget.product,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          left: 5,
                          right: 0,
                        ),
                        decoration: const BoxDecoration(
                          color: colorwhite,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                        ),
                                        child: Image.network(
                                          widget.product.images[0],
                                          height: 80,
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            child: Text(
                                              widget.product.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.zero,
                                                child: const Text(
                                                  'Qualité du produit',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: colorblack,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (_nbcmd != 1) {
                                                          _nbcmd = _nbcmd - 1;
                                                          onChange(widget
                                                                      .product
                                                                      .type ==
                                                                  'grossiste'
                                                              ? _prixController
                                                                  .text
                                                              : widget.product
                                                                  .price.price
                                                                  .toString());
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      size: 30,
                                                      color: _nbcmd == 1
                                                          ? const Color
                                                              .fromARGB(255,
                                                              219, 219, 219)
                                                          : colorYellow2,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(_nbcmd.toString()),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _nbcmd = _nbcmd + 1;
                                                        onChange(widget.product
                                                                    .type ==
                                                                'grossiste'
                                                            ? _prixController
                                                                .text
                                                            : widget.product
                                                                .price.price
                                                                .toString());
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle_rounded,
                                                      size: 30,
                                                      color: colorYellow2,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.star,
                                        color: colorYellow,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                          left: 5,
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: colorYellow,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          widget.product.state.name,
                                          style: const TextStyle(
                                            color: colorblack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 30,
                              height: 1,
                              color: Colors.black12,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.product.type == 'grossiste'
                                          ? 'Prix grossiste unitaire : '
                                          : widget.product.type == 'commission'
                                              ? 'Prix de vente : '
                                              : 'Prix de vente : ',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: colorblack,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${NumberFormat("###,###", 'en_US').format(widget.product.price.price).replaceAll(',', ' ')} F CFA',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: colorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            widget.product.type == 'grossiste'
                                ? Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Prix de vente : ',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: colorblack,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'de ${NumberFormat("###,###", 'en_US').format(widget.product.price.min).replaceAll(',', ' ')}  Fr à ${NumberFormat("###,###", 'en_US').format(widget.product.price.max).replaceAll(',', ' ')}  Fr',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: colorBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Commission : ',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: colorblack,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${NumberFormat("###,###", 'en_US').format(widget.product.price.commission).replaceAll(',', ' ')}  Fr',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: colorBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //taille
                            widget.product.sizes.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        opentaille = !opentaille;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: colorwhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Taille du produit'),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            opentaille
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: colorwhite,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(top: 8),
                                    child: widget.product.sizes.isNotEmpty
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing:
                                                    8.0, // Espace entre les éléments
                                                mainAxisSpacing: 8.0,
                                                mainAxisExtent:
                                                    30, // Réduction de la hauteur des cellules
                                              ),
                                              itemCount:
                                                  widget.product.sizes.length,
                                              itemBuilder: (_, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      taille = widget
                                                          .product.sizes
                                                          .elementAt(index);
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: taille ==
                                                              widget
                                                                  .product.sizes
                                                                  .elementAt(
                                                                      index)
                                                          ? Colors.amber
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Text(
                                                      widget.product.sizes
                                                          .elementAt(index),
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: const Text(
                                                'Pas de taille disponible'),
                                          ),
                                  )
                                : Container(),

                            const SizedBox(
                              height: 8,
                            ),
                            //couleur
                            widget.product.colors.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        opencouleur = !opencouleur;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: colorwhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Selectionnez la couleur du produit'),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            /* opencouleur
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: colorwhite,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(top: 8),
                                    child: widget.product.colors.isNotEmpty
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 12.0,
                                                mainAxisSpacing: 12.0,
                                                mainAxisExtent: 20,
                                              ),
                                              itemCount: widget.product.colors.length,
                                              itemBuilder: (_, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      couleur = widget.product.colors
                                                          .elementAt(
                                                              index)['nom'];
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.zero,
                                                    alignment: Alignment.center,
                                                    color: couleur ==
                                                            widget.product.colors
                                                                    .elementAt(
                                                                        index)[
                                                                'nom']
                                                        ? Colors.amber
                                                        : Colors.transparent,
                                                    child: Text(
                                                      widget.product.colors.elementAt(
                                                          index)['nom'],
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: const Text(
                                                'Pas de taille disponible'),
                                          ),
                                  )
                                : Container(),*/
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: colorwhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _nomController,
                                decoration: kCmdInputDecoration(
                                    'Nom complet du client'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Le champs ne peut pas être vide!';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: colorwhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _contactController,
                                keyboardType: TextInputType.phone,
                                decoration:
                                    kCmdInputDecoration('Contact 1 du client'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Le champs ne peut pas être vide!';
                                  } else if (value.length < 10 ||
                                      value.length >= 11) {
                                    return 'Le numéro doit comporter 10 chiffres!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: colorwhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _contact2Controller,
                                keyboardType: TextInputType.phone,
                                decoration: kCmdInputDecoration(
                                    'Contact 2 du client (facultatif)'),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () => _showMultipleSelect(),
                              child: _localisationController.text == ''
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 20,
                                      ),
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                        color: colorwhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Localisation du client',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 104, 104, 104),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorwhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Localisation du client',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 104, 104, 104),
                                                  ),
                                                ),
                                              ),
                                              Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              _localisationController.text,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 49, 49, 49),
                                              ),
                                            ),
                                          ),
                                          _ambassadorCompany != ''
                                              ? Text(
                                                  _ambassadorCompany,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                            ),
                            //date et heure
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: colorwhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 10,
                                      left: 20,
                                    ),
                                    child: const Text(
                                      'Date et heure de livraison',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      left: 20,
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: InkWell(
                                            onTap: () async {
                                              final date =
                                                  await pickDate(dateTime);
                                              if (date == null) return;
                                              final newDateTime = DateTime(
                                                date.year,
                                                date.month,
                                                date.day,
                                                dateTime.hour,
                                                dateTime.minute,
                                              );
                                              setState(() {
                                                dateTime = newDateTime;
                                                _date =
                                                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Colors.black12,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.date_range,
                                                        color: colorBlue,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}',
                                                        style: const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Image.asset(
                                                    'assets/images/link_icon.jpg',
                                                    width: 5,
                                                    height: 5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: Text(''),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: InkWell(
                                            onTap: () async {
                                              final time =
                                                  await pickTime(dateTime);
                                              if (time == null) return;

                                              final newDateTime = DateTime(
                                                dateTime.year,
                                                dateTime.month,
                                                dateTime.day,
                                                time.hour,
                                                time.minute,
                                              );

                                              setState(() {
                                                dateTime = newDateTime;
                                                _heure =
                                                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Colors.black12,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.timer_outlined,
                                                        color: colorBlue,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${dateTime.hour.toString().padLeft(2, '0')}h ${dateTime.minute.toString().padLeft(2, '0')}',
                                                        style: const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Image.asset(
                                                    'assets/images/link_icon.jpg',
                                                    width: 5,
                                                    height: 5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            widget.product.type == 'grossiste'
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: colorwhite,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                      controller: _prixController,
                                      keyboardType: TextInputType.phone,
                                      onChanged: onChange,
                                      decoration:
                                          kCmdInputDecoration('Prix de vente'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Le champs ne peut pas être vide!';
                                        } else if (int.parse(value) <
                                            widget.product.price.min) {
                                          return 'Le montant doit être suppérieur ou égale à ${widget.product.price.min}';
                                          // ignore: unrelated_type_equality_checks
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : Container(),
                            //prix de livraison et total
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: colorwhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Livraison ${unitPriceDelivery == widget.product.delivery.city ? '' : 'hors'} ${widget.product.shop.city.name}'),
                                        Text(
                                          '${NumberFormat("###,###", 'en_US').format(unitPriceDelivery * _nbcmd).replaceAll(',', ' ')}  Fr',
                                          style: const TextStyle(
                                            color: colorBlue,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    height: 2,
                                    color: Colors.black12,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'TOTAL A PAYER',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat("###,###", 'en_US').format(prixTotal).replaceAll(',', ' ')}  Fr',
                                          style: const TextStyle(
                                            color: colorBlue,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: colorwhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                minLines: 2,
                                maxLines: 3,
                                controller: _detailController,
                                decoration: kCmdInputDecoration('Autre détail'),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              color: colorfond,
              child: _loading
                  ? Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: colorYellow2,
                      ),
                      child: const CircularProgressIndicator(
                        color: colorwhite,
                      ),
                    )
                  : kTextButtonCmd('ENVOYER LA COMMANDE', () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      if (_formKey.currentState!.validate()) {
                        if (_date != '' &&
                            _heure != '' &&
                            unitPriceDelivery != 0) {
                          setState(() {
                            _loading = !_loading;
                          });
                          chargementAlert();
                          createCommand();
                        } else if (_date == '') {
                          Fluttertoast.showToast(
                              msg: 'Sélectionnez la date svp!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (_heure == '') {
                          Fluttertoast.showToast(
                              msg: 'Sélectionnez l\'heure svp!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Veuillez choisir la localisation!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    }),
            ),
          )
        : kRessayer(context, () {
            chargementAlert();
            createCommand();
          });
  }

  Future showDialogConfirmation() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            insetPadding: const EdgeInsets.only(
              right: 50,
              left: 50,
            ),
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Container(
              height: 270,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 170,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: colorvalid,
                          size: 60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Commande envoyé',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: colorYellow2,
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorwhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  // dialog
  Future<DateTime?> pickDate(DateTime dateTime) => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(dateTime.year, dateTime.month + 1, dateTime.day),
      );

  Future<TimeOfDay?> pickTime(DateTime dateTime) => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );
}
