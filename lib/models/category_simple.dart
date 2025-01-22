class Category {
  int id;
  String name;
  String imgPath;

  Category({
    required this.id,
    required this.name,
    required this.imgPath,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ,
      name: json['name'] ,
      imgPath: json['picture'] ?? '' ,
    );
  }
}
