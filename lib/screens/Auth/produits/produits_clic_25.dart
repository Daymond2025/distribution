import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/screens/newscreens/articleComp/winning_product_card.dart';

class ProduitsClic25Screen extends StatefulWidget {
  const ProduitsClic25Screen({super.key});

  @override
  State<ProduitsClic25Screen> createState() => _ProduitsClic25ScreenState();
}

class _ProduitsClic25ScreenState extends State<ProduitsClic25Screen> {
  final ProductService productService = ProductService();

  List<Product> _products = [];
  bool _loading = true;
  bool isLoadingMore = false;

  int currentPage = 1;
  int lastPage = 1;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchWinning();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 150 &&
          !isLoadingMore &&
          currentPage < lastPage) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchWinning({bool refresh = false}) async {
    if (refresh) {
      setState(() {
        _loading = true;
        _products.clear();
        currentPage = 1;
      });
    }

    ApiResponse response =
        await productService.getWinningProducts(page: currentPage);

    if (response.error == null) {
      var data = response.data as Map<String, dynamic>;
      List<Product> fetched = data["products"];
      currentPage = data["currentPage"];
      lastPage = data["lastPage"];

      setState(() {
        if (refresh) {
          _products = fetched;
        } else {
          _products.addAll(fetched);
        }
      });
    } else if (response.error == unauthorized) {
      logout().then((_) {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      });
    } else {
      print("[FETCH] Erreur lors du fetch: ${response.error}");
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadMore() async {
    if (currentPage >= lastPage) return;
    setState(() => isLoadingMore = true);
    currentPage++;
    await _fetchWinning();
    setState(() => isLoadingMore = false);
  }

  Future<void> _refresh() async {
    await _fetchWinning(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      body: Column(
        children: [
          // ===== NOUVELLE BANNIÈRE =====
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: 95, // tu peux ajuster si nécessaire
              child: Stack(
                children: [
                  // Image unique de la bannière
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/nouvelle_banniere1.png", // ton image complète
                      fit: BoxFit
                          .cover, // ou BoxFit.fill selon le rendu souhaité
                    ),
                  ),

                  // Bouton retour au-dessus
                  Positioned(
                    left: 5,
                    top: 10,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 28),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== LISTE PRODUITS OU MESSAGE =====
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _loading
                  ? produitLoading(4)
                  : _products.isEmpty
                      ? const Center(
                          child: Text("Aucun produit pour le moment"),
                        )
                      : SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              ProductWidget(products: _products),
                              if (isLoadingMore) produitLoading(2),
                            ],
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====== Widgets utilitaires ======

Widget produitLoading(int elements) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 280,
      ),
      itemCount: elements,
      itemBuilder: (_, __) => produitLoadingCard3x3(),
    ),
  );
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: -0, bottom: 10, left: 8, right: 8),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 280,
          ),
          itemCount: products.length,
          itemBuilder: (_, index) {
            return WinningProductCard(
              product: products[index],
            );
          },
        ),
      ),
    );
  }
}
