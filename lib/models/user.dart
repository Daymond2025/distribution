import 'package:distribution_frontend/models/seller.dart';

class User {
  int id;
  String identifiant;
  String? email;
  Seller? seller;

  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  User({
    required this.id,
    required this.identifiant,
    this.email,
    this.seller,

    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      identifiant: json['identifiant'],
      email: json['email'],
      seller: json['seller'] ? json['seller'] :  null,

      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }
}
