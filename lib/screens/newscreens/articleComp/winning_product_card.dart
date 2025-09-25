// winning_product_card.dart
import 'package:flutter/material.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:share_plus/share_plus.dart'; // pour partager
import 'package:flutter/services.dart'; // pour copier
import 'dart:async';
import 'dart:io';
//import 'package:distribution_frontend/screens/newscreens/persoComp/perso_comp_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:distribution_frontend/models/product.dart';

import 'article_comp_model.dart';
export 'article_comp_model.dart';

Future<void> handleCloneAndCopyLink(
    BuildContext context, Product product) async {
  final response = await CloneProductService().cloneAndCopyLink(
    productId: product.id ?? 0,
    title: product.name ?? '',
    subTitle: product.subTitle ?? '',
    description: product.description ?? '',
    price: product.price.price, // int ou double
    commission: product.price.commission ?? 0,
    // 🆕 champs obligatoires
    isWinningProduct: product.isWinningProduct ?? false,
    winningBonusAmount: product.winningBonusAmount ?? 0,
  );

  if (response.error == null && response.data != null) {
    final link = response.data as String;

    // on stocke dans le product
    product.link = link;

    Fluttertoast.showToast(
      msg: "Lien copié dans le presse-papiers !",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      textColor: Colors.white,
    );

    print("🔗 [HANDLE] Lien enregistré dans product.link = $link");
  } else {
    Fluttertoast.showToast(
      msg: "Erreur : ${response.error}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }
}

Future<void> handleShareProduct(BuildContext context, Product product) async {
  // si le lien est déjà connu, on partage direct
  if (product.link != null && product.link!.isNotEmpty) {
    Share.share("Découvre ce produit : ${product.link}");
    return;
  }

  // sinon on clone d'abord
  final response = await CloneProductService().cloneAndCopyLink(
    productId: product.id ?? 0,
    title: product.name ?? '',
    subTitle: product.subTitle ?? '',
    description: product.description ?? '',
    price: product.price.price,
    commission: product.price.commission ?? 0,
    isWinningProduct: product.isWinningProduct ?? false,
    winningBonusAmount: product.winningBonusAmount ?? 0,
  );

  if (response.error == null && response.data != null) {
    final link = response.data as String;
    product.link = link;

    Share.share("🔥 Découvre ce produit : $link");
    print("🔗 [SHARE] Produit partagé avec lien = $link");
  } else {
    Fluttertoast.showToast(msg: "Impossible de générer un lien à partager");
  }
}

/// --- POPUP SPÉCIAL POUR PRODUITS GAGNANTS ---
Future<void> showClicPopup(BuildContext context, Product product) async {
  final String linkToDisplay = (product.link ?? '').trim();
  print("POPUP PRODUCT LINK = ${product.link}");

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF9700), width: 1),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Texte principal
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Tu gagnes ",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const TextSpan(
                      text: "25 FCFA",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                    const TextSpan(
                      text: " pour chaque personne qui ",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const TextSpan(
                      text: "clic",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                    const TextSpan(
                      text: " sur le lien de ce produit.",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 1),

              // ===== NOUVELLE IMAGE UNIQUE =====
              SizedBox(
                width: 300, // ajuste si nécessaire
                height: 120, // ajuste si nécessaire
                child: Image.asset(
                  "assets/images/nouvelle_banniere_bloc.png", // ton image finale
                  fit: BoxFit.contain, // ou BoxFit.cover si tu veux remplir
                ),
              ),

              const SizedBox(height: 2),

              // Rectangle + lien
              // Container(
              // width: double.infinity,
              // padding:
              // const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              // decoration: BoxDecoration(
              // border: Border.all(color: const Color(0xFFFF9700)),
              // borderRadius: BorderRadius.circular(6),
              // ),
              // child: linkToDisplay.isNotEmpty
              // ? SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              // child: Text(
              // linkToDisplay,
              // style: const TextStyle(
              // fontFamily: "Segoe UI",
              // fontSize: 14,
              // fontWeight: FontWeight.w400,
              // color: Colors.blue,
              // ),
              // ),
              // )
              // : const Text(
              // "Lien indisponible",
              // style: TextStyle(
              // fontSize: 14,
              // fontWeight: FontWeight.w400,
              // color: Colors.grey,
              // ),
              // ),
              // ),

              const SizedBox(height: 2),

              // Boutons action
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFFFF9700),
                            width: 1), // border-width: 1
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(19), // border-radius: 19px
                        ),
                        minimumSize:
                            const Size(131, 34), // largeur & hauteur réelles
                        padding: EdgeInsets
                            .zero, // on laisse le minimumSize gérer la taille
                      ),
                      onPressed: () async {
                        await handleCloneAndCopyLink(context, product);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Copier le lien",
                        style: TextStyle(
                          color: Color(0xFFFF9000),
                          fontSize: 12,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9000),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(19), // border-radius: 19px
                        ),
                        minimumSize:
                            const Size(131, 34), // largeur & hauteur réelles
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () => handleShareProduct(context, product),
                      child: const Text(
                        "Partager le lien",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

/// --- CARTE PRODUIT GAGNANT ---
class WinningProductCard extends StatelessWidget {
  final Product product;
  const WinningProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image produit + état + étoile
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  product.images.isEmpty ? imgProdDefault : product.images[0],
                  height: 145,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Badge état en haut à gauche
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC000),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    product.state.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Icône étoile en haut à droite
              Positioned(
                top: -0,
                right: -0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(97, 0, 0, 0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 217, 0),
                    size: 10,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Nom du produit
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF707070),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          // Prix
          Text(
            "${product.price.price} FCFA",
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // Texte "Tu gagnes X FCFA / clic"
          Text(
            "Tu gagnes ${product.winningBonusAmount ?? 25} Fr par clic",
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 144, 0),
              letterSpacing: 0.0,
            ),
          ),

          const Spacer(),

          SizedBox(
            width: 154, // largeur maquette
            height: 25, // hauteur maquette
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9000),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(2), // border-radius maquette
                ),
                padding: EdgeInsets
                    .zero, // padding par défaut pour coller exactement à la hauteur
              ),
              onPressed: () => showClicPopup(context, product),
              child: const Text(
                "Partager le lien",
                style: TextStyle(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 12,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
