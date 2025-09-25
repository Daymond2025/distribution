import 'package:flutter/material.dart';

class ClicCard extends StatelessWidget {
  final VoidCallback onTap;

  const ClicCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.all(2),
      child: Container(
        height: 230, // Hauteur fixe pour caler les éléments
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(255, 204, 0, 1), // Jaune
              Color.fromRGBO(255, 55, 0, 1), // Rouge/orangé
            ],
          ),
        ),
        child: Stack(
          children: [
            // Image 25F
            Positioned(
              top: -0,
              left: 0,
              
              child: Image.asset(
                "assets/images/25FCFA.png",
                width: 200,
              ),
            ),

            // Image "Par Clic"
            Positioned(
              top: 130,
              left: 25,
              child: Image.asset(
                "assets/images/Par_clics.png",
                width: 125,
              ),
            ),

            // Icône main clic
            Positioned(
              bottom: -90,
              right: -80,
              child: Image.asset(
                "assets/images/clic.png",
                width: 300,
              ),
            ),

            // Bouton Voir plus (dans ta Stack de la carte)
            Positioned(
              bottom:
                  15, // 👈 au lieu de "top: 543", on l'accroche en bas de la carte
              left: 5, // petit décalage à gauche comme dans la maquette
              child: SizedBox(
                width: 154,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black.withOpacity(0.41), // rgba(0,0,0,0.51)
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                  ),
                  onPressed: onTap,
                  child: const Text(
                    "Voir plus",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
