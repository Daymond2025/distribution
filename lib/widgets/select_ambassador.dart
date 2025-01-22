import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/focal_point.dart';
import 'package:distribution_frontend/models/city.dart';
import 'package:flutter/material.dart';

class SelectAmbassador extends StatefulWidget {
  const SelectAmbassador(
      {super.key, required this.items, required this.currentCity});
  final List<City> items;
  final int currentCity;

  @override
  State<SelectAmbassador> createState() => _SelectAmbassadorState();
}

class _SelectAmbassadorState extends State<SelectAmbassador> {
  int cityId = 0;
  String cityName = '';
  bool delivery = false;
  int ambassadorId = 0;
  String ambassadorCompany = '';
  String ambassadorAddress = '';
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // void _cancel() {
  //   Navigator.pop(context);
  // }

  void _submit() {
    List<String> response = [];

    response.add(cityId.toString());
    response.add(cityName);
    response.add(delivery ? 'true' : 'false');

    if (ambassadorId != 0) {
      response.add(ambassadorId.toString());
      response.add(ambassadorCompany);
      response.add(ambassadorAddress);
    }

    Navigator.pop(context, response);
  }

  void _selectCity(City ci) {
    if (ci.id == widget.currentCity) {
      setState(() {
        cityId = ci.id;
        cityName = ci.name;
        delivery = true;
      });
      _submit();
    } else if (ci.id == cityId) {
      setState(() {
        cityId = 0;
        cityName = '';
        ambassadorId = 0;
        ambassadorCompany = '';
        ambassadorAddress = '';
      });
    } else {
      setState(() {
        cityId = ci.id;
        cityName = ci.name;
      });

      if (ci.focalPoints.isEmpty) {
        _submit();
      }
    }
  }

  void _selectAmbassador(FocalPoint amb) {
    setState(() {
      ambassadorId = amb.id;
      ambassadorCompany = amb.name;
      ambassadorAddress = amb.address;
    });

    _submit();
  }

  @override
  Widget build(BuildContext context) {
    List<City> filteredItems = widget.items
        .where((city) =>
            city.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Rechercher une ville',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListBody(
            children: filteredItems
                .map(
                  (e) => kCardAmbassadorsByCity(e),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  GestureDetector kCardAmbassadorsByCity(City city) => GestureDetector(
        onTap: () => _selectCity(city),
        child: widget.currentCity != city.id
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: cityId == city.id &&
                                              city.focalPoints.isNotEmpty
                                          ? const Color.fromARGB(
                                              115, 158, 158, 158)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  city.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(85, 158, 158, 158),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text('${city.focalPoints.length}'),
                            )
                          ],
                        ),
                        cityId == city.id && city.focalPoints.isNotEmpty
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                width: MediaQuery.sizeOf(context).width,
                                color: const Color.fromRGBO(245, 246, 251, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: city.focalPoints
                                      .map((ambassador) =>
                                          kAmbassador(ambassador))
                                      .toList(),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Divider(color: const Color.fromARGB(255, 233, 233, 233)),
                ],
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: cityId == city.id &&
                                                city.focalPoints.isNotEmpty
                                            ? const Color.fromARGB(
                                                115, 158, 158, 158)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '${city.name} (livraison à domicile)',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.delivery_dining,
                                color: colorYellow2,
                              ),
                            ],
                          ),
                        ),
                        cityId == city.id && city.focalPoints.isNotEmpty
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                width: MediaQuery.sizeOf(context).width,
                                color: const Color.fromRGBO(245, 246, 251, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: city.focalPoints
                                      .map((ambassador) =>
                                          kAmbassador(ambassador))
                                      .toList(),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color.fromARGB(255, 233, 233, 233),
                  ),
                ],
              ),
      );

  GestureDetector kAmbassador(FocalPoint ambassador) => GestureDetector(
        onTap: () => _selectAmbassador(ambassador),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(8),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ambassador.name),
              Text(
                ambassador.address,
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      );
}
