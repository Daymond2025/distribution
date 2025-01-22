import 'package:distribution_frontend/models/category.dart';

class SubCategory {
  int id;
  String name;
  Category category;

  SubCategory({
    required this.id,
    required this.name,
    required this.category,

  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ,
      name: json['name'] ,
      category:  Category.fromJson(json['category']),
    );
  }
}
