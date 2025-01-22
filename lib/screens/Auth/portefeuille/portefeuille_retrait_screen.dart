import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/phone_number.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/click_numero_retrait_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/contact_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

class PortefeuilleRetraitScreen extends StatefulWidget {
  const PortefeuilleRetraitScreen({super.key, required this.amount});
  final int amount;
  @override
  State<PortefeuilleRetraitScreen> createState() =>
      _PortefeuilleRetraitScreenState();
}

class _PortefeuilleRetraitScreenState extends State<PortefeuilleRetraitScreen> {
  bool _orange = true;
  bool _moov = false;
  bool _mtn = false;
  bool _wave = false;
  String operateur = 'Orange';
  List<PhoneNumber> _phoneNumbers = [];

  bool _loading = true;

  String controller = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _numConfirmController = TextEditingController();

  Future<void> showContact() async {
    ApiResponse response = await getContacts();
    if (response.error == null) {
      setState(() {
        _phoneNumbers = response.data as List<PhoneNumber>;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else {}
  }

  void addContact() async {
    AlertComponent().loading();

    ApiResponse response = await createContact(_numController.text, operateur);

    AlertComponent().endLoading();

    if (response.error == null) {
      setState(() {
        _loading = true;
      });
      showContact();
      AlertComponent().success(context, response.message.toString());
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else if (response.error == 'Error') {
    } else {
      AlertComponent().error(context, response.error.toString());
    }
  }

  void supContact(int id) async {
    AlertComponent().loading();

    ApiResponse response = await deleteContact(id);

    AlertComponent().endLoading();

    if (response.error == null) {
      showContact();
      AlertComponent().success(context, response.message.toString());
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else {
      AlertComponent().error(context, response.error.toString());
    }
  }

  Future addNumber(BuildContext context) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            insetPadding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 35,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Enregistrer un compte',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 25,
                            bottom: 10,
                            left: 20,
                            right: 20,
                          ),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Selectionner l\'operateur',
                            style: TextStyle(fontSize: 16),
                          ),
                        ), //opateru
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 1,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: _orange ? colorBlue : colorwhite,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _orange = true;
                                        _mtn = false;
                                        _moov = false;
                                        _wave = false;
                                        operateur = 'Orange';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                36, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                54, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(2, 1),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(assetlogoOrange),
                                          const SizedBox(height: 5),
                                          const Text('Orange')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 1,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: _wave ? colorBlue : colorwhite,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _orange = false;
                                        _mtn = false;
                                        _moov = false;
                                        _wave = true;
                                        operateur = 'Wave';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                36, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                54, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(2, 1),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(assetlogoWave),
                                          const SizedBox(height: 5),
                                          const Text('Wave')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 1,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: _mtn ? colorBlue : colorwhite,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _orange = false;
                                        _mtn = true;
                                        _moov = false;
                                        _wave = false;
                                        operateur = 'Mtn';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                36, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                54, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(2, 1),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(assetlogoMtn),
                                          const SizedBox(height: 5),
                                          const Text('MTN')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 1,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: _moov ? colorBlue : colorwhite,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _orange = false;
                                        _mtn = false;
                                        _moov = true;
                                        _wave = false;
                                        operateur = 'Moov';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                36, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                54, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(2, 1),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(assetlogoMoov),
                                          const SizedBox(height: 5),
                                          const Text('Moov')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _numController,
                                keyboardType: TextInputType.number,
                                decoration: kInputDecorationMobileMoney(
                                  'Saisir le numéro (+225XXXXXXXXXX)',
                                ),
                                validator: (value) {
                                  final regex = RegExp(r'^\+225\d{10}$');
                                  if (value!.isEmpty) {
                                    return 'Le champ ne peut pas être vide!';
                                  } else if (!regex.hasMatch(value)) {
                                    return 'Le numéro doit être au format +225 suivi de 10 chiffres!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (!value.startsWith('+225')) {
                                    _numController.text =
                                        '+225${value.replaceFirst('+225', '')}';
                                    _numController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                                _numController.text.length));
                                  }
                                },
                              ),
                              TextFormField(
                                controller: _numConfirmController,
                                keyboardType: TextInputType.number,
                                decoration: kInputDecorationMobileMoney(
                                  'Répéter le numéro (+225XXXXXXXXXX)',
                                ),
                                validator: (value) {
                                  final regex = RegExp(r'^\+225\d{10}$');
                                  if (value!.isEmpty) {
                                    return 'Le champ ne peut pas être vide!';
                                  } else if (!regex.hasMatch(value)) {
                                    return 'Le numéro doit être au format +225 suivi de 10 chiffres!';
                                  } else if (_numController.text != value) {
                                    return 'Les numéros ne correspondent pas!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (!value.startsWith('+225')) {
                                    _numConfirmController.text =
                                        '+225${value.replaceFirst('+225', '')}';
                                    _numConfirmController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: _numConfirmController
                                                .text.length));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_numConfirmController.text ==
                                _numController.text) {
                              if (operateur != '') {
                                Navigator.of(context).pop();
                                setState(() {
                                  _loading = false;
                                });
                                addContact();
                                setState(() {
                                  _numConfirmController.text = '';
                                  _numController.text = '';
                                });
                              } else {
                                Navigator.of(context).pop();
                                AlertComponent()
                                    .error(context, 'Choisissez l\'operateur!');
                              }
                            } else {
                              Navigator.of(context).pop();
                              AlertComponent().error(
                                  context, 'Les numéros ne correspondent pas!');
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: colorBlue,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text(
                            'Enregistrer',
                            style: TextStyle(
                              color: colorwhite,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void initState() {
    showContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.9,
          backgroundColor: colorwhite,
          iconTheme: const IconThemeData(color: Colors.black54),
          title: const Text(
            'Selectionner un compte',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: [
            _loading
                ? Container(
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 255, 255, 255),
                      highlightColor: const Color.fromARGB(255, 236, 235, 235),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: colorwhite,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: _phoneNumbers
                        .map(
                          (e) => kOperateurNumero(
                            e,
                            e.operator == 'Orange'
                                ? assetlogoOrange
                                : e.operator == 'Mtn'
                                    ? assetlogoMtn
                                    : e.operator == 'Moov'
                                        ? assetlogoMoov
                                        : assetlogoWave,
                          ),
                        )
                        .toList(),
                  ),

            //enregistrer
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => addNumber(context),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorBlue,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: colorwhite,
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enregistrer un compte',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
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
          ],
        ),
      ),
    );
  }

  InkWell kOperateurNumero(PhoneNumber phoneNumber, String image) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClickNumeroRetraitScreen(
              phoneNumber: phoneNumber,
              amount: widget.amount,
              image: image,
            ),
          ),
        ),
        onLongPress: () => AlertComponent().confirm(context,
            'Voulez vous vraiment supprimé le ${phoneNumber.phoneNumber} de la liste?',
            () {
          setState(() {
            _loading = false;
          });
          supContact(phoneNumber.id);
        }),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorfond,
          ),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  // image: DecorationImage(image: AssetImage('asset'))
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phoneNumber.operator,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        phoneNumber.phoneNumber,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
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
