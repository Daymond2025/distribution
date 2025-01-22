import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/seller.dart';

class Conversation {
  final int id;
  final Profile profile;
  final String person;
  final Seller seller;
  final bool isNew;
  final List<Message> messages;
  final String? lastMessage;
  final String updatedAt;
  final String updatedAtFr;

  Conversation({
    required this.id,
    required this.profile,
    required this.person,
    required this.seller,
    required this.isNew,
    required this.messages,
    this.lastMessage,
    required this.updatedAt,
    required this.updatedAtFr,
  });

  factory Conversation.fromJsonConversation(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      profile: Profile.fromJson(json['message_profile']),
      person: json['person'],
      seller: Seller.fromJson(json['person_data']),
      isNew: json['new'],
      messages: [],
      lastMessage: json['last_message'],
      updatedAt: json['updated_at'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      profile: Profile.fromJson(json['message_profile']),
      person: json['person'],
      seller: Seller.fromJson(json['person_data']),
      isNew: json['new'],
      messages: (json['messages'] as List<dynamic>).map((messageJson) => Message.fromJson(messageJson)).toList(),
      updatedAt: json['updated_at'],
      updatedAtFr: json['updated_at_fr'],
    );
  }
}

class Message {
  final int id;
  final String message;
  final String updatedAt;
  final String updatedAtFr;
  final String person;
  final dynamic personData;
  final String category;
  final dynamic categoryData;

  Message({
    required this.id,
    required this.message,
    required this.updatedAt,
    required this.updatedAtFr,
    required this.person,
    required this.personData,
    required this.category,
    this.categoryData,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      updatedAt: json['updated_at'],
      updatedAtFr: json['updated_at_fr'],
      person: json['person'],
      personData: json['person'] == 'seller' ? Seller.fromJson(json['person_data']) : Profile.fromJson(json['person_data']),
      category: json['category'],
      categoryData: json['category'] == MESSAGE_ORDER
          ? Order.fromJson(json['category_data'])
          : json['category'] == MESSAGE_PRODUCT
            ? Product.fromJson(json['category_data'])
            : null,
    );
  }
}

class Profile {
  final int id;
  final String name;
  final String? picturePath;
  final String role;
  final String status;

  Profile({
    required this.id,
    required this.name,
    this.picturePath,
    required this.role,
    required this.status,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      picturePath: json['picture_path'],
      role: json['role'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'picture_path': picturePath,
      'role': role,
      'status': status,
    };
  }
}
