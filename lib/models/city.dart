import 'focal_point.dart';
import 'country.dart';

class City {
  int id;
  String name;
  Country? country;
  List<FocalPoint>? focalPoints;

  City({
    required this.id,
    required this.name,
    this.country,
    this.focalPoints,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    // print("============city ${json['id']} =================");
    // if (json == null) {
    //   print("json est nul");
    // }
    // if (json['country'] == null) {
    //   print("country est nul");
    // }
    return City(
      id: json['id'],
      name: json['name'],
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
      // focalPoints: [],
    );
  }

  factory City.fromJsonFocalPoint(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      focalPoints: json['focal_points'].length > 0
          ? (json['focal_points'] as List)
              .map((jso) => FocalPoint.fromJson(jso))
              .toList()
          : [],
    );
  }

  factory City.fromJsonSimple(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      focalPoints: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'country': country?.toJson(), // Appelle toJson de Country si non nul
      // 'focal_points': focalPoints.map((fp) => fp.toJson()).toList(), // Convertit chaque FocalPoint en JSON
    };
  }
}
