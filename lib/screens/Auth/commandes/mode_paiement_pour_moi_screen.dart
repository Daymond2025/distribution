import 'dart:ui';

import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/commandes/rendez_vous_agence_screen.dart';
import 'package:flutter/material.dart';

class ModePaiementPourMoiScreen extends StatefulWidget {
  const ModePaiementPourMoiScreen({super.key});

  @override
  State<ModePaiementPourMoiScreen> createState() =>
      _ModePaiementPourMoiScreenState();
}

class _ModePaiementPourMoiScreenState extends State<ModePaiementPourMoiScreen> {
  bool clickPF = false;
  //mode de paiement
  bool orange = false;
  bool wave = false;
  bool moov = false;
  bool mtn = false;

  //banque
  bool banque1 = false;
  bool banque2 = false;
  bool banque3 = false;
  bool banque4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: colorwhite,
          titleTextStyle: const TextStyle(
            color: colorblack,
          ),
          iconTheme: const IconThemeData(
            size: 25, //change size on your need
            color: colorblack, //change color on your need
          ),
          title: const Row(
            children: <Widget>[
              Icon(Icons.payment),
              SizedBox(
                width: 10,
              ),
              Text('Mode de paiement')
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: Column(
            children: <Widget>[
              //PORTEFEUILLEE
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 50,
                      ),
                      child: const Text(
                        'Nous vous garantissons un paiement sécurisé par le moyen de paiement de votre choix',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.wallet_sharp),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MON PORTEFEUIL',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Récommandé',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Checkbox(
                          value: clickPF,
                          onChanged: ((value) {
                            setState(() {
                              clickPF = value!;
                              orange = false;
                              mtn = false;
                              orange = false;
                              moov = false;
                              banque1 = false;
                              banque2 = false;
                              banque3 = false;
                              banque4 = false;
                            });
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //MOBILE MONEY
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mobile_friendly),
                          SizedBox(
                            width: 5,
                          ),
                          Text('MOBILE MONEY')
                        ],
                      ),
                    ),
                    //orange
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Image44.png',
                                width: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Orange money',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: orange,
                            onChanged: ((value) {
                              setState(() {
                                orange = value!;
                                mtn = false;
                                moov = false;
                                wave = false;
                                clickPF = false;
                                banque1 = false;
                                banque2 = false;
                                banque3 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    //wage
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Groupe3.png',
                                width: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Wave',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: wave,
                            onChanged: ((value) {
                              setState(() {
                                wave = value!;
                                mtn = false;
                                moov = false;
                                orange = false;
                                clickPF = false;
                                banque1 = false;
                                banque2 = false;
                                banque3 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    //MOOV
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/MOOV.png',
                                width: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Moov Money',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: moov,
                            onChanged: ((value) {
                              setState(() {
                                moov = value!;
                                mtn = false;
                                orange = false;
                                wave = false;
                                clickPF = false;
                                banque1 = false;
                                banque2 = false;
                                banque3 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    //MTN
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/MTN.png',
                                width: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MTN Money',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: mtn,
                            onChanged: ((value) {
                              setState(() {
                                mtn = value!;
                                orange = false;
                                moov = false;
                                wave = false;
                                clickPF = false;
                                banque1 = false;
                                banque2 = false;
                                banque3 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //BANQUE
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Text('COMPTE BANCAIRE')
                        ],
                      ),
                    ),
                    //
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: colorattente,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: banque1,
                            onChanged: ((value) {
                              setState(() {
                                banque1 = value!;
                                mtn = false;
                                moov = false;
                                wave = false;
                                clickPF = false;
                                orange = false;
                                banque2 = false;
                                banque3 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    //
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: colorannule,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: banque2,
                            onChanged: ((value) {
                              setState(() {
                                banque2 = value!;
                                mtn = false;
                                moov = false;
                                wave = false;
                                clickPF = false;
                                orange = false;
                                banque1 = false;
                                banque3 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    //
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: colorYellow,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: banque3,
                            onChanged: ((value) {
                              setState(() {
                                banque3 = value!;
                                mtn = false;
                                moov = false;
                                wave = false;
                                clickPF = false;
                                orange = false;
                                banque2 = false;
                                banque1 = false;
                                banque4 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    //
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: colorBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Checkbox(
                            value: banque4,
                            onChanged: ((value) {
                              setState(() {
                                banque4 = value!;
                                mtn = false;
                                moov = false;
                                wave = false;
                                clickPF = false;
                                orange = false;
                                banque2 = false;
                                banque3 = false;
                                banque1 = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //DIRECTION A L'ARGENCE
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: colorwhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RendezVousAgenceScreen(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(),
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PRENDRE RENDEZ-VOUS',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Prenez rendez-vous a l’agence pour le paiement !',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Icon(Icons.arrow_right_sharp)
                      ],
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: (() => print('condition de paiement')),
                child: Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(bottom: 70, top: 15),
                  child: const Text(
                    'Condition de paiement',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: colorfond,
        child: InkWell(
          onTap: (() => print('confirmation')),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: colorYellow2,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: const Text(
              'CONFIRMER',
              style: TextStyle(
                color: colorwhite,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
