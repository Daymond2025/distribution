import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class DateActu extends StatefulWidget {
  const DateActu({super.key, required this.date});
  final String date;

  @override
  State<DateActu> createState() => _DateActuState();
}

class _DateActuState extends State<DateActu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 92,
            height: 2,
            color: colorwhite,
          ),
          Container(
            width: 85,
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.date,
              style: const TextStyle(
                letterSpacing: .5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
