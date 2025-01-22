import 'package:distribution_frontend/models/city.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/seller.dart';

class Order {
  final int id;
  final String person;
  final String reference;
  final String? detail;
  final int stars;
  final String status;
  final int returned;

  final Seller seller;
  final Client client;
  final List<OrderProduct> items;

  final Delivery delivery;
  // final Expedition expedition;
  // final AfterExpedition afterExpedition;

  final OrderStatusDetail? canceled;
  final OrderStatusDetail? received;
  final OrderStatusDetail? validated;
  final OrderStatusDetail? postponed;
  final OrderStatusDetail? dontPickUp;
  final OrderStatusDetail? pending;
  final OrderStatusDetail? inProgress;
  final OrderStatusDetail? confirmed;

  final String createdAt;
  final String updatedAt;

  final String createdAtFr;
  final String updatedAtFr;

  Order({
    required this.id,
    required this.person,
    required this.reference,
    this.detail,
    required this.stars,
    required this.status,
    required this.returned,
    required this.seller,
    required this.client,
    required this.items,
    required this.delivery,
    // required this.expedition,
    // required this.afterExpedition,
    this.canceled,
    this.received,
    this.validated,
    this.postponed,
    this.dontPickUp,
    this.pending,
    this.inProgress,
    this.confirmed,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      person: json['person'],
      reference: json['reference'],
      detail: json['detail'],
      stars: json['stars'],
      status: json['status'],
      returned: json['returned'] ?? '',
      seller: Seller.fromJson(json['seller']),
      client: Client.fromJson(json['client']),
      items: (json['items'] as List)
          .map((item) => OrderProduct.fromJson(item))
          .toList(),
      delivery: Delivery.fromJson(json['delivery']),
      // expedition: Expedition.fromJson(json['expedition']),
      // afterExpedition: AfterExpedition.fromJson(json['after_expedition']),
      canceled: json['canceled'] != null
          ? OrderStatusDetail.fromJson(json['canceled'])
          : null,
      received: json['received'] != null
          ? OrderStatusDetail.fromJson(json['received'])
          : null,
      validated: json['validated'] != null
          ? OrderStatusDetail.fromJson(json['validated'])
          : null,
      postponed: json['postponed'] != null
          ? OrderStatusDetail.fromJson(json['postponed'])
          : null,
      dontPickUp: json['dont_pick_up'] != null
          ? OrderStatusDetail.fromJson(json['dont_pick_up'])
          : null,
      pending: json['pending'] != null
          ? OrderStatusDetail.fromJson(json['pending'])
          : null,
      inProgress: json['in_progress'] != null
          ? OrderStatusDetail.fromJson(json['in_progress'])
          : null,
      confirmed: json['confirmed'] != null
          ? OrderStatusDetail.fromJson(json['confirmed'])
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  // Méthode toJson pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderProduct {
  final String reference;
  final int star;
  final int price;
  final int quantity;
  final int fees;
  final String? size;
  final String? color;
  final Product product;

  final String status;

  final int percentage;
  final int orderCommission;
  final int sellerCommission;
  final int recruiterCommission;

  //final Payment? payment;
  final OrderStatusDetail? canceled;
  final OrderStatusDetail? validated;
  final OrderStatusDetail? refund;

  final int totalProduct;
  final int totalFees;
  final int total;

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'price': price,
    };
  }

  OrderProduct({
    required this.reference,
    required this.star,
    required this.price,
    required this.quantity,
    required this.fees,
    this.size,
    this.color,
    required this.product,
    required this.status,
    required this.percentage,
    required this.orderCommission,
    required this.sellerCommission,
    required this.recruiterCommission,
    //this.payment,
    this.canceled,
    this.validated,
    this.refund,
    required this.totalProduct,
    required this.totalFees,
    required this.total,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      reference: json['reference'],
      star: json['star'] ?? 0,
      price: json['price'] ?? 0,
      quantity: json['quantity'],
      fees: json['fees'],
      size: json['size'],
      color: json['color'],
      product: Product.fromJson(json['product']),
      status: json['status'],
      percentage: json['percentage'] ?? 0,
      orderCommission: json['order_commission'],
      sellerCommission: json['seller_commission'],
      recruiterCommission: json['recruiter_commission'],
      //payment:json['payment'] != '0' ? Payment.fromJson(json['payment']) : '0',
      canceled: json['canceled'] != null
          ? OrderStatusDetail.fromJson(json['canceled'])
          : null,
      validated: json['validated'] != null
          ? OrderStatusDetail.fromJson(json['validated'])
          : null,
      refund: json['refund'] != null
          ? OrderStatusDetail.fromJson(json['refund'])
          : null,
      totalProduct: json['total_product'],
      totalFees: json['total_fees'],
      total: json['total'],
    );
  }
}

class Client {
  final String name;
  final String phoneNumber;
  final String? phoneNumber2;

  Client({
    required this.name,
    required this.phoneNumber,
    this.phoneNumber2,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'],
      phoneNumber: json['phone_number'],
      phoneNumber2: json['phone_number_2'],
    );
  }
}

class Delivery {
  final String date;
  final String time;
  final City city;

  Delivery({
    required this.date,
    required this.time,
    required this.city,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      date: json['date'],
      time: json['time'],
      city: City.fromJson(json['city']),
    );
  }
}

class Payment {
  final String? reason;
  final String? date;
  final String? time;

  Payment({
    this.reason,
    this.date,
    this.time,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      reason: json['reason'],
      date: json['date'],
      time: json['time'],
    );
  }
}

class OrderStatusDetail {
  final String? reason;
  final String? date;
  final String? time;

  OrderStatusDetail({
    this.reason,
    this.date,
    this.time,
  });

  factory OrderStatusDetail.fromJson(Map<String, dynamic> json) {
    return OrderStatusDetail(
      reason: json['reason'],
      date: json['date'],
      time: json['time'],
    );
  }
}
