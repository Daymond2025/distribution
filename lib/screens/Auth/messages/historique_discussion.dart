import 'package:distribution_frontend/screens/Auth/messages/discussion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constante.dart';

class HistoriqueDiscussion extends StatefulWidget {
  const HistoriqueDiscussion({super.key});

  @override
  State<HistoriqueDiscussion> createState() => _HistoriqueDiscussionState();
}

class _HistoriqueDiscussionState extends State<HistoriqueDiscussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0,
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          size: 30, //change size on your need
          color: colorblack, //change color on your need
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: colorblack,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            child: Container(
              child: Stack(children: [
                Container(
                  width: 40,
                  height: 30,
                  margin: const EdgeInsets.only(right: 10, left: 20),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/Calque 1.png',
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 40,
                        margin:
                            const EdgeInsets.only(right: 0, left: 5, top: 10),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'images/Calque 3.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 30,
                        margin: const EdgeInsets.only(right: 13, top: 15),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'images/Calque 2.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Discussion(),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Messages',
          style: TextStyle(
            color: colorblack,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: DiscussionSection(),
          )
        ],
      ),
    );
  }
}

class DiscussionSection extends StatelessWidget {
  DiscussionSection({super.key, this.onTap});
  final List Discussion = [
    {
      'profile': 'images/Calque 2.png',
      'Name': 'Marc',
      'Message': 'Bonjour cher client',
      'date': '15:23',
      'Online': 0,
    },
    {
      'profile': 'images/Calque 1.png',
      'Name': 'Sarah',
      'Message': 'Bonjour cher assistant',
      'date': '15:23',
      'Online': 1,
    },
  ];

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: Discussion.map((Discussion) {
        return InkWell(
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FilDiscussionAss3(),
              //   ),
              // );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Discussion['Online'] != 0
                    ? Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        padding: const EdgeInsets.all(8),
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 206, 233, 245),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 65, 65, 65)
                                  .withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Stack(children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    margin: const EdgeInsets.only(
                                      right: 23,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorwhite,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          Discussion['profile'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Discussion['Online'] != 0
                                      ? Positioned(
                                          bottom: 5,
                                          right: 23,
                                          child: Container(
                                            height: 20,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green),
                                          ),
                                        )
                                      : Container()
                                ]),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Discussion['Name'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Wrap(
                                            children: [
                                              Discussion['Online'] != 0
                                                  ? Text(
                                                      Discussion['Message'],
                                                      maxLines: 7,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        // fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  : Text(
                                                      Discussion['Message'],
                                                      maxLines: 7,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    const SizedBox(
                                                      width: 220,
                                                    ),
                                                    Text(
                                                      Discussion['date'],
                                                      maxLines: 7,
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        padding: const EdgeInsets.all(8),
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 65, 65, 65)
                                  .withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Stack(children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    margin: const EdgeInsets.only(right: 23),
                                    decoration: BoxDecoration(
                                      color: colorwhite,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          Discussion['profile'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Discussion['Online'] != 0
                                      ? Positioned(
                                          bottom: 0,
                                          right: 23,
                                          child: Container(
                                            height: 20,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green),
                                          ),
                                        )
                                      : Container()
                                ]),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Discussion['Name'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Wrap(
                                            children: [
                                              Discussion['Online'] != 0
                                                  ? Text(
                                                      Discussion['Message'],
                                                      maxLines: 7,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 57, 206, 248),
                                                        // fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  : Text(
                                                      Discussion['Message'],
                                                      maxLines: 7,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    const SizedBox(
                                                      width: 220,
                                                    ),
                                                    Text(
                                                      Discussion['date'],
                                                      maxLines: 7,
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      }).toList()),
    );
  }
}
