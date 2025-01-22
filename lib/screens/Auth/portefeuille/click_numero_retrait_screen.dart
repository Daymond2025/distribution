import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/phone_number.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/loading_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/contact_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClickNumeroRetraitScreen extends StatefulWidget {
  const ClickNumeroRetraitScreen({
    super.key,
    required this.image,
    required this.phoneNumber,
    required this.amount,
  });
  final int amount;
  final PhoneNumber phoneNumber;
  final String image;
  @override
  State<ClickNumeroRetraitScreen> createState() =>
      _ClickNumeroRetraitScreenState();
}

class _ClickNumeroRetraitScreenState extends State<ClickNumeroRetraitScreen> {
  bool _all = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _montantController = TextEditingController();

  void addTransaction() async {
    AlertComponent().loading();
    ApiResponse response = await storeTransactionRetrait(
      widget.phoneNumber.phoneNumber,
      widget.phoneNumber.operator,
      _all ? widget.amount.toString() : _montantController.text,
    );
    AlertComponent().endLoading();

    if (response.error == null) {
      AlertComponent().textAlert(response.data.toString(), Colors.black54);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 2, 92, 209),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/portefeuille.png',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 25,
                          child: Text(
                            'SOLDES ACTUEL : ${NumberFormat("###,###", 'en_US').format(widget.amount).replaceAll(',', ' ')} CFA',
                            style: const TextStyle(
                              color: colorwhite,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //back
                Positioned(
                  top: 30,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: colorwhite,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height - 170,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(top: 30, right: 30, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: colorBlue),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        widget.image,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.phoneNumber.operator,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      widget.phoneNumber.phoneNumber,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: _montantController,
                              maxLines: 1,
                              enabled: _all ? false : true,
                              style: const TextStyle(fontSize: 20),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champs ne peut pas être vide!';
                                } else if (value.length <= 1) {
                                  return 'Renseignez le montant!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffix: const Text(
                                  'Fr',
                                  style: TextStyle(fontSize: 20),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: _all
                                    ? '${NumberFormat("###,###", 'en_US').format(widget.amount).replaceAll(',', ' ')}F CFA'
                                    : 'Montant à rétirer',
                                hintText: NumberFormat("###,###", 'en_US')
                                    .format(widget.amount)
                                    .replaceAll(',', ' '),
                                labelStyle: const TextStyle(color: colorBlue),
                                focusColor: colorBlue,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: colorBlue,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: colorBlue,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: colorBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Retirer gratuitement et à tout moment',
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 13),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Tout rétirer',
                                      ),
                                      Checkbox(
                                        checkColor: Colors.white,
                                        value: _all,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _all = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_all) {
                            addTransaction();
                          } else {
                            if (_formKey.currentState!.validate()) {
                              if (int.parse(_montantController.text) > 0) {
                                if (widget.amount >=
                                    int.parse(_montantController.text)) {
                                  addTransaction();
                                } else {
                                  AlertComponent().error(context,
                                      'Montant supérieur au montant dans le portefeuille');
                                }
                              } else {
                                AlertComponent().error(context,
                                    'Renseignez correctement les champs!');
                              }
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
                            'Envoyez la demande',
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
            )
          ],
        ),
      ),
    );
  }
}
