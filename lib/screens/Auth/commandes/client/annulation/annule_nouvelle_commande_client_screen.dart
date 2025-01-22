import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/commande_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AnnuleNouvelleComandeClientScreen extends StatefulWidget {
  const AnnuleNouvelleComandeClientScreen({super.key, required this.id});
  final int id;
  @override
  State<AnnuleNouvelleComandeClientScreen> createState() =>
      _AnnuleNouvelleComandeClientScreenState();
}

class _AnnuleNouvelleComandeClientScreenState
    extends State<AnnuleNouvelleComandeClientScreen> {
  bool personel = false;
  String motif = '';

  final TextEditingController _motifController = TextEditingController();

  final List<String> motifs = [
    'Mon client n\'est plus interessé par le produit',
    'le formulaire comporte une erreur',
    'Je ne suis plus interessé',
    'Mon client a trouvé quelques chose de mieux',
    'Plus bésoin',
  ];

  Future<void> cancel() async {
    ApiResponse response =
        await cancelCommande(widget.id, _motifController.text);
    EasyLoading.dismiss();
    if (response.error == null) {
      // ignore: use_build_context_synchronously
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
    } else {
      errorAlert(response.error.toString());
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorwhite,
        appBar: AppBar(
          backgroundColor: colorwhite,
          iconTheme: const IconThemeData(
            color: colorblack, //change color on your need
          ),
          title: const Text(
            'Annulation',
            style: TextStyle(
              color: colorblack,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: 25,
            right: 15,
            left: 15,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                  bottom: 20,
                ),
                child: const Text(
                  'Quel sont les motifs de l\'annulation de cette commande?',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Column(
                      children: motifs.map((e) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: colorBlue),
                            borderRadius: BorderRadius.circular(24),
                            color: motif == e
                                ? Colors.black12
                                : Colors.transparent,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                motif = e;
                                _motifController.text = motif;
                                personel = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: colorBlue,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          motif = '';
                          _motifController.text = '';
                          personel = !personel;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Autres Motifs ?',
                          style: TextStyle(
                            color: colorBlue,
                            decoration: TextDecoration.underline,
                            decorationColor: colorannule,
                          ),
                        ),
                      ),
                    ),
                    personel
                        ? TextFormField(
                            controller: _motifController,
                            decoration: const InputDecoration(
                                hintText: 'Saisissez le motif'),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Container(
          color: colorwhite,
          child: InkWell(
            onTap: () {
              _motifController.text == ''
                  ? Fluttertoast.showToast(
                      msg: 'Veuillez donner le motif de la l\'annulation svp!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0)
                  : cancel();
            },
            child: Container(
              padding: EdgeInsets.zero,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: colorYellow2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'VALIDER',
                            style: TextStyle(
                              color: colorwhite,
                              fontSize: 14,
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
        ));
  }
}
