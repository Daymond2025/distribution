import 'package:distribution_frontend/models/city.dart';

class Country {
  int id;
  int isActive;
  String name;
  String code;
  String flag;
  String currency;
  String indicatif;
  List<City> cities;

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
    // if (json.containsKey('cities')) {
    //   print("DEBUG - json['cities']: ${json['cities']}");
    //   if (json['cities'] != null && json['cities'] is List) {
    //     print('==taille ${json['cities'].length}');
    //   } else {
    //     print("⚠️ WARNING - json['cities'] est NULL ou n'est pas une liste !");
    //   }
    // } else {
    //   print("🚨 ERROR - Clé 'cities' ABSENTE dans le JSON !");
    // }

    return Country(
      id: json['id'],
      isActive: json['isActive'],
      name: json['name'],
      flag: json['flag'],
      code: json['code'],
      indicatif: json['indicatif'],
      currency: json['currency'],
      cities: json['cities'] is List
          ? (json['cities'] as List)
              .map((item) => City.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
