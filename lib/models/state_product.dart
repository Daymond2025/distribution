class StateProduct {
  int id;
  String name;

  StateProduct({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory StateProduct.fromJson(Map<String, dynamic> json) {
    return StateProduct(
      id: json['id'],
      name: json['name'],
    );
  }
}
