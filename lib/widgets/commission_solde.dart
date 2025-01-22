import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class CommissionSolde extends StatefulWidget {
  const CommissionSolde({super.key});

  @override
  State<CommissionSolde> createState() => _CommissionSoldeState();
}

class _CommissionSoldeState extends State<CommissionSolde> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const DetailMarche(),),),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorwhite, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset('assets/images/basketblanches.png'),
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
                              text: 'GAIN RECU : ',
                              style: TextStyle(color: colorblack),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '1500 F CFA',
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
