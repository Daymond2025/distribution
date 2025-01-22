import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatefulWidget {
  const NotificationDetailScreen({super.key});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/logo_rond.png'),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'REGGIE DYAMOND',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF7FBFE),
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.only(
          top: 10.0,
          right: 10.0,
          left: 10.0,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 9,
                          child: Image.asset('assets/images/Image8.png')),
                      const Expanded(
                        flex: 1,
                        child: Text(''),
                      ),
                      Expanded(
                        flex: 18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Ordinateur portable pliable duale core, 500 GB/ 4 GB',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorblack,
                                    fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Detail',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
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
                  height: 5,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text:
                                        'Votre commande a été validé avec succès',
                                    style: TextStyle(
                                      color: colorblack,
                                      fontSize: 15,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' il y a 9 minutes',
                                        style: TextStyle(color: colorBlue),
                                      ),
                                      TextSpan(
                                        text: ' vous bénéficier de 7000  Fr',
                                        style: TextStyle(color: colorblack),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'il ne vous reste que 2 étoiles pour bénéficier d\'un bonus de 10 000  Fr gratuitement',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
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
              color: colorwhite,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Retour à la liste',
                        // ignore: prefer_const_constructors
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 2,
                    color: colorfond,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      // ignore: avoid_print
                      onPressed: () => print('Voir les détails'),
                      child: const Text(
                        'Voir les détails',
                        style: TextStyle(color: colorvalid, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
