import 'package:distribution_frontend/models/seller.dart';

class Wallet {
  int id;
  int totalAmount;
  int amount;
  int soldeEnAttente;
  int soldeDisponible;
  int totalGagne;
  Seller entity;

  Wallet({
    required this.id,
    required this.totalAmount,
    required this.amount,
    required this.entity,
    this.soldeEnAttente = 0,
    this.soldeDisponible = 0,
    this.totalGagne = 0,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      amount: json['amount'] ?? 0,
      entity: Seller.fromJson(json['entity']),
      soldeEnAttente: json['winning_wallet']?['solde_en_attente'] ?? 0,
      soldeDisponible: json['winning_wallet']?['solde_disponible'] ?? 0,
      totalGagne: json['winning_wallet']?['total_gagne'] ?? 0,
    );
  }
}


//class Wallet {
  //int id;
  //int totalAmount;
  //int amount;
  //Seller entity;

  // 🆕 champs pour produits gagnants
  //int soldeDisponible;
  //int soldeEnAttente;
  //int totalGagne;

  //Wallet({
    //required this.id,
    //required this.totalAmount,
    //required this.amount,
    //required this.entity,
    //this.soldeDisponible = 0,
    //this.soldeEnAttente = 0,
    //this.totalGagne = 0,
  //});

  //factory Wallet.fromJson(Map<String, dynamic> json) {
    //return Wallet(
      //id: json['id'] ?? 0,
      //totalAmount: json['total_amount'] ?? 0,
      //amount: json['amount'] ?? 0,
      //entity: Seller.fromJson(json['entity']),

      // 🆕 si winning_wallet existe dans la réponse API
      //soldeDisponible: json['winning_wallet']?['solde_disponible'] ?? 0,
      //soldeEnAttente: json['winning_wallet']?['solde_en_attente'] ?? 0,
      //totalGagne: json['winning_wallet']?['total_gagne'] ?? 0,
    //);
  //}
//}
