//import 'package:distribution_frontend/screens/Auth/messages/assistant2/historique_discussionAss2.dart';
import 'package:flutter/material.dart';

import '../../../constante.dart';
import '../../home_screen.dart';
import 'historique_discussion.dart';

class Discussion extends StatefulWidget {
  const Discussion({super.key});

  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            color: colorblack,
          ),
        ),
      ),
      body: Column(
        children: [
          InformationSection(),
          AssistantSection(),
          // Container(
          //   height: 100,
          //   color: Color(0xB316BFC4),
          // ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: MessageSection(),
          )
        ],
      ),
    );
  }
}

class InformationSection extends StatelessWidget {
  final List menuItems = [
    "Démarrez une nouvelle conversation avec l'un\ndes assistants daymond"
  ];
  InformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Color.fromRGBO(250, 250, 253, 1),

      height: 90,
      //width: 410,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: menuItems.map((item) {
              return Container(
                margin: const EdgeInsets.only(right: 55),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class AssistantSection extends StatelessWidget {
  AssistantSection({super.key});
  final List FavoriteContacts = [
    {'nom': "Sarah", 'profile': 'images/Calque 1.png'},
    {'nom': "Marc", 'profile': 'images/Calque 2.png'},
    {'nom': "Christine", 'profile': 'images/Calque 3.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        //height: 100,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 65, 65, 65).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 6), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FavoriteContacts.map((favorite) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HistoriqueDiscussion()));
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            height: 90,
                            width: 90,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(favorite['profile']),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              favorite['nom'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  MessageSection({super.key});
  final List messages = [
    {
      'AssistantProfile': 'images/Calque 1.png',
      'message':
          "Pour des questions sur la fonctionnalité\ndaymond distribution selectionnez ",
      'AssistantNom': "Sarah",
    },
    {
      'AssistantProfile': 'images/Calque 2.png',
      'AssistantNom': 'Mark',
      'message':
          "Pour des problèmes lié à vos commandes ou \nvos activités sur l'application daymond \ndistricution sélectionnez M. ",
    },
    {
      'AssistantProfile': 'images/Calque 3.png',
      'AssistantNom': 'Christine',
      'message': 'Pour toutes autres préoccupations \nsélectionnez ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: messages.map((message) {
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ChatPage(),
            //   ),
            // );
          },
          splashColor: colorYellow3,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Stack(children: [
                      Container(
                        width: 55,
                        height: 55,
                        margin: const EdgeInsets.only(right: 23),
                        decoration: BoxDecoration(
                          color: colorwhite,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              message['AssistantProfile'],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 23,
                        child: Container(
                          height: 20,
                          width: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  RichText(
                                    maxLines: 7,
                                    text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                        text: message['message'],
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: message["AssistantNom"],
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color.fromARGB(
                                                  255, 57, 206, 248),
                                            ),
                                          )
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Expanded(
                                  //   child: Text(
                                  //     message["AssistantNom"],
                                  //     style: TextStyle(
                                  //         fontSize: 11, color: Colors.blue),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList()),
    );
  }
}
