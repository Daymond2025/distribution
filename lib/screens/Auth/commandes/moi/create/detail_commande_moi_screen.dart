import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/create/formulaire_commande_moi_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailCommandeMoiScreen extends StatefulWidget {
  const DetailCommandeMoiScreen({
    super.key,
    required this.product,
    required this.category,
  });

  final String category;
  final Product product;

  @override
  State<DetailCommandeMoiScreen> createState() =>
      _DetailCommandeMoiScreenState();
}

class _DetailCommandeMoiScreenState extends State<DetailCommandeMoiScreen> {
  int _nbcmd = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(53.0),
        child: AppBar(
          leadingWidth: 40,
          backgroundColor: colorwhite,
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.16),
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          title: const Text(
            'Offre spéciale',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Carte d'informations du produit avec image, nom et quantité
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 8),
            width: MediaQuery.of(context).size.width,
            height: 161,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: colorwhite,
            ),
            child: Stack(
              children: [
                // Image principale du produit
                Positioned(
                  left: 20.5,
                  top: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.product.images[0],
                      height: 93,
                      width: 92,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Badge "NEUF" avec icône étoile
                Positioned(
                  right: 10.5,
                  top: 10,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: colorYellow,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 65,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFC000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17),
                            bottomLeft: Radius.circular(7),
                            topRight: Radius.circular(17),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'NEUF',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: colorblack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Nom du produit
                Positioned(
                  left: 136,
                  top: 40,
                  child: SizedBox(
                    width: 211,
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: colorblack,
                        height: 1.05,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                // Contrôle de sélection de la quantité
                Positioned(
                  left: 135,
                  top: 100,
                  child: Row(
                    children: [
                      const Text(
                        'Quantité du produit',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Bouton de décrémentation
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_nbcmd != 1) {
                              _nbcmd = _nbcmd - 1;
                            }
                          });
                        },
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: const Color(0xFFECF0F3),
                            border: Border.all(color: const Color(0xFFECF0F3)),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '−',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: colorblack,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        child: Text(
                          _nbcmd.toString(),
                          style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colorblack,
                          ),
                        ),
                      ),
                      // Bouton d'incrémentation
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _nbcmd = _nbcmd + 1;
                          });
                        },
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: colorYellow2,
                            border: Border.all(color: colorYellow2),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: colorwhite,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Ligne de séparation
                Positioned(
                  left: 24.5,
                  right: 24.5,
                  top: 130, // Espace ajouté entre quantité et trait
                  child: Container(
                    height: 2,
                    color: const Color(0xFFECF0F3),
                  ),
                ),

                // Prix de vente
                Positioned(
                  left: 20.5,
                  top:
                      140, // Positionné sous la ligne de séparation avec espacement
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF707070),
                      ),
                      children: [
                        const TextSpan(text: 'Prix de vente chez daymond: '),
                        TextSpan(
                          text:
                              '${NumberFormat("###,###", 'en_US').format(widget.product.price.price).replaceAll(',', ' ')} FCFA',
                          style: const TextStyle(
                            color: colorBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Carte détaillant la réduction et les calculs de prix
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 8),
            width: MediaQuery.of(context).size.width,
            height: 545,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: colorwhite,
            ),
            child: Stack(
              children: [
                // Icône cadeau de la réduction
                Positioned(
                  left: 0,
                  right: 0,
                  top: 40,
                  child: Center(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/kdo.png',
                        width: 112,
                        height: 112,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Message de félicitations avec effet de gradient
                Positioned(
                  left: 52,
                  top: 170,
                  width: 334,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFF022C7), Color(0xFF1050FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.31,
                        ),
                        children: [
                          const TextSpan(
                              text:
                                  'Félicitation M. Michael Kouamé Daymond Vous offre\nun bons de réduction d\'une valeur de '),
                          TextSpan(
                            text:
                                '${NumberFormat("###,###", 'en_US').format(widget.product.price.price - widget.product.price.seller).replaceAll(',', ' ')} FCFA',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: ' sur le produit'),
                        ],
                      ),
                    ),
                  ),
                ),

                // Prix après application de la réduction
                Positioned(
                  left: 37.5,
                  right: 37.5,
                  top: 240,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Prix après réduction du bons :',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF707070),
                        ),
                      ),
                      Text(
                        '${NumberFormat("###,###", 'en_US').format(widget.product.price.seller * _nbcmd).replaceAll(',', ' ')} FCFA',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colorBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                // Frais de livraison selon la ville
                Positioned(
                  left: 37.5,
                  right: 37.5,
                  top: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Frais de Livraison a ${widget.product.shop.city.name} :',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF707070),
                        ),
                      ),
                      Text(
                        '${NumberFormat("###,###", 'en_US').format(widget.product.delivery.city * _nbcmd).replaceAll(',', ' ')} FCFA',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colorBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                // Ligne de séparation avant le total
                Positioned(
                  left: 27,
                  right: 27,
                  top: 310,
                  child: Container(
                    height: 2,
                    color: const Color(0xFFECF0F3),
                  ),
                ),

                // Affichage du montant total avec gradient
                Positioned(
                  left: 37.5,
                  top: 320,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      const SizedBox(width: 200),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFF022C7), Color(0xFF1050FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Text(
                          '${NumberFormat("###,###", 'en_US').format((widget.product.price.seller + widget.product.delivery.city) * _nbcmd).replaceAll(',', ' ')} FCFA',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Message indiquant le montant économisé
                Positioned(
                  left: 98,
                  top: 480,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFF022C7), Color(0xFF1050FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      'Vous économiser au total ${NumberFormat("###,###", 'en_US').format((widget.product.price.price - widget.product.price.seller) * _nbcmd).replaceAll(',', ' ')} FCFA',
                      style: const TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: colorfond,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          // TODO: Vérifier la disponibilité du produit via API avant navigation
          // En attente d'endpoint : GET /api/products/{productId}/availability
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulaireCommandeMoiScreen(
                qte: _nbcmd,
                product: widget.product,
              ),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: MediaQuery.of(context).size.width,
            height: 43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: colorYellow2,
            ),
            child: const Text(
              'JE VALIDE',
              style: TextStyle(
                fontFamily: 'Inter',
                color: colorwhite,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
