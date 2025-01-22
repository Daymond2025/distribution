import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SectionTitle extends StatefulWidget {
  const SectionTitle(
      {super.key,
      required this.title,
      required this.ontap,
      required this.icon});
  final String title;
  final Function ontap;
  final String icon;

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  double _padding = 10;

  @override
  void initState() {
    super.initState();
    if (widget.icon != '') {
      _padding = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: _padding,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorYellow,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.title),
          const Text(''),
          widget.icon != ''
              ? IconButton(
                  onPressed: () => widget.ontap(),
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronUp,
                    color: colorBlue,
                  ),
                )
              : InkWell(
                  child: const Text(
                    'Voir plus',
                    style: TextStyle(
                      color: colorBlue,
                      fontSize: 17,
                    ),
                  ),
                  onTap: () => widget.ontap()),
        ],
      ),
    );
  }
}
