import 'dart:io';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/city.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/city_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateProfilScreen extends StatefulWidget {
  const UpdateProfilScreen({super.key, required this.seller});
  final Seller seller;

  @override
  State<UpdateProfilScreen> createState() => _UpdateProfilScreenState();
}

class _UpdateProfilScreenState extends State<UpdateProfilScreen> {
  File? _imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController villeController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();

  List<City> cities = [];
  CityService cityService = CityService();
  UserService userService = UserService();

  late int cityId;

  bool loading = true;

  Future<void> initData() async {
    ApiResponse response = await cityService.getCity();
    if (response.error == null) {
      setState(() {
        cities = response.data as List<City>;
      });
      loading = !loading;
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  late Seller seller;

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

  void editSeller() async {
    File? image = _imageFile == null ? null : _imageFile;

    ApiResponse response = await userService.updateUser(
      image,
      nomController.text,
      prenomController.text,
      cityId,
      professionController.text,
      emailController.text,
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

  confirmAlert(String text) {
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
            AlertComponent().loading();
            editSeller();
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

  @override
  void initState() {
    super.initState();
    initData();
    seller = widget.seller;
    cityId = seller.cityId;
    nomController.text = seller.firstName;
    prenomController.text = seller.lastName;
    contactController.text = seller.phoneNumber;
    emailController.text = seller.email == null ? '' : seller.email.toString();
    professionController.text = seller.job;
    villeController.text = seller.city;
  }

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
            'Modifier le profil',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.maxFinite,
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
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(72),
                                image: _imageFile == null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            seller.picture ?? imgUserDefault),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: FileImage(
                                          _imageFile ?? File(''),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: -8,
                              right: -5,
                              child: IconButton(
                                onPressed: () => getImage(1),
                                icon: const Icon(
                                  Icons.add_circle,
                                  size: 34,
                                  color: colorwhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                child: ListTile(
                                  leading: Image.asset(
                                    'assets/images/nom.png',
                                    width: 27,
                                    height: 27,
                                  ),
                                  title: TextFormField(
                                    controller: nomController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: seller.firstName,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorYellow2),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Le champs nom ne peut pas être vide!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                child: ListTile(
                                  leading: Image.asset(
                                    'assets/images/prenom.png',
                                    width: 27,
                                    height: 27,
                                  ),
                                  title: TextFormField(
                                    controller: prenomController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: seller.lastName,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorYellow2),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Le champs prénom ne peut pas être vide!';
                                      }
                                      return null;
                                    },
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
                                  title: DropdownButtonFormField<int>(
                                    value: cityId,
                                    items: cities.map((city) {
                                      return DropdownMenuItem<int>(
                                        value: city.id,
                                        child: Text(city.name),
                                      );
                                    }).toList(),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        cityId = newValue!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorYellow2),
                                      ),
                                      hintText: 'Sélectionnez votre ville',
                                    ),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Veuillez sélectionner une ville!';
                                      }
                                      return null;
                                    },
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
                                  title: TextFormField(
                                    controller: professionController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: seller.job,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorYellow2),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Le champs profession ne peut pas être vide!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: EdgeInsets.zero,
                              //   child: ListTile(
                              //     leading: const Icon(Icons.call),
                              //     title: TextFormField(
                              //       controller: contactController,
                              //       style: const TextStyle(fontSize: 20),
                              //       decoration: const InputDecoration(
                              //         focusedBorder: UnderlineInputBorder(
                              //           borderSide: BorderSide(color: colorYellow2),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                padding: EdgeInsets.zero,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.mail,
                                    color: emailController.text != ''
                                        ? Colors.black45
                                        : colorannule,
                                  ),
                                  title: TextFormField(
                                    controller: emailController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: 'Entrez votre adresse email',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: emailController.text != ''
                                                ? colorYellow
                                                : colorannule),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Le champs email ne peut pas être vide!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      'Annuler',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      confirmAlert('Veuillez confirmer svp!');
                                    } else {
                                      debugPrint('Error ...');
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: colorYellow,
                                    padding: EdgeInsets.zero,
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text(
                                      'Confirmer',
                                      style: TextStyle(
                                          fontSize: 18, color: colorwhite),
                                    ),
                                  ),
                                )
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
    );
  }
}
