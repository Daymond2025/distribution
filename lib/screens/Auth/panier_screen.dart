import 'package:flutter/material.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({super.key});
  static const routeName = '/panier';

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  bool isChecked = false;

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                  alignment: Alignment.center,
                  title: const Text(
                    'TYPE DE LIVRAISON',
                    style: TextStyle(color: Color(0xFFFFC000)),
                  ),
                  content: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      isChecked ? 'Yes' : 'Yamoussoukro',
                      style: const TextStyle(fontSize: 24),
                    ),
                    value: isChecked,
                    onChanged: (isChecked) =>
                        setState(() => this.isChecked = isChecked!),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('ok'),
                    ),
                  ],
                )),
      );
  int note = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(247, 251, 254, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            'Panier',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 5),
            child: const Text(
              '04',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      body: Container(
        padding: const EdgeInsets.all(5.0),
        width: double.infinity,
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 4,
                              ),
                              child: Image.asset(
                                'assets/images/IMG-20200908-WA0015.png',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFFFC000),
                                    ),
                                    // const SizedBox(
                                    //   width: 15,
                                    // ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFC000),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: const Text('Neuf'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 10,
                                      child: Text(
                                        'Complet tunique homme taille standard ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 4,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      // ignore: prefer_const_constructors
                                      Text(
                                        '6500  Fr',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          color: Color(0xFF2295F0),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text('il a 3min')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFECF0F3),
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        note -= 1;
                                        if (note < 1) note = 1;
                                      });
                                    },
                                    // ignore: prefer_const_constructors
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: const Color.fromARGB(
                                          255, 197, 197, 197),
                                    ),
                                  ),
                                ),
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: Text(
                                    '$note',
                                  ),
                                ),
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        note += 1;
                                      });
                                    },
                                    // ignore: prefer_const_constructors
                                    icon: Icon(
                                      Icons.add_circle_sharp,
                                      color: const Color(0xFFFF9700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.blueAccent,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      onPressed: () {
                                        openDialog();
                                      },
                                      child: const Text(
                                        'COMMANDER MAINTENANT',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
