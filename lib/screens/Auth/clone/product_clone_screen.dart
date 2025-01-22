import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ProductCloneScreen extends StatelessWidget {
  const ProductCloneScreen({super.key, required this.clone});
  final CloneProduct clone;

  // Fonction pour copier le lien du produit dans le presse-papiers
  Future<void> _copyLink(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: clone.url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lien copié dans le presse-papiers!')),
    );
  }

  // Fonction pour partager le lien du produit
  void _shareLink() {
    Share.share(clone.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du produit'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: colorblack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du produit
              Image.network(
                clone.product.images[0],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),

              // Nom du produit
              Text(
                clone.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (clone.subTitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  clone.subTitle!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
              const SizedBox(height: 8),

              // Prix du produit
              Row(
                children: [
                  Text(
                    "${formatAmount(clone.price)} CFA",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${clone.price + 3000} CFA",
                    style: const TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Infos sur la livraison
              const Text(
                "Livraison express:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Livraison ${clone.product.shop.city.name}: ${clone.product.delivery.city} CFA - Hors ${clone.product.shop.city.name}: ${clone.product.delivery.noCity} CFA",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Condition du produit
              Text(
                "État du produit: ${clone.product.state.name.toUpperCase()}",
                style: const TextStyle(fontSize: 16, color: Colors.orange),
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                "Description:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                clone.description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _copyLink(context),
                      icon: const Icon(Icons.copy_all),
                      label: const Text('Copier'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClickProduit(
                              product: clone.product,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Produit'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
