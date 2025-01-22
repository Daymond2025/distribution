import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/panier_screen.dart';
import 'package:flutter/material.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0,
      ),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          IconButton(
            // ignore: avoid_print
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PanierScreen(),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black45,
              size: 25,
            ),
          ),
          const Positioned(
            top: 2,
            right: 4,
            height: 15,
            width: 15,
            child: CircleAvatar(
              backgroundColor: colorannule,
              foregroundColor: colorwhite,
              child: Text(
                '0',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
