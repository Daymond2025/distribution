import 'package:distribution_frontend/models/user.dart';

class Recruiter {
  int id;
  String firstName;
  String lastName;
  String? picture;

  Recruiter({
    required this.id,
    required this.firstName,
    required this.lastName,

    this.picture,
  });

  factory Recruiter.fromJson(Map<String, dynamic> json) {
    return Recruiter(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      picture: json['picture_path'],
    );
  }
}
