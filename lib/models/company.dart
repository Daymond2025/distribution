class Company {
  int id;
  String name;
  String? image;

  Company({
    required this.id,
    required this.name,
    this.image,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
