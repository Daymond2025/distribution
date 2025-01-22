import 'package:distribution_frontend/models/product.dart';

class Cover {
  int id;
  String image;
  String? link;
  Product? product;

  Cover({
    required this.id,
    required this.image,
    this.link,
    this.product,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      id: json['id'] ,
      image: json['picture_path'] ,
      link: json['link'] ,
      product: Product.fromJson(json['product']),
    );
  }
}
