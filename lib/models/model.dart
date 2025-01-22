
class Model {
  String? createdAt;
  String? updatedAt;


  Model({
    this.createdAt,
    this.updatedAt,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
