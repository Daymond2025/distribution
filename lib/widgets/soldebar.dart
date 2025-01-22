import 'package:flutter/material.dart';

class SoldeBar extends StatefulWidget {
  const SoldeBar({super.key});

  @override
  State<SoldeBar> createState() => _SoldeBarState();
}

class _SoldeBarState extends State<SoldeBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 90,
                color: const Color(0xFF00276E),
              ),
              //bloc du solde
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF223CF0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 195,
                  height: 65,
                  //ligne qui gère le contenu du compte(solde)
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Image.asset('assets/images/portefeuille.png'),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'Soldes',
                                  style: TextStyle(color: Color(0xFFFFFFFF)),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        text: '55 000',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 5, top: 5),
                                      child: Text(
                                        'CFA',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //les deux blocs retraire/depôt
              Padding(
                padding: const EdgeInsets.only(left: 220, top: 10),
                child: Column(
                  children: [
                    //ajouter de l'argent
                    InkWell(
                      onTap: (() {}),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2295F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 150,
                        height: 30,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '+ Ajouter de l\'argent',
                                style: TextStyle(color: Color(0xFF00FFD4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //retirer de l'argent
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CB050),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 150,
                        height: 30,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '- Retirer de l\'argent',
                                style: TextStyle(color: Color(0xFF00FF0A)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
