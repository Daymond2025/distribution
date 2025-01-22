import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/transaction_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RecapitulationCommandeMoiScreen extends StatefulWidget {
  const RecapitulationCommandeMoiScreen(
      {super.key,
      required this.taille,
      required this.couleur,
      required this.heure,
      required this.date,
      required this.contact,
      required this.cityId,
      required this.ambassador,
      required this.lieu,
      required this.detail,
      required this.qte,
      required this.product});
  final String taille;
  final String couleur;
  final String heure;
  final String date;
  final String contact;
  final String cityId;
  final int ambassador;
  final String lieu;
  final String detail;
  final int qte;
  final Product product;
  @override
  State<RecapitulationCommandeMoiScreen> createState() =>
      _RecapitulationCommandeMoiScreenState();
}

class _RecapitulationCommandeMoiScreenState
    extends State<RecapitulationCommandeMoiScreen> {
  late Product _product;
  final List<dynamic> _portefeuille = [];

  String name = '';

  Future<void> getName() async {
    String nom;
    nom = await getVendeurName();

    setState(() {
      name = nom;
    });
  }

  chargementAlert() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
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

  Future<void> createCommand() async {
    ApiResponse response = await storeCommandeMoi(
      _product.id.toString(),
      widget.qte.toString(),
      widget.contact,
      widget.cityId,
      widget.ambassador.toString(),
      widget.date,
      widget.heure,
      widget.detail,
    );
    EasyLoading.dismiss();
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
    } else {}
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

  @override
  void initState() {
    super.initState();
    getName();
    _product = widget.product;
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: colorwhite,
          iconTheme: const IconThemeData(color: Colors.black87),
          title: const Text(
            'Récapitulation de la commande',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: colorwhite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClickProduit(
                                    product: _product,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      child: Image.network(
                                        _product.images[0],
                                        height: 80,
                                        width: 80,
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
                                              _product.name,
                                              overflow: TextOverflow.ellipsis,
                                              //style: Theme.of(context).textTheme.subtitle1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            _product.subTitle ??
                                                _product.description ??
                                                '',
                                            style: const TextStyle(
                                              color: Colors.black38,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                _product.star == 1
                                    ? const Icon(
                                        Icons.star,
                                        color: colorYellow,
                                        size: 15,
                                      )
                                    : Container(),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
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
                                    _product.state.name,
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
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: Column(
                        children: [
                          widget.couleur != ''
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Couleur',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            widget.couleur,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          widget.taille != ''
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Taille',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            widget.taille,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Quantité',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      widget.qte.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Prix',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      '${NumberFormat("###,###", 'en_US').format(_product.price.seller * widget.qte).replaceAll(',', ' ')}  Fr',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    _product.shop.city.id == widget.cityId
                                        ? 'Livraison ${_product.shop.city.name}'
                                        : 'Livraison hors ${_product.shop.city.name}',
                                    style: const TextStyle(
                                        color: Colors.black45, fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      '${NumberFormat("###,###", 'en_US').format((_product.shop.city.id == widget.cityId ? _product.delivery.city : _product.delivery.noCity) * widget.qte).replaceAll(',', ' ')}  Fr',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  flex: 5,
                                  child: Text(
                                    'A payer',
                                    style: TextStyle(
                                      color: colorYellow2,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      '${NumberFormat("###,###", 'en_US').format(((_product.shop.city.id == widget.cityId ? _product.delivery.city : _product.delivery.noCity) + _product.price.seller) * widget.qte).replaceAll(',', ' ')}  Fr',
                                      style: const TextStyle(
                                          fontSize: 18, color: colorYellow2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: const Icon(
                                      Icons.paid_outlined,
                                      color: colorYellow2,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Vous économisez au total ${NumberFormat("###,###", 'en_US').format((_product.type == 'grossiste' ? _product.price.max - _product.price.seller : _product.price.price - _product.price.seller) * widget.qte).replaceAll(',', ' ')}  Fr',
                                    style: const TextStyle(color: colorYellow2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Information de Livraison',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nom',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Livraison',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      widget.lieu,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Contact 1',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '+225 ${widget.contact}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Date de Livraison',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${widget.date}   ${widget.heure}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
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
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Autre Détails',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        widget.detail != '' ? widget.detail : '...',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: colorfond,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () {
            chargementAlert();
            createCommand();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(8.0),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorYellow2,
            ),
            alignment: Alignment.center,
            child: const Text(
              'PAIEMENT',
              style: TextStyle(color: colorwhite, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Future showDialogSoldeSuffisant() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            insetPadding: const EdgeInsets.only(
              right: 50,
              left: 50,
            ),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 270,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Paiement',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 1,
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/portefeuille2.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('SOLDE ACTUEL'),
                                  Text(
                                    '${_portefeuille[0]['somme']}  Fr',
                                    style: const TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Vous allez transferer ',
                                style: TextStyle(
                                  color: colorblack,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${(_product.price.seller + (_product.shop.city.id == widget.cityId ? _product.delivery.city : _product.delivery.noCity)) * widget.qte} ',
                                style: const TextStyle(
                                  color: colorBlue,
                                ),
                              ),
                              const TextSpan(
                                text: ' Fr de votre portefeuille a daymond ',
                                style: TextStyle(
                                  color: colorblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      chargementAlert();
                      createCommand();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: colorYellow2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'JE VALIDE LA TRANSACTION',
                        style: TextStyle(
                          fontSize: 18,
                          color: colorwhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Future showDialogSoldeInsuffisant() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            insetPadding: const EdgeInsets.only(
              right: 50,
              left: 50,
            ),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 270,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Paiement',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 1,
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/portefeuille2.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('SOLDE ACTUEL'),
                                  Text(
                                    '${_portefeuille[0]['somme']}  Fr',
                                    style: const TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Vous solde est insuffisant pour effectuer cette transaction. ',
                                style: TextStyle(
                                  color: colorblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        width: MediaQuery.of(context).size.width,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Un agent vous contactera pour confirmer votre commande. ',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          chargementAlert();
                          createCommand();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: colorYellow2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'ENVOYER LA COMMANDE',
                            style: TextStyle(
                              fontSize: 18,
                              color: colorwhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
