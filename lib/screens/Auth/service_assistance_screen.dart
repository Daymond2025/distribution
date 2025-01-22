import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceAssistanceScreen extends StatefulWidget {
  const ServiceAssistanceScreen({super.key});

  @override
  State<ServiceAssistanceScreen> createState() =>
      _ServiceAssistanceScreenState();
}

class _ServiceAssistanceScreenState extends State<ServiceAssistanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: AppBar(
        backgroundColor: colorwhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: colorblack,
        ),
        title: const Text(
          'Service d\'assistance',
          style: TextStyle(color: colorblack),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/assistant.png',
                  fit: BoxFit.cover,
                  scale: 2.0,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
                  child: const Text(
                    'Bienvenue au service d’assistant daymond Distribution sélectionnez le moyen le plus facile pour vous de nous contactez cas nous vous attendons pour répondre a vos préoccupation .',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 197, 197, 197),
                        width: 3,
                      ),
                    ),
                  ),
                ),
                //message
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 15,
                        bottom: 5,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MessageScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/message_1.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Message daymond',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //whatsapp
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 15,
                        bottom: 5,
                      ),
                      child: InkWell(
                        onTap: () async {
                          String phone = whatsapp;
                          String url =
                              "whatsapp://send?phone=$phone&text=bonjour...";
                          // ignore: deprecated_member_use
                          await canLaunch(url)
                              // ignore: deprecated_member_use
                              ? launch(url)
                              // ignore: avoid_print
                              : print('Whatsapp non ouvert');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/whatsapp.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'WhatsApp Direct',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //appel
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 15,
                        bottom: 5,
                      ),
                      child: InkWell(
                        onTap: () async {
                          // ignore: deprecated_member_use
                          // await launch(
                          //     'sms:+225 0173 861 515?body=Bonjour besoin de votre service...');
                          final Uri launchUri =
                              Uri(scheme: 'tel', path: callnumber);
                          // ignore: deprecated_member_use
                          if (await canLaunch(launchUri.toString())) {
                            // ignore: deprecated_member_use
                            await launch(launchUri.toString());
                          } else {
                            print('No supported.');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/telephonne.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Appel téléphonique',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //email
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 15,
                        bottom: 5,
                      ),
                      child: InkWell(
                        onTap: () async {
                          String email = mailinnovat;
                          String subject = 'Bonjour Monsieur';
                          String body = ' ';

                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: email,
                            query: encodeQueryParameters(<String, String>{
                              'subject': subject,
                              'body': body
                            }),
                          );
                          // ignore: deprecated_member_use
                          if (await launch(emailUri.toString())) {
                            // ignore: deprecated_member_use
                            await launch(emailUri.toString());
                          } else {
                            print('No supported.');
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.mail_outline,
                              size: 30,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Envoie un mail',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {
                          String url = facebooklink;
                          // ignore: deprecated_member_use
                          await canLaunch(url)
                              // ignore: deprecated_member_use
                              ? launch(url)
                              // ignore: avoid_print
                              : print('Facebook non ouvert');
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.squareFacebook,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          String url = instagramlink;
                          // ignore: deprecated_member_use
                          await canLaunch(url)
                              // ignore: deprecated_member_use
                              ? launch(url)
                              // ignore: avoid_print
                              : print('Instagram non ouvert');
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.instagram,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Consulter le ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Centre d\'aide',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(
                          text: ' pour tous savoir sur Daymond Distribution.',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
