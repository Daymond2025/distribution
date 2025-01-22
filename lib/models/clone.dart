import 'package:distribution_frontend/models/model.dart';
import 'package:distribution_frontend/models/product.dart';

class CloneProduct extends Model {
  int id;
  String url;
  String reference;
  String title;
  int price;
  String phoneNumber;
  String? subTitle;
  String? description;
  Product product;
  String createdAtFr;

  CloneProduct({
    required this.id,
    required this.url,
    required this.reference,
    required this.title,
    required this.price,
    required this.phoneNumber,
    this.subTitle,
    this.description,
    required this.product,
    required this.createdAtFr,
  });

  factory CloneProduct.fromJson(Map<String, dynamic> json) {
    return CloneProduct(
      id: json['id'],
      url: json['url'],
      reference: json['reference'],
      title: json['title'],
      price: json['price'],
      phoneNumber: json['phone_number'],
      subTitle: json['sub_title'],
      description: json['description'],
      product: Product.fromJson(json['product']),
      createdAtFr: json['created_at_fr'],

    );
  }
}