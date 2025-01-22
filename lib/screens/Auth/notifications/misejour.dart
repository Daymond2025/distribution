import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class MiseAjourScreen extends StatefulWidget {
  const MiseAjourScreen({super.key});

  @override
  State<MiseAjourScreen> createState() => _MiseAjourScreenState();
}

class _MiseAjourScreenState extends State<MiseAjourScreen> {
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
        title: const Text('Mise à jour'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
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
                          Image.asset(
                            'assets/images/icon.png',
                            height: 70,
                            width: 70,
                          ),
                          const Text(
                            'Nouvelle mise à jour disponible\n Version 6.3',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Lancer',
                            style: TextStyle(color: colorBlue),
                          ),
                          Container(
                            width: 1.5,
                            height: 20,
                            color: Colors.grey,
                          ),
                          const Text(
                            'Installer',
                            style: TextStyle(color: colorBlue),
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
    );
  }
}
