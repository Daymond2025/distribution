import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:distribution_frontend/models/city.dart';
import 'package:distribution_frontend/services/city_service.dart';
import 'package:distribution_frontend/widgets/select_ambassador.dart';

class FormulaireUpdateCommandeScreen extends StatefulWidget {
  const FormulaireUpdateCommandeScreen({
    super.key,
    required this.id,
    required this.commande,
    required this.typeProduit,
    required this.idProduit,
  });
  final int id;
  final int idProduit;
  final Order commande;
  final String typeProduit;

  @override
  State<FormulaireUpdateCommandeScreen> createState() =>
      _FormulaireUpdateCommandeScreenState();
}

class _FormulaireUpdateCommandeScreenState
    extends State<FormulaireUpdateCommandeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _localisationController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  late Order _order;

  String _date = '';
  String _heure = '';

  bool opentaille = false;
  String taille = '';

  bool opencouleur = false;
  String couleur = '';

  DateTime dateTime = DateTime.now();
  int _nbcmd = 0;

  int fraisLivraisonUnitaire = 0;

  int prixTotal = 0;

  bool _loading = false;

  int _ambassadorId = 0;
  String _ambassadorCompany = '';

  void onChange(String value) {
    setState(() {
      prixTotal = value == ''
          ? (0 + fraisLivraisonUnitaire) * _nbcmd
          : (int.parse(value) + fraisLivraisonUnitaire) * _nbcmd;
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

  Future<void> updateCommande() async {
    ApiResponse response = await updateCommandeClient(
        widget.id,
        _nbcmd.toString(),
        _nomController.text,
        _contactController.text,
        _contact2Controller.text,
        fraisLivraisonUnitaire.toString(),
        _localisationController.text,
        _ambassadorId,
        _date,
        _heure,
        _prixController.text,
        _detailController.text,
        taille,
        couleur);

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
    } else if (response.error == 'Error') {
    } else {
      errorAlert(response.error.toString());
    }
  }

  void _showMultipleSelect() async {
    List<String> data = [];
    final results = await showDialog(
        context: context,
        builder: (BuildContext context) => SelectAmbassador(
              items: cities,
              currentCity: 1,
            ));

    if (results != null) {
      setState(() {
        data = results as List<String>;
        _localisationController.text = results[1];
        if (data.length > 2) {
          _ambassadorId = int.parse(results[2]);
          _ambassadorCompany = '${results[3]} ${results[4]}';
        } else {
          _ambassadorId = 0;
          _ambassadorCompany = '';
        }
      });
    } else {}
  }

  //initialize
  List<City> cities = [];
  getCities() async {
    ApiResponse response = await CityService().getCity();
    print(response.error);

    if (response.error == null) {
      setState(() {
        cities = response.data as List<City>;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  @override
  void initState() {
    getCities();
    super.initState();

    setState(() {
      _order = widget.commande;
      _nbcmd = _order.items[0].quantity;

      prixTotal = (_order.items[0].price + _order.items[0].fees) * _nbcmd;

      fraisLivraisonUnitaire = _order.items[0].fees;

      _nomController.text = _order.client.name ?? '';
      _prixController.text = _order.items[0].price.toString();
      _contactController.text = _order.client.phoneNumber;
      _contact2Controller.text = _order.client.phoneNumber2 ?? '';
      _localisationController.text = _order.delivery.city.name;
      _detailController.text = _order.detail ?? '';

      dateTime = DateTime(
        int.parse(_order.delivery.date.substring(0, 4)),
        int.parse(_order.delivery.date.substring(5, 7)),
        int.parse(_order.delivery.date.substring(8, 10)),
        int.parse(_order.delivery.time.substring(0, 2)),
        int.parse(_order.delivery.time.substring(3, 5)),
      );

      _heure =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      _date =
          '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: const TextStyle(color: colorblack, fontSize: 17),
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
                      product: _order.items[0].product,
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    left: 5,
                    right: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: colorwhite,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                                child: Image.network(
                                  _order.items[0].product.images[0].img,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
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
                                        _order.items[0].product.state.name,
                                        style: const TextStyle(
                                          color: colorblack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    _order.items[0].product.name,
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
                                        'qualité du produit',
                                        overflow: TextOverflow.ellipsis,
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
                                                onChange(widget.typeProduit ==
                                                        'grossiste'
                                                    ? _prixController.text
                                                    : _order.items[0].price
                                                        .toString());
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.remove_circle,
                                            size: 30,
                                            color: _nbcmd == 1
                                                ? const Color.fromARGB(
                                                    255, 219, 219, 219)
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
                                              onChange(widget.typeProduit ==
                                                      'grossiste'
                                                  ? _prixController.text
                                                  : _order.items[0].price
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
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.typeProduit == 'grossiste'
                                    ? 'Prix grossiste unitaire : '
                                    : widget.typeProduit == 'commission'
                                        ? 'Prix de vente : '
                                        : 'Prix de vente : ',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: colorblack,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${NumberFormat("###,###", 'en_US').format(_order.items[0].product.price.price).replaceAll(',', ' ')} F CFA',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: colorBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      widget.typeProduit == 'grossiste'
                          ? Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
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
                                          'de ${NumberFormat("###,###", 'en_US').format(_order.items[0].product.price.min).replaceAll(',', ' ')}  Fr à ${NumberFormat("###,###", 'en_US').format(_order.items[0].product.price.max).replaceAll(',', ' ')}  Fr',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: colorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      widget.typeProduit == 'commission'
                          ? Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
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
                                          '${NumberFormat("###,###", 'en_US').format(_order.items[0].product.price.commission).replaceAll(',', ' ')}  Fr',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: colorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      widget.typeProduit == 'louer'
                          ? Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
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
                                          '${NumberFormat("###,###", 'en_US').format(_order.items[0].product.price.commission).replaceAll(',', ' ')}  Fr',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: colorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
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
                          decoration:
                              kCmdInputDecoration('Nom complet du client'),
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
                                    color: Color.fromARGB(255, 104, 104, 104),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        _localisationController.text,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 49, 49, 49),
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
                                        final date = await pickDate(dateTime);
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
                                                      fontStyle:
                                                          FontStyle.italic),
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
                                        final time = await pickTime(dateTime);
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
                                                      fontStyle:
                                                          FontStyle.italic),
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
                      widget.typeProduit == 'grossiste'
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
                                      _order.items[0].product.price.min) {
                                    return 'Le montant doit etre suppérieur à ${_order.items[0].product.price.min}';
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
                              width: MediaQuery.of(context).size.width - 70,
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Livraison ${_order.delivery.city.name}'),
                                  Text(
                                    '${NumberFormat("###,###", 'en_US').format(_order.items[0].fees * _nbcmd).replaceAll(',', ' ')}  Fr',
                                    style: const TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              height: 2,
                              color: Colors.black12,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 70,
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: colorYellow2,
                ),
                child: const CircularProgressIndicator(
                  color: colorwhite,
                ),
              )
            : kTextButtonCmd('MODIFIER LA COMMANDE', () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }

                if (_formKey.currentState!.validate()) {
                  if (_date != '' && _heure != '') {
                    setState(() {
                      _loading = !_loading;
                    });
                    chargementAlert();
                    updateCommande();
                  } else if (_date == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sélectionnez la date svp!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sélectionnez l\'heure svp!'),
                      ),
                    );
                  }
                }
              }),
      ),
    );
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
