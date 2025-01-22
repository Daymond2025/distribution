class FocalPoint {
  int id;
  String name;
  String logo;
  String address;
  String phoneNumber;
  String? email;

  FocalPoint({
    required this.id,
    required this.name,
    required this.logo,
    this.email,
    required this.address,
    required this.phoneNumber,
  });

  factory FocalPoint.fromJson(Map<String, dynamic> json) {
    return FocalPoint(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}
