
class PhoneNumber {
  int id;
  String phoneNumber;
  String operator;
  String createdAtFr;
  String updatedAtFr;


  PhoneNumber({
    required this.id,
    required this.phoneNumber,
    required this.operator,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      id: json['id'],
      phoneNumber: json['phone_number'],
      operator: json['operator'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }
}
