import 'package:distribution_frontend/models/category.dart';
import 'package:distribution_frontend/models/order.dart';

class Transaction {
  int id;
  String reference;
  String? type; // 🔥 nullable
  int amount;
  String? operator;
  String? phoneNumber;
  String status;
  Order? order;

  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  Transaction({
    required this.id,
    this.type,
    required this.amount,
    required this.reference,
    this.operator,
    this.order,
    this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['category'] as String?, // 🔥 corrigé + nullable
      amount: json['amount'] is String
          ? int.tryParse(json['amount']) ?? 0
          : json['amount'] ?? 0, // 🔥 safe parse
      reference: json['reference'] ?? '',
      operator: json['operator'],
      phoneNumber: json['phone_number'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAtFr: json['created_at_fr'] ?? '',
      updatedAtFr: json['updated_at_fr'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': type,
      'amount': amount,
      'reference': reference,
      'operator': operator,
      'phone_number': phoneNumber,
      'status': status,
      'order': order?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}
