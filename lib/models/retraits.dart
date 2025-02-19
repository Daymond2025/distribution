class Retrait {
  int id;
  String? reference;
  double montant;
  String operateur;
  String telephone;
  int idUser;
  int? idAdmin;
  String statut;
  String? remarque;
  String createdAt;
  String updatedAt;

  Retrait({
    required this.id,
    this.reference,
    required this.montant,
    required this.operateur,
    required this.telephone,
    required this.idUser,
    this.idAdmin,
    required this.statut,
    this.remarque,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertit un JSON en objet Retrait
  factory Retrait.fromJson(Map<String, dynamic> json) {
    return Retrait(
      id: json['id'],
      reference: json['reference'],
      montant: double.parse(json['montant']),
      operateur: json['operateur'],
      telephone: json['telephone'],
      idUser: json['id_user'],
      idAdmin: json['id_admin'],
      statut: json['statut'],
      remarque: json['remarque'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convertit un objet Retrait en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'montant': montant,
      'operateur': operateur,
      'telephone': telephone,
      'id_user': idUser,
      'id_admin': idAdmin,
      'statut': statut,
      'remarque': remarque,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
