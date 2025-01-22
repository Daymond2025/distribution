import 'package:distribution_frontend/models/city.dart';

class Shop {
  int id;
  String code;
  String name;
  City city;
  String address;
  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  Shop({
    required this.id,
    required this.code,
    required this.name,
    required this.city,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      city: City.fromJson(json['city']),
      address: json['address'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAtFr: json['created_at_fr'] ?? '',
      updatedAtFr: json['updated_at_fr'] ?? '',
    );
  }
}
