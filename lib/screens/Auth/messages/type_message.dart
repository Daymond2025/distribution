import 'package:flutter/material.dart';

class ChatPage2 extends StatefulWidget {
  const ChatPage2({super.key});

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: null,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SizedBox(
          child: Container(
            child: Expanded(
              child: Container(
                //padding: const EdgeInsets.all(15),
                height: 45,
                width: 140,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/Calque 7.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(children: [
                      const Expanded(
                        child: Text(
                          'M. Marc',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "En ligne",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // CircleAvatar(
                      //   radius: 20,
                      // ),
                    ]),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
        ),
      ),
      body: const ChatingSection(),
      bottomNavigationBar: const BottomSection(),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8.0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 0,
              ),
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.grey,
                  size: 35,
                ),
                onPressed: null,
                splashColor: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ChatPage1(),
                  //   ),
                  // );
                },
                child: Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(248, 220, 221, 222),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Votre message...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
              ),
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onPressed: null,
                splashColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatingSection extends StatelessWidget {
  const ChatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: const SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(height: 15),
                SizedBox(
                  height: 15,
                  child: Text('dimanche 15 août 13:09',
                      style: TextStyle(color: Colors.grey)),
                ),
                SizedBox(height: 25),
                // ignore: prefer_const_constructors
                TextMessage(
                  message:
                      "Bonsoir daymond svp je peux avoir la definition du prix grossiste?",
                  date: "17:13",
                  isReceiver: 0,
                  isDirect: 0,
                ),
                SizedBox(height: 25),
                // ignore: prefer_const_constructors
                TextMessage(
                  message: "Message automatique de daymond",
                  date: "17:10",
                  isReceiver: 1,
                  isDirect: 0,
                ),
                SizedBox(height: 25),

                SizedBox(
                  height: 15,
                  child: Text('lundi 16 août 08:24',
                      style: TextStyle(color: Colors.grey)),
                ),
                SizedBox(height: 25),

                ImageMessage(
                  image: 'assets/images/Calque 7.png',
                  date: "17:09",
                  description: "Celle-ci peut être à 1500 Fr",
                ),
                SizedBox(height: 25),

                AudioMessage(date: "18:05"),
                SizedBox(height: 25),

                TextMessage(
                  message: "Vous avez une machine à laver ? ",
                  date: "16:59",
                  isReceiver: 1,
                  isDirect: 0,
                ),
                SizedBox(height: 25),

                TextMessage(
                  message: "Oui il y en a",
                  date: "16:53",
                  isReceiver: 0,
                  isDirect: 0,
                ),
                TextMessage(
                  message: "Vous n'aurez pas besoin d'apporter quelque chose",
                  date: "16:50",
                  isReceiver: 0,
                  isDirect: 1,
                ),
                TextMessage(
                  message: "D'accord je serai là demain à 9h",
                  date: "16:48",
                  isReceiver: 1,
                  isDirect: 0,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }
}

class TextMessage extends StatelessWidget {
  final String message, date;
  final int isReceiver, isDirect;

  const TextMessage({
    super.key,
    required this.message,
    required this.date,
    required this.isReceiver,
    required this.isDirect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          isReceiver == 1
              ? const SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      SizedBox(width: 7.0),
                    ],
                  ),
                )
              : SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      const Text('Lu'),
                      const SizedBox(width: 7.0),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: isReceiver == 1
                  ? const EdgeInsets.only(
                      right: 25,
                    )
                  : const EdgeInsets.only(
                      left: 20,
                    ),
              padding: const EdgeInsets.all(6),
              height: 55,
              decoration: isReceiver == 1
                  ? const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: Offset(0, 2),
                            color: Colors.grey)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    )
                  : const BoxDecoration(
                      color: Color.fromARGB(255, 57, 206, 248),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        //topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
              child: Text(
                message,
                style: TextStyle(
                  color: isReceiver == 1 ? Colors.grey : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          isReceiver == 1
              ? SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      const Text('Reçu'),
                      const SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 7.0,
                      ),
                    ],
                  ),
                ),
          isReceiver == 0 && isDirect == 1
              ? Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 10,
                  ),
                  width: 45,
                  height: 45,
                )
              : Container(),
        ],
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  final String date;

  const AudioMessage({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 60,
          child: Column(
            children: [
              Text('Lu'),
              SizedBox(width: 7.0),
              Text(
                "17:14",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 15, bottom: 5, right: 50),
            padding: const EdgeInsets.all(6),
            height: 55,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 57, 206, 248),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                //topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                const IconButton(
                  icon: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                Image.asset(
                  'images/enregistrement.jpg',
                  height: 35,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ImageMessage extends StatelessWidget {
  final String image, date, description;

  const ImageMessage({
    super.key,
    required this.image,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 16,
          ),
          width: 45,
          height: 45,
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 26,
                  top: 5,
                ),
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(22.0),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  right: 25,
                  bottom: 10,
                ),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                height: 55,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                        color: Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Wrap(children: [
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 60,
          child: Column(
            children: [
              const Text('Reçu'),
              const SizedBox(
                width: 7.0,
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
