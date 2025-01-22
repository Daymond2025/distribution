
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/publish_star.dart';

class NotificationS {
  String type;
  String name;
  String? picturePath;
  String? detail;
  OrderDetailNotification? orderDetail;
  ProductDetailNotification? productDetail;
  PublishStar? publishStar;
  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  NotificationS({
    required this.type,
    required this.name,
    this.picturePath,
    this.detail,
    this.orderDetail,
    this.productDetail,
    this.publishStar,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory NotificationS.fromJson(Map<String, dynamic> json) {
    return NotificationS(
      type: json['type'],
      name: json['name'],
      picturePath: json['picture_path'] ?? '',
      detail: json['detail'],
      orderDetail: json['order_detail'] != null
          ? OrderDetailNotification.fromJson(json['order_detail'])
          : null,
      productDetail: json['product_detail'] != null
          ? ProductDetailNotification.fromJson(json['product_detail'])
          : null,
      publishStar: json['publish_star'] != null
          ? PublishStar.fromJson(json['publish_star'])
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  // Method to convert a Notification object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'picture_path': picturePath,
      'detail': detail,
      'order_detail': orderDetail?.toJson(),
      'product_detail': productDetail?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}

class OrderDetailNotification {
  Order order;
  String status;
  String date;
  String dateFr;
  String time;

  OrderDetailNotification({
    required this.order,
    required this.status,
    required this.date,
    required this.dateFr,
    required this.time,
  });

  factory OrderDetailNotification.fromJson(Map<String, dynamic> json) {
    return OrderDetailNotification(
      order: Order.fromJson(json['order']),
      status: json['status'],
      date: json['date'],
      dateFr: json['date_fr'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'status': status,
      'date': date,
      'date_fr': dateFr,
      'time': time,
    };
  }
}

class ProductDetailNotification {
  Product product;
  int quantity;

  ProductDetailNotification({
    required this.product,
    required this.quantity,
  });

  factory ProductDetailNotification.fromJson(Map<String, dynamic> json) {
    return ProductDetailNotification(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }
}
