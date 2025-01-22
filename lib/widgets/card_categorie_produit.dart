import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class CardCategorieProduit extends StatefulWidget {
  const CardCategorieProduit({
    super.key,
    required this.nom,
    required this.url,
    required this.controller,
  });
  final String nom;
  final String url;
  final bool controller;

  @override
  State<CardCategorieProduit> createState() => _CardCategorieProduitState();
}

class _CardCategorieProduitState extends State<CardCategorieProduit> {
  String controlle = 'Ordinateur';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.url), fit: BoxFit.contain),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: widget.controller ? colorYellow2 : Colors.transparent,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.nom,
            style: TextStyle(
              color: widget.controller ? colorYellow2 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
