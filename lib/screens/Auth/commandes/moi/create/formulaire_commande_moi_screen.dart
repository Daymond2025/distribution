import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/create/recapitulation_commande_moi_screen.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/models/city.dart';
import 'package:distribution_frontend/services/city_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:distribution_frontend/widgets/select_ambassador.dart';

class FormulaireCommandeMoiScreen extends StatefulWidget {
  const FormulaireCommandeMoiScreen(
      {super.key, required this.qte, required this.product});

  final int qte;
  final Product product;

  @override
  State<FormulaireCommandeMoiScreen> createState() =>
      _FormulaireCommandeMoiScreenState();
}

class _FormulaireCommandeMoiScreenState
    extends State<FormulaireCommandeMoiScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lieuController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _autreController = TextEditingController();
  DateTime dateTime = DateTime.now();

  bool opentaille = false;
  String taille = '';

  bool opencouleur = false;
  String couleur = '';

  String _date = '';
  String _heure = '';

  final bool _noCnx = false;

  int _ambassadorId = 0;
  String _ambassadorCompany = '';

  int unitPriceDelivery = 0;
  String cityId = '';

  //show transaction
  Future<void> recapitulationCommande() async {
    if (cityId == '') {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecapitulationCommandeMoiScreen(
          taille: taille,
          couleur: couleur,
          heure: _heure,
          date: _date,
          contact: _contactController.text,
          lieu: _lieuController.text,
          cityId: cityId,
          ambassador: _ambassadorId,
          detail: _autreController.text,
          qte: widget.qte,
          product: widget.product,
        ),
      ),
    );
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

  void _showMultipleSelect() async {
    List<String> data = [];
    final results = await showDialog(
        context: context,
        builder: (BuildContext context) => SelectAmbassador(
            items: cities, currentCity: widget.product.shop.city.id));

    if (results != null) {
      setState(() {
        data = results as List<String>;
        _lieuController.text = results[1];
        cityId = results[0];
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
    getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                leadingWidth: 40,
                backgroundColor: colorwhite,
                elevation: 0.0,
                iconTheme: const IconThemeData(
                  color: Colors.black87,
                ),
                title: const Text(
                  'Formulaire de commande',
                  style: TextStyle(color: colorblack),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 120,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorwhite,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        padding: const EdgeInsets.all(8),
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
                                        border: Border.all(
                                            width: 1, color: Colors.black26),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Taille du produit'),
                                          const Icon(Icons.arrow_drop_down)
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
                                                crossAxisSpacing: 12.0,
                                                mainAxisSpacing: 12.0,
                                                mainAxisExtent: 20,
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
                                                    padding: EdgeInsets.zero,
                                                    alignment: Alignment.center,
                                                    color: taille ==
                                                            widget.product.sizes
                                                                .elementAt(
                                                                    index)
                                                        ? Colors.amber
                                                        : Colors.transparent,
                                                    child: Text(
                                                      widget.product.sizes
                                                          .elementAt(index),
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
                                : Container(),
                            /*const SizedBox(
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
                            border: Border.all(
                                width: 1, color: Colors.black26),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Selectionnez la couleur du produit'),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      )
                          : Container(),
                      opencouleur
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
                                        .elementAt(index).name;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  color: couleur ==
                                      widget.product.colors.elementAt(
                                          index).name
                                      ? Colors.amber
                                      : Colors.transparent,
                                  child: Text(
                                    widget.product.colors
                                        .elementAt(index).name,
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
                              height: 30,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black12))),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    height: 20,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 0),
                                    child: const Text(
                                      'Votre contact',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _contactController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      height: 1,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          bottom: 5, top: 15, left: 10),
                                      suffix: Icon(
                                        Icons.edit,
                                        size: 15,
                                      ),
                                    ),
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                              ),
                              child: GestureDetector(
                                onTap: () => _showMultipleSelect(),
                                child: _lieuController.text == ''
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 0,
                                        ),
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          color: colorwhite,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Selectionnez votre localisation',
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
                                      )
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colorwhite,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Votre localisation',
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
                                                _lieuController.text,
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
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 0),
                                    child: const Text(
                                      'Date et heure de livraison',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      right: 10,
                                      left: 10,
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
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black12))),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 0),
                                    child: const Text(
                                      'Autre détails',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    minLines: 2,
                                    maxLines: 3,
                                    controller: _autreController,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black45),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 0, top: 0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: colorfond,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_formKey.currentState!.validate()) {
                              if (_date != '' &&
                                  _heure != '' &&
                                  _lieuController.text != '') {
                                chargementAlert();
                                recapitulationCommande();
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
                                    msg: 'Sélectionnez le lieu svp!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: colorYellow2,
                            ),
                            child: const Text(
                              'RECAPITULATION',
                              style: TextStyle(
                                  color: colorwhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : kRessayer(context, () {
            chargementAlert();
            recapitulationCommande();
          });
  }

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
