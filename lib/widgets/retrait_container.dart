import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class RectraitContainer extends StatefulWidget {
  const RectraitContainer({super.key});

  @override
  State<RectraitContainer> createState() => _RectraitContainerState();
}

class _RectraitContainerState extends State<RectraitContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorwhite, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset('assets/images/Image4.png'),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: '-',
                              style: TextStyle(
                                color: colorBlue,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'RETRAIT : ',
                                  style: TextStyle(color: colorblack),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '49 500 F CFA',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/Images1.png'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Rétiré le ',
                          style: TextStyle(fontSize: 10, color: colorblack),
                          children: <TextSpan>[
                            TextSpan(
                              text: '12 jan.',
                              style: TextStyle(fontSize: 10),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '10:10',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
