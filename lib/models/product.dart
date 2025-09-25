import 'package:distribution_frontend/models/shop.dart';
import 'package:distribution_frontend/models/state_product.dart';
import 'package:distribution_frontend/models/sub_category_simple.dart';

class Product {
  int id;
  String name;
  String type;
  String alias;
  String? description;
  String? subTitle;

  int subCategoryId;
  int stateId;

  int star;
  int popular;

  int stock;
  int unavailable;
  int invisible;

  int? priceSupplier;
  int? reducedPrice;

  PriceProduct price;
  DeliveryProduct delivery;

  String? link;

  SubCategory subCategory;
  Shop shop;
  StateProduct state;

  List images;
  List sizes;
  List colors;

  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  // 🆕 Champs pour clic25
  bool isWinningProduct;
  int? winningBonusAmount;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.alias,
    this.subTitle,
    this.description,
    required this.subCategoryId,
    required this.stateId,
    required this.star,
    required this.popular,
    required this.stock,
    required this.unavailable,
    required this.invisible,
    this.priceSupplier,
    this.reducedPrice,
    required this.price,
    required this.delivery,
    required this.subCategory,
    this.link,
    required this.state,
    required this.shop,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
    //Ajout de champs pour clic25  🆕
    required this.isWinningProduct,
    this.winningBonusAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'alias': alias,
      // 'description': description,
      // 'subTitle': subTitle,
      'subCategoryId': subCategoryId,
      'stateId': stateId,
      'star': star,
      'popular': popular,
      'stock': stock,
      'unavailable': unavailable,
      'invisible': invisible,
      'priceSupplier': priceSupplier,
      'reducedPrice': reducedPrice,
      'price': price
          .toJson(), // Assurez-vous que PriceProduct possède aussi une méthode toJson
      'delivery': delivery
          .toJson(), // Assurez-vous que DeliveryProduct possède aussi une méthode toJson
      'link': link,
      'subCategory': subCategory
          .toJson(), // Assurez-vous que SubCategory possède aussi une méthode toJson
      'shop': shop
          .toJson(), // Assurez-vous que Shop possède aussi une méthode toJson
      'state': state
          .toJson(), // Assurez-vous que StateProduct possède aussi une méthode toJson
      'images':
          images, // Assurez-vous que les éléments de la liste sont déjà au format JSON si nécessaires
      'sizes': sizes,
      'colors': colors,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdAtFr': createdAtFr,
      'updatedAtFr': updatedAtFr,
      // 🆕
      'is_winning_product': isWinningProduct,
      'winning_bonus_amount': winningBonusAmount,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    // print("images ${json['images']}");
    return Product(
      id: json['id'] ?? 0,
      shop: Shop.fromJson(json['shop']),
      name: json['name'] ?? '',
      type: json['category'] ?? '',
      description: json['description'] ?? '',
      subTitle: json['sub_title'] ?? '',
      alias: json['alias'] ?? '',
      subCategoryId: json['sub_category']['id'] ?? 0,
      stateId: json['state']['id'] ?? 0,
      star: json['star'] ?? 0,
      popular: json['popular'] ?? 0,
      stock: json['stock'] ?? 0,
      unavailable: json['unavailable'] ?? 0,
      invisible: json['invisible'] ?? 0,
      link: json['link'] ?? '',
      price: PriceProduct.fromJson(json['price']),
      delivery: DeliveryProduct.fromJson(json['price_delivery']),
      subCategory: SubCategory.fromJson(json['sub_category']),
      state: StateProduct.fromJson(json['state']),
      images: json['images'],
      sizes: json['sizes'] != null ? (json['sizes'] as List) : [],
      colors: json['colors'] != null ? (json['colors'] as List) : [],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAtFr: json['created_at_fr'] ?? '',
      updatedAtFr: json['updated_at_fr'] ?? '',
      // 🆕
      isWinningProduct: json['is_winning_product'] ?? false,
      winningBonusAmount: json['winning_bonus_amount'],
    );
  }
}

class ImgProduct {
  int id;
  String img;

  ImgProduct({
    required this.id,
    required this.img,
  });

  factory ImgProduct.fromJson(Map<String, dynamic> json) {
    return ImgProduct(
      id: json['id'],
      img: json['picture_path'],
    );
  }
}

class SizeProduct {
  int id;
  String size;

  SizeProduct({
    required this.id,
    required this.size,
  });

  factory SizeProduct.fromJson(Map<String, dynamic> json) {
    return SizeProduct(
      id: json['id'],
      size: json['size'],
    );
  }
}

class ColorProduct {
  int id;
  String name;
  String color;

  ColorProduct({
    required this.id,
    required this.name,
    required this.color,
  });

  factory ColorProduct.fromJson(Map<String, dynamic> json) {
    return ColorProduct(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}

class PriceProduct {
  int price;
  int partner;
  int supplier;
  int seller;
  int max;
  int min;
  int commission;
  int normal;

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'commission': commission,
    };
  }

  PriceProduct({
    required this.price,
    required this.partner,
    required this.supplier,
    required this.seller,
    required this.max,
    required this.min,
    required this.commission,
    required this.normal,
  });

  factory PriceProduct.fromJson(Map<String, dynamic> json) {
    return PriceProduct(
      price: json['price'] ?? 0,
      partner: json['partner'] ?? 0,
      supplier: json['supplier'] ?? 0,
      seller: json['seller'] ?? 0,
      max: json['max'] ?? 0,
      min: json['min'] ?? 0,
      commission: json['commission'] ?? 0,
      normal: json['normal'] ?? 0,
    );
  }
}

class DeliveryProduct {
  int city;
  int noCity;

  DeliveryProduct({
    required this.city,
    required this.noCity,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'noCity': noCity,
    };
  }

  factory DeliveryProduct.fromJson(Map<String, dynamic> json) {
    return DeliveryProduct(
      city: json['city'] ?? 0,
      noCity: json['no_city'] ?? 0,
    );
  }
}
