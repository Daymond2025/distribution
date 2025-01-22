
import 'package:distribution_frontend/models/seller.dart';

class PublishStar {
  int id;
  String type;
  String status;
  Seller seller;
  String picturePath;
  int nbStar;
  int nbView;

  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  PublishStar({
    required this.id,
    required this.type,
    required this.status,
    required this.seller,
    required this.picturePath,
    required this.nbStar,
    required this.nbView,

    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory PublishStar.fromJson(Map<String, dynamic> json) {
    return PublishStar(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      seller: Seller.fromJson(json['seller']),
      picturePath: json['picture_path'],
      nbStar: json['nb_star'],
      nbView: json['nb_view'],

      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'seller': seller,
      'picture_path': picturePath,
      'nb_etoile': nbStar,
      'nb_vue': nbView,
    };
  }
}
