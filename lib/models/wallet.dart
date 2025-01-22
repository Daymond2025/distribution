import 'package:distribution_frontend/models/seller.dart';

class Wallet {
  int id;
  int totalAmount;
  int amount;
  Seller entity;

  Wallet({
    required this.id,
    required this.totalAmount,
    required this.amount,
    required this.entity,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      amount: json['amount'] ?? 0,
      entity: Seller.fromJson(json['entity']),
    );
  }
}
