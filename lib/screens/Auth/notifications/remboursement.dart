import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class Remboursement extends StatefulWidget {
  const Remboursement({super.key});

  @override
  State<Remboursement> createState() => _RemboursementState();
}

class _RemboursementState extends State<Remboursement> {
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
        title: const Text('Remboursement'),
        actions: const [
          Icon(
            Icons.delete,
            color: colorblack,
          ),
        ],
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
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Hello Micheal Kouamé votre demande de\n remboursement a été refusée',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'MOTIFS',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 40),
                              child: const Text(
                                  'Il ne vous reste que 2 étoiles pour bénéficier\n d\'un bonus de 10.000  Fr gratuitement'),
                            ),
                          ],
                        )
                      ],
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
