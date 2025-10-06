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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:distribution_frontend/widgets/select_ambassador.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String _userPhoneNumber = '';

  bool opentaille = false;
  String taille = '';

  bool opencouleur = false;
  String couleur = '';

  String _date = '';
  String _heure = '';

  final bool _noCnx = false;

  int _ambassadorId = 0;

  int unitPriceDelivery = 0;
  String cityId = '';

  /// Formate le numéro de téléphone avec des espaces (ex: +225 07 59 85 45)
  String _formatPhoneNumber(String phone) {
    if (phone.startsWith('+225')) {
      String withoutCountryCode = phone.substring(4);
      withoutCountryCode = withoutCountryCode.replaceAll(' ', '');

      // Formatage avec espaces tous les 2 caractères
      String formatted = '';
      for (int i = 0; i < withoutCountryCode.length; i += 2) {
        if (i + 2 <= withoutCountryCode.length) {
          formatted += withoutCountryCode.substring(i, i + 2);
          if (i + 2 < withoutCountryCode.length) {
            formatted += ' ';
          }
        } else {
          formatted += withoutCountryCode.substring(i);
        }
      }

      return '+225 $formatted';
    }
    return phone;
  }

  /// Récupère le numéro de téléphone de l'utilisateur
  /// Vérifie d'abord localement, puis appelle l'API si nécessaire
  /// TODO: Endpoint API utilisé : GET /seller/phone_number/main
  Future<void> getUserPhoneNumber() async {
    try {
      // Récupération depuis le cache local
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString('phone_number');

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        setState(() {
          _userPhoneNumber = _formatPhoneNumber(phoneNumber);
        });
        return;
      }

      // Appel API si non disponible localement
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/phone_number/main'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final phone = data['phone_number'];

        if (phone != null && phone is String && phone.isNotEmpty) {
          // Mise en cache pour utilisation future
          await prefs.setString('phone_number', phone);
          setState(() {
            _userPhoneNumber = _formatPhoneNumber(phone);
          });
        } else {
          setState(() {
            _userPhoneNumber = 'Non disponible';
          });
        }
      } else {
        setState(() {
          _userPhoneNumber = 'Non disponible';
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération du numéro: $e');
      setState(() {
        _userPhoneNumber = 'Non disponible';
      });
    }
  }

  /// Navigation vers l'écran de récapitulation de la commande
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

  /// Affiche l'indicateur de chargement
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

  /// Affiche le dialogue de sélection de ville
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
        } else {
          _ambassadorId = 0;
        }
      });
    }
  }

  /// Charge la liste des villes et points focaux
  /// TODO: Endpoint API via CityService
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
    getUserPhoneNumber();
    _initializeDateTime();
    super.initState();
  }

  /// Initialise la date et l'heure avec les valeurs actuelles
  void _initializeDateTime() {
    final now = DateTime.now();
    _date =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    _heure =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(53.0),
              child: AppBar(
                leadingWidth: 40,
                backgroundColor: colorwhite,
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.16),
                iconTheme: const IconThemeData(
                  color: Colors.black87,
                ),
                title: const Text(
                  'Formulaire de commande',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    color: colorblack,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10.5, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: colorwhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section : Numéro de contact de l'utilisateur
                        const Text(
                          'Votre contact',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorblack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _userPhoneNumber.isEmpty
                                    ? 'Chargement...'
                                    : _userPhoneNumber,
                                style: const TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: Color(0xFF707070),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showEditPhoneDialog();
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Color(0xFF707070),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Section : Sélection du lieu de livraison
                        const Text(
                          'Lieux de livraison',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorblack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.shop.city.name,
                                style: const TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: Color(0xFF707070),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showMultipleSelect(),
                              child: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Color(0xFF707070),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Section : Date et heure souhaitées pour la livraison
                        const Text(
                          'Date et heure de livraison',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorblack,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Champ de sélection de date
                            Expanded(
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
                                        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _date.isEmpty
                                              ? 'Aujourd\'hui'
                                              : _date,
                                          style: const TextStyle(
                                            fontFamily: 'Segoe UI',
                                            fontSize: 16,
                                            color: colorblack,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 20,
                                        color: Color(0xFF707070),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Champ de sélection d'heure
                            Expanded(
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
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _heure.isEmpty ? '16:30' : _heure,
                                          style: const TextStyle(
                                            fontFamily: 'Segoe UI',
                                            fontSize: 16,
                                            color: colorblack,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 20,
                                        color: Color(0xFF707070),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Section : Informations complémentaires
                        const Text(
                          'Autre détails',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorblack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _autreController,
                            minLines: 3,
                            maxLines: 5,
                            style: const TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                              color: colorblack,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              hintText:
                                  'Ajoutez des détails supplémentaires...',
                              hintStyle: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                                color: Color(0xFF707070),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              color: colorfond,
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                // Validation du formulaire avant envoi
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
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
                        fontSize: 16.0,
                      );
                    } else if (_heure == '') {
                      Fluttertoast.showToast(
                        msg: 'Sélectionnez l\'heure svp!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Sélectionnez le lieu svp!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: colorYellow2,
                  ),
                  child: const Text(
                    'ENVOYER LA COMMANDE',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: colorwhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
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

  /// Affiche le sélecteur de date
  Future<DateTime?> pickDate(DateTime dateTime) => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(dateTime.year, dateTime.month + 1, dateTime.day),
      );

  /// Affiche le sélecteur d'heure
  Future<TimeOfDay?> pickTime(DateTime dateTime) => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );

  /// Affiche le dialogue de modification du numéro de téléphone
  /// TODO: Sauvegarder le nouveau numéro via API après modification
  /// En attente d'endpoint : PUT /api/user/phone
  void _showEditPhoneDialog() {
    final TextEditingController phoneController =
        TextEditingController(text: _userPhoneNumber);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifier le numéro'),
          content: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Numéro de téléphone',
              hintText: 'Ex: +225 07 59 85 45',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _userPhoneNumber = _formatPhoneNumber(phoneController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }
}
