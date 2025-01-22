import 'package:distribution_frontend/models/city.dart';

class Country {
  int id;
  int isActive;
  String name;
  String code;
  String flag;
  String currency;
  String indicatif;
  List<dynamic> cities;

  Country({
    required this.id,
    required this.isActive,
    required this.name,
    required this.flag,
    required this.code,
    required this.indicatif,
    required this.currency,
    required this.cities,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // print(json['cities']);
    return Country(
      id: json['id'],
      isActive: json['isActive'],
      name: json['name'],
      flag: json['flag'],
      code: json['code'],
      indicatif: json['indicatif'],
      currency: json['currency'],
      cities: json['cities'],
    );
  }
}
