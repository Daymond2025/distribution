import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class DiffusionDetailScreen extends StatefulWidget {
  const DiffusionDetailScreen({super.key});

  @override
  State<DiffusionDetailScreen> createState() => _DiffusionDetailScreenState();
}

class _DiffusionDetailScreenState extends State<DiffusionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
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
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Article vendu',
                            style: TextStyle(
                                color: Color(0xFFFF9700),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorwhite,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Image.asset('assets/images/Image4.png'),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: <Widget>[
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
                                    height: 4,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      'Detail',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      '76 000  Fr',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/images/Calque7.png'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          // ignore: prefer_const_constructors
                          text: TextSpan(
                            text: 'Vendu par',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <TextSpan>[
                              const TextSpan(
                                text: ' : TRAORE LAMINE',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          // ignore: prefer_const_constructors
                          text: TextSpan(
                            text: 'Lieu de vente',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <TextSpan>[
                              const TextSpan(
                                text: ' : Abidjan il y a 8 minutes',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            RichText(
                              // ignore: prefer_const_constructors
                              text: TextSpan(
                                text: 'Nombre d\'étoile :',
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFF9700),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFF9700),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFF9700),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFF9700),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFF9700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                      onPressed: () => print('produits similaires'),
                      child: const Text(
                        'Produits similaires',
                        style:
                            TextStyle(color: Color(0xFFFF9700), fontSize: 16),
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
