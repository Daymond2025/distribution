import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/models/user.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ConfirmConnexionScreen extends StatefulWidget {
  const ConfirmConnexionScreen(
      {super.key,
      required this.action,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.job,
      this.city});
  final String action;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String job;
  final int? city;

  @override
  State<ConfirmConnexionScreen> createState() => _ConfirmConnexionScreenState();
}

class _ConfirmConnexionScreenState extends State<ConfirmConnexionScreen> {
  // final List<TextEditingController> _otpControllers =
  //     List.generate(5, (index) => TextEditingController());
  // final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());
  bool isButtonEnabled = false;

  final TextEditingController _otpControllers = TextEditingController();

  String _code = "";

  @override
  void dispose() {
    // for (var controller in _otpControllers) {
    //   controller.dispose();
    // }
    // for (var focusNode in _focusNodes) {
    //   focusNode.dispose();
    // }
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void initState() {
    super.initState();
    listenOtp();
  }

  listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  void _handleOtpInput(int index, String value) {
    // if (value.isNotEmpty) {
    //   if (index < 4) {
    //     _focusNodes[index + 1].requestFocus();
    //   } else {
    //     _focusNodes[index].unfocus();
    //   }
    // } else if (value.isEmpty && index > 0) {
    //   _focusNodes[index - 1].requestFocus();
    // }
    // _checkIfButtonShouldBeEnabled();
  }

  void _checkIfButtonShouldBeEnabled() {
    // bool allFilled =
    //     _otpControllers.every((controller) => controller.text.isNotEmpty);
    // setState(() {
    //   isButtonEnabled = allFilled;
    // });
  }

  void _confirmOtp() {
    String otpCode = _otpControllers.text;
    // .
    // .map((controller) => controller.text).join();
    submit(otpCode);
  }

  UserService userService = UserService();

  Future<void> submit(String otp) async {
    AlertComponent().loading();

    ApiResponse response = widget.action == 'login'
        ? await userService.confirmLogin(widget.phoneNumber, otp)
        : await userService.confirmRegister(widget.firstName, widget.lastName,
            widget.job, widget.phoneNumber, otp, widget.city!);

    if (response.error == null) {
      AlertComponent().endLoading();
      print(response.data);
      _saveAndRedirectHome(response.data);
    } else {
      AlertComponent().endLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la confirmation , veuillez réessayer'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _saveAndRedirectHome(dynamic data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = data['data']['token'];
    var entity = data['data']['user']['entity'];

    await pref.setString('token', token ?? '');
    await pref.setString(
        'name', '${entity['first_name']} ${entity['last_name']}');
    await pref.setInt('vendeurId', entity['id'] ?? 0);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Confirmation du compte',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/logo_.png', height: 60),
                  const SizedBox(height: 20),
                  Text(
                    'Bienvenue M. ${widget.firstName} ${widget.lastName}',
                    style:
                        const TextStyle(color: Colors.pinkAccent, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Saisissez le code de vérification que vous avez reçu\nPar SMS au ${widget.phoneNumber}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PinFieldAutoFill(
                      codeLength: 5,
                      autoFocus: true,
                      controller: _otpControllers,
                      decoration: UnderlineDecoration(
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                      ),
                      currentCode: _code,
                      onCodeSubmitted: (code) {},
                      onCodeChanged: (code) {
                        if (code!.length == 5) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          setState(() {
                            _code = code;
                            isButtonEnabled = true;
                          });
                        }
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: List.generate(5, (index) {
                    //     return SizedBox(
                    //       width: 40,
                    //       child: TextField(
                    //         controller: _otpControllers[index],
                    //         focusNode: _focusNodes[index],
                    //         textAlign: TextAlign.center,
                    //         keyboardType: TextInputType.number,
                    //         maxLength: 1,
                    //         decoration: const InputDecoration(
                    //           counterText: '',
                    //           border: UnderlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.grey),
                    //           ),
                    //         ),
                    //         onChanged: (value) {
                    //           _handleOtpInput(index, value);
                    //         },
                    //       ),
                    //     );
                    //   }),
                    // ),
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const Text('Renvoyer le code'),
                    ],
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
                  onPressed: isButtonEnabled ? _confirmOtp : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Vérification',
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
