import 'package:distribution_frontend/models/model.dart';
import 'package:distribution_frontend/models/product.dart';

class CloneProduct extends Model {
  int id;
  String url;
  String reference;
  String title;
  int price;
  int commission; // Commission classique
  double? winningBonusAmount; // Bonus du produit gagnant (clic 25)
  bool? isWinningProduct;
  String phoneNumber;
  String? subTitle;
  String? description;
  Product product;
  String createdAtFr;
  // 🆕 Champs ajoutés
  int clicksCount;
  double totalEarnings;

  CloneProduct({
    required this.id,
    required this.commission,
    this.isWinningProduct,
    this.winningBonusAmount,
    required this.url,
    required this.reference,
    required this.title,
    required this.price,
    required this.phoneNumber,
    this.subTitle,
    this.description,
    required this.product,
    required this.createdAtFr,
    this.clicksCount = 0,
    this.totalEarnings = 0.0,
  });

  factory CloneProduct.fromJson(Map<String, dynamic> json) {
    return CloneProduct(
      id: json['id'],
      commission: json['commission'],
      isWinningProduct: json['is_winning_product'] == 1 || json['is_winning_product'] == true,
      winningBonusAmount: json['winning_bonus_amount'] != null
          ? double.tryParse(json['winning_bonus_amount'].toString())
          : null,
      url: json['url'],
      reference: json['reference'],
      title: json['title'],
      price: json['price'],
      phoneNumber: json['phone_number'],
      subTitle: json['sub_title'],
      description: json['description'],
      product: Product.fromJson(json['product']),
      createdAtFr: json['created_at_fr'],
      // 🆕 Parsing des nouveaux champs
      clicksCount: json['clicks_count'] ?? 0,
      totalEarnings: (json['total_earnings'] != null)
          ? double.tryParse(json['total_earnings'].toString()) ?? 0.0
          : 0.0,
    );
  }
}
