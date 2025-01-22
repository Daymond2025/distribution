import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class ProduitsCategorieScreen extends StatefulWidget {
  const ProduitsCategorieScreen(
      {super.key, required this.id, required this.name});
  final int id;
  final String name;
  @override
  State<ProduitsCategorieScreen> createState() =>
      _ProductsCategorieScreenState();
}

class _ProductsCategorieScreenState extends State<ProduitsCategorieScreen> {
  List<Product> _products = [];
  ProductService productService = ProductService();
  bool _loading = true;
  String nom = 'Catégorie...';

  Future<void> getProducts() async {
    ApiResponse response =
        await productService.products('category=${widget.id}');
    if (response.error == null) {
      setState(() {
        _products = response.data as List<Product>;
        print(_products.length);
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.9,
          backgroundColor: colorwhite,
          title: Text(
            widget.name,
            style: const TextStyle(
              color: colorblack,
              fontSize: 18,
            ),
          ),
          iconTheme: const IconThemeData(
            color: colorblack,
          ),
        ),
      ),
      body: _loading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 260,
                ),
                itemCount: 6,
                itemBuilder: (_, index) {
                  return produitLoadingCard3x3();
                },
              ),
            )
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 8, right: 8),
                child: Container(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      mainAxisExtent: 280,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (_, index) {
                      return produitsCard(
                        context,
                        _products.elementAt(index),
                        _products.elementAt(index).id,
                        _products.elementAt(index).name,
                        _products.elementAt(index).price.price,
                        _products.elementAt(index).price.normal,
                        _products.elementAt(index).state.name,
                        _products.elementAt(index).star,
                        _products.elementAt(index).images.isEmpty
                            ? imgProdDefault
                            : _products.elementAt(index).images[0],
                        _products.elementAt(index).stock,
                        _products.elementAt(index).unavailable,
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
