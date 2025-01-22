
import 'package:distribution_frontend/models/notification.dart';

class NotificationView {
  int id;
  NotificationS notification;
  bool view;
  bool delete;
  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  NotificationView({
    required this.id,
    required this.notification,
    required this.view,
    required this.delete,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory NotificationView.fromJson(Map<String, dynamic> json) {
    return NotificationView(
      id: json['id'],
      notification: NotificationS.fromJson(json['notification']),
      view: json['view'],
      delete: json['delete'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notification': notification.toJson(),
      'view': view,
      'delete': delete,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}
