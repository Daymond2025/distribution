import 'package:distribution_frontend/models/product.dart';

class Slide {
  int id;
  String picture;
  Product? product;

  Slide({
    required this.id,
    required this.picture,
    this.product,
  });

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
      id: json['id'] ,
      picture: json['picture_path'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}
