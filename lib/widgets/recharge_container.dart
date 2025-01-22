import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class RechargeContainer extends StatefulWidget {
  const RechargeContainer({super.key});

  @override
  State<RechargeContainer> createState() => _RechargeContainerState();
}

class _RechargeContainerState extends State<RechargeContainer> {
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
              child: Image.asset('assets/images/Groupe3.png'),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: '+',
                          style: TextStyle(
                            color: colorBlue,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'RECHARGE : ',
                              style: TextStyle(color: colorblack),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '6500 F CFA',
                                  style: TextStyle(color: colorBlue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Reçu le ',
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
                            ]),
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
