import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class RendezVousAgenceScreen extends StatefulWidget {
  const RendezVousAgenceScreen({super.key});

  @override
  State<RendezVousAgenceScreen> createState() => _RendezVousAgenceScreenState();
}

class _RendezVousAgenceScreenState extends State<RendezVousAgenceScreen> {
  bool _agence = false;
  bool _date = false;
  bool _heure = false;
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: colorwhite,
          iconTheme: const IconThemeData(
            color: Colors.black45,
          ),
          titleTextStyle: const TextStyle(
            color: colorblack,
          ),
          title: const Row(
            children: [
              Icon(Icons.list_alt),
              SizedBox(
                width: 10,
              ),
              Text('Prendre rendez-vous'),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorwhite,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Votre contact',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 40,
                          alignment: Alignment.bottomLeft,
                          child: TextFormField(
                            maxLength: 15,
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            decoration: const InputDecoration(
                              counter: Offstage(),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Cliquez ici",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            //Agence
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _agence = !_agence;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Sélectionner l’agence la plus proche',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            _agence
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                      ),
                    ),
                    child: const Text('data'),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
            //date
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _date = !_date;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Sélectionner la date',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            _date
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(),
                    child: InkWell(
                      onTap: () async {
                        final date = await pickDate();
                        if (date == null) return;
                        final newDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          dateTime.hour,
                          dateTime.minute,
                        );
                        setState(() {
                          dateTime = newDateTime;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 200,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: colorBlue),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/link_icon.jpg',
                              width: 5,
                              height: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
            //heure
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _heure = !_heure;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer_outlined),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Sélectionner l\'heure',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            _heure
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: InkWell(
                      onTap: () async {
                        final time = await pickTime();
                        if (time == null) return;

                        final newDateTime = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          time.hour,
                          time.minute,
                        );

                        setState(() {
                          dateTime = newDateTime;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 200,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${dateTime.hour.toString().padLeft(2, '0')}h ${dateTime.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: colorBlue),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/link_icon.jpg',
                              width: 5,
                              height: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
            //
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        'Dite nous pourquoi ce rendez-vous ?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black12),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomLeft,
                      child: TextFormField(
                        minLines: 1,
                        maxLines: 7,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "motif...",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: colorfond,
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            height: 40,
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: colorYellow2,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: const Text(
              'ENVOYER',
              style: TextStyle(
                color: colorwhite,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(dateTime.year, dateTime.month + 1, dateTime.day),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );
}
