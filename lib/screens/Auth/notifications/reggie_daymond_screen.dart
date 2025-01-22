import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class ReggieDaymondScreen extends StatefulWidget {
  const ReggieDaymondScreen({super.key});

  @override
  State<ReggieDaymondScreen> createState() => _ReggieDaymondScreenState();
}

class _ReggieDaymondScreenState extends State<ReggieDaymondScreen> {
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
        title: const Text('Reggie daymond'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1),
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: const Center(
                                child: Text(
                                    'Ce produit est l\'un des plus vendu actuellement\n publiez-le et gagnez plus d\'argent'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorwhite,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: const Offset(0.5, 0.5),
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset('assets/images/tunique.png'),
                            ),
                            Expanded(
                              flex: 9,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: colorYellow,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: colorYellow,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: const Text('Neuf')),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                          'Complet tunique homme\n taille standart'),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '6 500  Fr',
                                        style: TextStyle(
                                          color: colorBlue,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '8 000  Fr',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
