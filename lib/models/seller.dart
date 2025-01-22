import 'package:distribution_frontend/models/recruiter.dart';

class Seller {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String? email;
  int stars;
  String city;
  int cityId;
  String country;
  String job;
  String? picture;
  bool brokenLink;

  String couverture;
  String? nom_boutique;

  Recruiter? recruiter;

  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  Seller({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.brokenLink,
    this.email,
    required this.stars,
    required this.city,
    required this.cityId,
    required this.country,
    required this.job,
    this.picture,
    required this.couverture,
    this.nom_boutique,
    this.recruiter,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['user']['phone_number'] ?? '',
      brokenLink: json['broken_link'] ?? true,
      email: json['user']['email'] ?? '',
      stars: json['stars'] ?? 0,
      job: json['job'] ?? '',
      city: json['city'] ?? '',
      cityId: json['city_id'],
      country: json['country'] ?? '',
      picture: json['user']['picture_path'],
      couverture: json['user']['couverture'],
      nom_boutique: json['user']['nom_boutique'],
      //recruiter: json['recruiter'] ? Recruiter.fromJson(json['recruiter']) : null,

      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }
}
