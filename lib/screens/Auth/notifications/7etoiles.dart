import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/vainqueur/detail_vendu_screen.dart';
import 'package:flutter/material.dart';

class Etoile7Notif extends StatefulWidget {
  const Etoile7Notif({super.key});

  @override
  State<Etoile7Notif> createState() => _Etoile7NotifState();
}

class _Etoile7NotifState extends State<Etoile7Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorwhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: colorblack,
        ),
        title: const Text('7 Etoiles'),
        actions: const [
          Icon(
            Icons.download,
            color: colorblack,
          ),
          Icon(
            Icons.delete,
            color: colorblack,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          child: Column(
                            children: [
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  // ignore: prefer_const_constructors
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, right: 10),
                                      child: Image.asset(
                                        'assets/images/Calque10.png',
                                        width: 70,
                                        height: 70,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text(
                                                'Roseline Koffi',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 30,
                                                color: Color(0xFFFF9700),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: const TextSpan(
                                    text:
                                        'FELICITAION à M.FREDERIC ASSE qui bénéficie gratuitement d\'un bonus de 10 000  Fr. Titulaire 6x7 étoiles équivalent à 14 marchés enregistrés Bonus total reçu = 20 000  Fr',
                                    style: TextStyle(
                                      color: colorblack,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child:
                                    Image.asset('assets/images/Image228.png'),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: const Text('547 Vues'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorYellow,
        ),
        child: const Text(
          'Voir les heureux gagnants',
          style: TextStyle(color: colorwhite, fontSize: 16),
        ),
      ),
    );
  }
}
