import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class DetailClassementScreen extends StatefulWidget {
  const DetailClassementScreen({super.key});

  @override
  State<DetailClassementScreen> createState() => _DetailClassementScreenState();
}

class _DetailClassementScreenState extends State<DetailClassementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAFA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromARGB(255, 15, 15, 15),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star,
              color: Color(0xFFFF9700),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFAFA),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.5 - 50,
                      child: Container(
                        child: ClipOval(
                          child: Image.asset('assets/images/Calque10.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width * 0.5 - 50,
                      child: const Icon(
                        Icons.circle,
                        color: Color(0xFFFFC000),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: MediaQuery.of(context).size.width * 0.5 - 42,
                      child: const Text(
                        '3',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colorwhite),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: MediaQuery.of(context).size.width * 0.5 - 50,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Rosaline Koffi',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 135,
                      left: MediaQuery.of(context).size.width * 0.5 - 85,
                      child: Container(
                        child: const Text('Membre dépuis le 18/05/2020'),
                      ),
                    ),
                    Positioned(
                      top: 155,
                      left: MediaQuery.of(context).size.width * 0.5 - 70,
                      child: Container(
                        child: const Text(
                          '6 FOIS 7 ETOILES',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFC000),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: const Text(
                          'Produits vendus',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
                      left: MediaQuery.of(context).size.width * 0.5 + 60,
                      child: Container(
                        child: const Text(
                          '6ème étoiles',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFFC000),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
                      left: MediaQuery.of(context).size.width * 0.5 + 155,
                      child: Column(
                        children: [
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Icon(Icons.arrow_drop_down),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: SizedBox(
                                  width: 120,
                                  child: Row(
                                    children: [
                                      Text(
                                        '6-ème étoiles',
                                        style: TextStyle(
                                          color: Color(0xFFFFC000),
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_up),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text(
                                        '5-ème étoiles',
                                        style: TextStyle(
                                          color: colorblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text(
                                        '4-ème étoiles',
                                        style: TextStyle(
                                          color: colorblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 4,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text(
                                        '3-ème étoiles',
                                        style: TextStyle(
                                          color: colorblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 5,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text(
                                        '2-ème étoiles',
                                        style: TextStyle(
                                          color: colorblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 6,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text(
                                        '1-ère étoiles',
                                        style: TextStyle(
                                          color: colorblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 7,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text(
                                        'voir tout',
                                        style: TextStyle(
                                          color: colorblack,
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(child: Container()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
