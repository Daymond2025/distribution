import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class CardPostActu extends StatefulWidget {
  const CardPostActu(
      {super.key,
      required this.title,
      this.comment,
      this.nblike,
      this.date,
      this.nbcomment,
      this.imagelike});
  final String title;
  final String? comment;
  final String? date;
  final String? nblike;
  final String? nbcomment;
  final String? imagelike;

  @override
  State<CardPostActu> createState() => _CardPostActuState();
}

class _CardPostActuState extends State<CardPostActu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        color: colorwhite,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 5,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'il y\'a 2min',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.zero,
              child: Text(
                widget.comment ?? '',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  widget.imagelike ?? 'assets/images/caroussel1.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      // ignore: avoid_print
                      onPressed: () => print('like ou non pas defaut'),
                      icon: const Icon(
                        Icons.thumb_up,
                        color: colorBlue,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      widget.nblike ?? '0',
                      style: const TextStyle(
                        color: colorBlue,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: colorBlue100,
                ),
                Row(
                  children: [
                    IconButton(
                      // ignore: avoid_print
                      onPressed: () {},

                      icon: const Icon(Icons.mode_comment),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      widget.nbcomment ?? '0',
                      style: const TextStyle(
                        color: colorBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
