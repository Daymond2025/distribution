import 'package:country_flags/country_flags.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/city.dart';
import 'package:distribution_frontend/models/country.dart';
import 'package:distribution_frontend/screens/confirm_connexion_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/lesvilles/lesvilles_widget.dart';
import 'package:distribution_frontend/screens/newscreens/pays/pays_popup_widget.dart';
import 'package:distribution_frontend/services/city_service.dart';
import 'package:distribution_frontend/services/country_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  List<dynamic> cities = [];
  CityService cityService = CityService();

  String _selectedCity = '';
  late int? _selectedCityId;
  bool _isTermsAccepted = false;

  String _selectedCountry = 'Côte d\'Ivoire';
  String _countryPrefix = '+225';
  String _countryFlag = 'CI';

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    ApiResponse response = await cityService.getCity();
    if (response.error == null) {
      setState(() {
        cities = response.data as List<City>;
      });
      print(cities.map((city) => city.toJson()).toList());
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

  void _showCountryDialog() {
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

  void _showCityPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Choisir une ville'),
          children: cities.map((city) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _selectedCity = city.name;
                  _selectedCityId = city.id;
                });
                Navigator.pop(context);
              },
              child: Text(city.name),
            );
          }).toList(),
        );
      },
    );
  }

  void _register() {
    if (_lastNameController.text.isEmpty) {
      _showError("Veuillez entrer votre nom");
    } else if (_firstNameController.text.isEmpty) {
      _showError("Veuillez entrer votre prénom");
    } else if (_phoneController.text.length < 10) {
      _showError("Numéro de téléphone invalide");
    } else if (_selectedCity.isEmpty) {
      _showError("Veuillez sélectionner une ville");
    } else if (_professionController.text.isEmpty) {
      _showError("Veuillez entrer votre profession");
    } else if (!_isTermsAccepted) {
      _showError("Veuillez accepter les conditions générales");
    } else {
      sendSms();
    }
  }

  void changePays(Country value) {
    print("pays ${value.cities}");
    setState(() {
      _selectedCountry = value.name;
      _countryPrefix = value.indicatif;
      _countryFlag = value.code;
      _selectedCity = '';
      _selectedCityId = null;
      cities = value.cities;
    });
  }

  void changeVille(dynamic value) {
    print("ville ${value}");
    setState(() {
      _selectedCity = value.name;
      _selectedCityId = value.id;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  UserService userService = UserService();

  Future<void> sendSms() async {
    AlertComponent().loading();
    ApiResponse response =
        await userService.register('$_countryPrefix${_phoneController.text}');

    if (response.error == null) {
      AlertComponent().endLoading();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmConnexionScreen(
            action: 'register',
            phoneNumber: '$_countryPrefix${_phoneController.text}',
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            job: _professionController.text,
            city: _selectedCityId,
          ),
        ),
      );
    } else {
      AlertComponent().endLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust layout when keyboard appears
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Inscription',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/logo_.png', height: 60),
                  const SizedBox(height: 20),
                  const Text(
                    'Remplissez le formulaire qui ne prendra que 2 minutes et commencez à gagner de l’argent sans risquer votre argent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Input Fields Container
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.person, color: Colors.orange),
                            labelText: 'Nom',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.person, color: Colors.orange),
                            labelText: 'Prénom',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
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
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.8,
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

                          //  _showCountryDialog
                          ,
                          child: Row(
                            children: [
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
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: 'Numéro mobile',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: cities.length != 0,
                            child: const SizedBox(height: 20)),
                        Visibility(
                          visible: cities.length != 0,
                          child: GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.8,
                                        child: LesvillesWidget(
                                          onDataChanged: changeVille,
                                          villes: cities,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            }

                            // _showCityPicker

                            ,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.location_city,
                                    color: Colors.orange),
                                border: UnderlineInputBorder(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedCity,
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                  ),
                                  const Icon(Icons.arrow_drop_down,
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _professionController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.work, color: Colors.orange),
                            labelText: 'Profession',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _isTermsAccepted = value!;
                          });
                        },
                      ),
                      const Text(
                        "J'ai lu et j'accepte ces ",
                        style: TextStyle(color: Colors.black87),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            const url =
                                'https://docs.google.com/document/d/e/2PACX-1vSinBjHMQYhu1n9WrAekNY7nnrsU_mN5fPjEva1pf33e4lGiAMIWfnmKtQhv35z87Bx96o2is1_cgQ4/pub';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: const Text(
                            "conditions générales",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: Colors.pinkAccent),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "J’ai déjà un compte !",
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.pinkAccent],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'S’inscription',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:distribution_frontend/api_response.dart';
// import 'package:distribution_frontend/common/alert_component.dart';
// import 'package:distribution_frontend/constante.dart';
// import 'package:distribution_frontend/models/city.dart';
// import 'package:distribution_frontend/screens/confirm_connexion_screen.dart';
// import 'package:distribution_frontend/screens/login_screen.dart';
// import 'package:distribution_frontend/services/city_service.dart';
// import 'package:distribution_frontend/services/user_service.dart';
// import 'package:flutter/material.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//   static const routeName = '/register';

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _professionController = TextEditingController();

//   List<City> cities = [];
//   CityService cityService = CityService();

//   String _selectedCity = '';
//   late int _selectedCityId;
//   bool _isTermsAccepted = false;

//   String _selectedCountry = 'Côte d\'Ivoire';
//   String _countryPrefix = '+225';
//   String _countryFlag = '🇨🇮';

//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   Future<void> initData() async {
//     ApiResponse response = await cityService.getCity();
//     if (response.error == null) {
//       setState(() {
//         cities = response.data as List<City>;
//       });
//     } else if (response.error == unauthorized) {
//       logout().then((value) => {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 (route) => false)
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${response.error}'),
//         ),
//       );
//     }
//   }

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

//   void _showCityPicker() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Choisir une ville'),
//           children: cities.map((city) {
//             return SimpleDialogOption(
//               onPressed: () {
//                 setState(() {
//                   _selectedCity = city.name;
//                   _selectedCityId = city.id;
//                 });
//                 Navigator.pop(context);
//               },
//               child: Text(city.name),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }

//   void _register() {
//     if (_lastNameController.text.isEmpty) {
//       _showError("Veuillez entrer votre nom");
//     } else if (_firstNameController.text.isEmpty) {
//       _showError("Veuillez entrer votre prénom");
//     } else if (_phoneController.text.length < 10 ) {
//       _showError("Numéro de téléphone invalide");
//     } else if (_selectedCity.isEmpty) {
//       _showError("Veuillez sélectionner une ville");
//     } else if (_professionController.text.isEmpty) {
//       _showError("Veuillez entrer votre profession");
//     } else if (!_isTermsAccepted) {
//       _showError("Veuillez accepter les conditions générales");
//     } else {
//       sendSms();
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }


//   UserService userService = UserService();

//   Future<void> sendSms() async {
//     AlertComponent().loading();
//     ApiResponse response = await userService.register('$_countryPrefix${_phoneController.text}');

//     if (response.error == null) {
//       AlertComponent().endLoading();

//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => ConfirmConnexionScreen(
//             action: 'register',
//             phoneNumber: '$_countryPrefix${_phoneController.text}',
//             firstName: _firstNameController.text,
//             lastName: _lastNameController.text,
//             job: _professionController.text,
//             city: _selectedCityId,
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true, // Adjust layout when keyboard appears
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Inscription',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Image.asset('assets/images/logo_.png', height: 60),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Remplissez le formulaire qui ne prendra que 2 minutes et commencez à gagner de l’argent sans risquer votre argent',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey, fontSize: 14,),
//                   ),
//                   const SizedBox(height: 30),
//                   // Input Fields Container
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       children: [
//                         TextField(
//                           controller: _lastNameController,
//                           decoration: const InputDecoration(
//                             prefixIcon: Icon(Icons.person, color: Colors.orange),
//                             labelText: 'Nom',
//                             labelStyle: TextStyle(color: Colors.grey),
//                             border: UnderlineInputBorder(),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextField(
//                           controller: _firstNameController,
//                           decoration: const InputDecoration(
//                             prefixIcon: Icon(Icons.person, color: Colors.orange),
//                             labelText: 'Prénom',
//                             labelStyle: TextStyle(color: Colors.grey),
//                             border: UnderlineInputBorder(),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         GestureDetector(
//                           onTap: _showCountryDialog,
//                           child: Row(
//                             children: [
//                               Text(_countryFlag),
//                               const SizedBox(width: 8),
//                               Text(
//                                 _countryPrefix,
//                                 style: const TextStyle(color: Colors.orange, fontSize: 16),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: TextField(
//                                   controller: _phoneController,
//                                   keyboardType: TextInputType.phone,
//                                   decoration: const InputDecoration(
//                                     hintText: 'Numéro mobile',
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     border: UnderlineInputBorder(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         GestureDetector(
//                           onTap: _showCityPicker,
//                           child: InputDecorator(
//                             decoration: const InputDecoration(
//                               prefixIcon: Icon(Icons.location_city, color: Colors.orange),
//                               border: UnderlineInputBorder(),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   _selectedCity,
//                                   style: const TextStyle(color: Colors.black87, fontSize: 16),
//                                 ),
//                                 const Icon(Icons.arrow_drop_down, color: Colors.grey),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextField(
//                           controller: _professionController,
//                           decoration: const InputDecoration(
//                             prefixIcon: Icon(Icons.work, color: Colors.orange),
//                             labelText: 'Profession',
//                             labelStyle: TextStyle(color: Colors.grey),
//                             border: UnderlineInputBorder(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _isTermsAccepted,
//                         onChanged: (value) {
//                           setState(() {
//                             _isTermsAccepted = value!;
//                           });
//                         },
//                       ),
//                       const Text(
//                         "J'ai lu et j'accepte ces ",
//                         style: TextStyle(color: Colors.black87),
//                       ),
//                       Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           // Navigate to terms and conditions
//                         },
//                         child: const Text(
//                           "conditions générales",
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           style: TextStyle(color: Colors.pinkAccent),
//                         ),
//                       ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(builder: (context) => const LoginScreen()),
//                             (route) => false,
//                       );
//                     },
//                     child: const Text(
//                       "J’ai déjà un compte !",
//                       style: TextStyle(color: Colors.pinkAccent),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                 width: double.infinity,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   gradient: const LinearGradient(
//                     colors: [Colors.orange, Colors.pinkAccent],
//                   ),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: _register,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text(
//                     'S’inscription',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// }
