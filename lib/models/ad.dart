import 'package:distribution_frontend/models/product.dart';

class Ad {
  int id;
  String image;
  String title;
  String? url;
  Product? product;


  Ad({
    required this.id,
    required this.image,
    required this.title,
    this.url,
    this.product,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      image: json['picture_path'],
      title: json['title'],
      url: json['url'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}
