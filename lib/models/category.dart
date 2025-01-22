import 'package:distribution_frontend/models/sub_category_simple.dart';

class Category {
  int id;
  String name;
  String imgPath;
  List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.imgPath,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ,
      name: json['name'] ,
      imgPath: json['picture'] ?? '' ,
      subCategories: json['sub_categories'].length > 0 ? (json['sub_categories'] as List)
          .map((jso) => SubCategory.fromJson(jso))
          .toList() : [],
    );
  }
}
