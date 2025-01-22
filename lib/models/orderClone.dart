class OrderClone {
  final int orderId;
  final DateTime orderDate;
  final String status;
  final String reference;
  final DateTime deliveryDate;
  final String deliveryTime;
  final String customerName;
  final String customerPhone;
  final int productCloneId;
  final String? productCloneReference;
  final String productCloneTitle;
  final double productClonePrice;

  OrderClone({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.reference,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.customerName,
    required this.customerPhone,
    required this.productCloneId,
    this.productCloneReference,
    required this.productCloneTitle,
    required this.productClonePrice,
  });

  // Factory method pour créer une instance à partir d'une Map (JSON)
  factory OrderClone.fromJson(Map<String, dynamic> json) {
    return OrderClone(
      orderId: json['order_id'],
      orderDate: DateTime.parse(json['order_date']),
      status: json['status'],
      reference: json['reference'],
      deliveryDate: DateTime.parse(json['delivery_date']),
      deliveryTime: json['delivery_time'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      productCloneId: json['product_clone_id'],
      productCloneReference: json['product_clone_reference'],
      productCloneTitle: json['product_clone_title'],
      productClonePrice: json['product_clone_price'].toDouble(),
    );
  }

  // Méthode pour convertir une instance en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_date': orderDate.toIso8601String(),
      'status': status,
      'reference': reference,
      'delivery_date': deliveryDate.toIso8601String().split('T').first,
      'delivery_time': deliveryTime,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'product_clone_id': productCloneId,
      'product_clone_reference': productCloneReference,
      'product_clone_title': productCloneTitle,
      'product_clone_price': productClonePrice,
    };
  }
}
