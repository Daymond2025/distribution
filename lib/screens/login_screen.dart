import 'package:country_flags/country_flags.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/models/country.dart';
import 'package:distribution_frontend/screens/confirm_connexion_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/pays/pays_popup_widget.dart';
import 'package:distribution_frontend/screens/register_screen.dart';
import 'package:distribution_frontend/services/country_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedCountry = 'Côte d\'Ivoire';
  String _countryPrefix = '+225';
  String _countryFlag = 'CI';

  final TextEditingController _phoneController = TextEditingController();

  String signature = '';

  void changePays(Country value) {
    setState(() {
      _selectedCountry = value.name;
      _countryPrefix = value.indicatif;
      _countryFlag = value.code;
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void _showCountryDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CountryDialog(
          onCountrySelected: (country, prefix, flag) {
            setState(() {
              _selectedCountry = country;
              _countryPrefix = prefix;
              _countryFlag = flag;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  UserService userService = UserService();

  //   CountryService countryService = CountryService();
  // ApiResponse response = await CountryService.all();
  // showModalBottomSheet(
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       enableDrag: false,
  //       context: context,
  //       builder: (context) {
  //         return GestureDetector(
  //           onTap: () {
  //             FocusScope.of(context).unfocus();
  //             FocusManager.instance.primaryFocus?.unfocus();
  //           },
  //           child: Padding(
  //             padding: MediaQuery.viewInsetsOf(context),
  //             child: Container(
  //               height: MediaQuery.sizeOf(context).height * 0.8,
  //               child: PaysPopupWidget(
  //                 pays: getJsonField(
  //                   (_model.apiResult2vu?.jsonBody ?? ''),
  //                   r'''$.data''',
  //                   true,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ).then((value) => safeSetState(() {}));
  //   }

  Future<void> sendSms() async {
    // Numéro et mot de passe pour Apple
    signature = await SmsAutoFill().getAppSignature;
    print("la signature : $signature");
    // Processus normal pour les autres utilisateurs
    AlertComponent().loading();
    ApiResponse response = await userService.login(
        '$_countryPrefix${_phoneController.text}', signature);

    if (response.error == null) {
      dynamic data = response.data;
      AlertComponent().endLoading();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmConnexionScreen(
            action: 'login',
            phoneNumber: data['data']['seller']['user']['phone_number'],
            firstName: data['data']['seller']['first_name'],
            lastName: data['data']['seller']['last_name'],
            job: data['data']['seller']['job'],
          ),
        ),
      );
    } else {
      dynamic data = response.data;

      print("erreur : ${response.data}");
      AlertComponent().endLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la connexion , veuillez réessayer'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allows layout adjustment when keyboard appears
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Upper section with the welcome text, logo, etc.
              Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Image.asset('assets/images/logo_.png', height: 60),
                  const SizedBox(height: 50),
                  const Text(
                    'Connectez-vous vite car chez daymond le\nTemps c’est vraiment de l’argent',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GestureDetector(
                      onTap: () async {
                        CountryService countryService = CountryService();
                        ApiResponse response = await countryService.all();
                        print(response.error);
                        // _model.apiResult2vu = await PaysCall.call();
                        if ((response.error == null)) {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.8,
                                    child: PaysPopupWidget(
                                      onDataChanged: changePays,
                                      pays: response.data as List<Country>,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      }
                      // safeSetState(() {});
                      //  _showCountryDialog
                      ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(_countryFlag),
                          CountryFlag.fromCountryCode(
                            _countryFlag,
                            width: 15,
                            height: 10,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _countryPrefix,
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                hintText: 'Numéro mobile',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Bottom section with buttons
              Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.pinkAccent],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_phoneController.text.length >= 10) {
                          sendSms();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "Je n'ai pas de compte",
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryDialog extends StatelessWidget {
  final Function(String country, String prefix, String flag) onCountrySelected;

  const CountryDialog({super.key, required this.onCountrySelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisir ton pays'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildCountryOption(context, 'Côte d\'Ivoire', '+225', '🇨🇮'),
            /* _buildCountryOption(context, 'Sénégal', '+221', '🇸🇳'),
            _buildCountryOption(context, 'Mali', '+223', '🇲🇱'),
            _buildCountryOption(context, 'Cameroun', '+237', '🇨🇲'),
            _buildCountryOption(context, 'Burkina Faso', '+226', '🇧🇫'),
            _buildCountryOption(context, 'Togo', '+228', '🇹🇬'),*/
          ],
        ),
      ),
      actions: [
        TextButton(
          child:
              const Text('Retour', style: TextStyle(color: Colors.pinkAccent)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildCountryOption(
      BuildContext context, String country, String prefix, String flag) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(country),
      subtitle: Text('Code: $prefix'),
      onTap: () => onCountrySelected(country, prefix, flag),
    );
  }
}






// import 'package:distribution_frontend/api_response.dart';
// import 'package:distribution_frontend/common/alert_component.dart';
// import 'package:distribution_frontend/screens/confirm_connexion_screen.dart';
// import 'package:distribution_frontend/screens/register_screen.dart';
// import 'package:distribution_frontend/services/user_service.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//   static const routeName = '/login';

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String _selectedCountry = 'Côte d\'Ivoire';
//   String _countryPrefix = '+225';
//   String _countryFlag = '🇨🇮';

//   final TextEditingController _phoneController = TextEditingController();

//   void _showCountryDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CountryDialog(
//           onCountrySelected: (country, prefix, flag) {
//             setState(() {
//               _selectedCountry = country;
//               _countryPrefix = prefix;
//               _countryFlag = flag;
//             });
//             Navigator.of(context).pop();
//           },
//         );
//       },
//     );
//   }

//   UserService userService = UserService();

//   Future<void> sendSms() async {
//     AlertComponent().loading();
//     ApiResponse response = await userService.login('$_countryPrefix${_phoneController.text}');

//     if (response.error == null) {
//       dynamic data = response.data;
//       AlertComponent().endLoading();

//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => ConfirmConnexionScreen(
//             action: 'login',
//             phoneNumber: data['data']['seller']['user']['phone_number'],
//             firstName: data['data']['seller']['first_name'],
//             lastName: data['data']['seller']['last_name'],
//             job: data['data']['seller']['job'],
//           ),
//         ),
//       );
//     } else {
//       AlertComponent().endLoading();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${response.error}'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true, // Allows layout adjustment when keyboard appears
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Upper section with the welcome text, logo, etc.
//               Column(
//                 children: [
//                   SizedBox(height: 40),
//                   Text(
//                     'Connexion',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Image.asset('assets/images/logo_.png', height: 60),
//                   SizedBox(height: 50),
//                   Text(
//                     'Connectez-vous vite car chez daymond le\nTemps c’est vraiment de l’argent',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey, fontSize: 16),
//                   ),
//                   SizedBox(height: 50),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: GestureDetector(
//                       onTap: _showCountryDialog,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(_countryFlag),
//                           SizedBox(width: 8),
//                           Text(
//                             _countryPrefix,
//                             style: TextStyle(color: Colors.orange, fontSize: 16),
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: TextField(
//                               controller: _phoneController,
//                               decoration: const InputDecoration(
//                                 hintText: 'Numéro mobile',
//                                 hintStyle: TextStyle(color: Colors.grey),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.orange),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.orange),
//                                 ),
//                               ),
//                               keyboardType: TextInputType.phone,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               // Bottom section with buttons
//               Column(
//                 children: [
//                   SizedBox(height: 40),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 40),
//                     width: double.infinity,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25),
//                       gradient: LinearGradient(
//                         colors: [Colors.orange, Colors.pinkAccent],
//                       ),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_phoneController.text.length >= 10) {
//                           sendSms();
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: Text(
//                         'Se connecter',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => const RegisterScreen()),
//                       );
//                     },
//                     child: Text(
//                       "Je n'ai pas de compte",
//                       style: TextStyle(color: Colors.pinkAccent),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CountryDialog extends StatelessWidget {
//   final Function(String country, String prefix, String flag) onCountrySelected;

//   CountryDialog({required this.onCountrySelected});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Choisir ton pays'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildCountryOption(context, 'Côte d\'Ivoire', '+225', '🇨🇮'),
//            /* _buildCountryOption(context, 'Sénégal', '+221', '🇸🇳'),
//             _buildCountryOption(context, 'Mali', '+223', '🇲🇱'),
//             _buildCountryOption(context, 'Cameroun', '+237', '🇨🇲'),
//             _buildCountryOption(context, 'Burkina Faso', '+226', '🇧🇫'),
//             _buildCountryOption(context, 'Togo', '+228', '🇹🇬'),*/
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: Text('Retour', style: TextStyle(color: Colors.pinkAccent)),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildCountryOption(
//       BuildContext context, String country, String prefix, String flag) {
//     return ListTile(
//       leading: Text(flag, style: TextStyle(fontSize: 24)),
//       title: Text(country),
//       subtitle: Text('Code: $prefix'),
//       onTap: () => onCountrySelected(country, prefix, flag),
//     );
//   }
// }
