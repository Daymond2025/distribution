import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchR extends StatefulWidget {
  const SearchR({super.key});

  @override
  State<SearchR> createState() => _SearchRState();
}

class _SearchRState extends State<SearchR> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  ProductService productService = ProductService();
  List<Product> _products = [];
  List<String> _aliasSuggestions = [];
  bool _loading = false;

  // Fetches alias suggestions based on input
  Future<void> _fetchAliases(String query) async {
    if (query.length < 2) return; // Show suggestions only after 2 characters
    ApiResponse response = await productService.aliasProducts(query);
    if (response.error == null) {
      setState(() => _aliasSuggestions = response.data as List<String>);
    }
  }

  // Search products only when search button is pressed
  Future<void> _searchProducts(String query) async {
    setState(() => _loading = true);
    ApiResponse response = await productService.products('search=$query');
    if (response.error == null) {
      setState(() {
        _products = response.data as List<Product>;
        _loading = false;
        _aliasSuggestions = []; // Clear suggestions after search
      });
    } else {
      setState(() => _loading = false);
      _showErrorAlert(response.error ?? "Erreur lors de la recherche.");
    }
  }

  // Executes search when search button is pressed
  void _onSearchPressed() {
    if (_searchController.text.isNotEmpty) {
      _searchProducts(_searchController.text);
      _focusNode.unfocus();
    }
  }

  // Selects an alias for search
  void _onAliasSelected(String alias) {
    _searchController.text = alias;
    _focusNode.unfocus();
    _searchProducts(alias);
  }

  // Shows an error alert
  void _showErrorAlert(String message) {
    Alert(
      context: context,
      type: AlertType.error,
      title: message,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Recherche de produits"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field with button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Recherche de produits...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: _fetchAliases,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearchPressed,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Alias suggestions
            if (_aliasSuggestions.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _aliasSuggestions.map((alias) {
                    return ListTile(
                      title: Text(alias),
                      onTap: () => _onAliasSelected(alias),
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 16),

            // Display search results
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _products.isEmpty
                      ? const Center(child: Text("Aucun produit trouvé"))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 280,
                          ),
                          itemCount: _products.length,
                          itemBuilder: (_, index) {
                            final product = _products[index];
                            return produitsCard(
                              context,
                              product,
                              product.id,
                              product.name,
                              product.price.price,
                              product.price.normal,
                              product.state.name,
                              product.star,
                              product.images.isEmpty
                                  ? imgProdDefault
                                  : product.images[0],
                              product.stock,
                              product.unavailable,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
