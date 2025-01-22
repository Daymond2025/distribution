import 'package:distribution_frontend/models/model.dart';
import 'package:distribution_frontend/models/product.dart';

class Favorite extends Model {
  int id;
  Product product;


  Favorite({
    required this.id,
    required this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] ?? '',
      product: Product.fromJson(json['product']),
    );
  }
}
