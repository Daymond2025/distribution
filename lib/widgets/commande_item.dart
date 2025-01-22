import 'package:flutter/material.dart';

class CommandeItem extends StatefulWidget {
  const CommandeItem({super.key, required this.titre, required this.valeur});
  final String titre;
  final String valeur;

  @override
  State<CommandeItem> createState() => _orderItemState();
}

class _orderItemState extends State<CommandeItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            widget.titre,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.valeur,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
