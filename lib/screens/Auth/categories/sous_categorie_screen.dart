import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class SousCategorieScreen extends StatefulWidget {
  const SousCategorieScreen(
      {super.key,
      required this.idsous,
      required this.id,
      required this.nomsous});
  final int id;
  final int idsous;
  final String nomsous;
  @override
  State<SousCategorieScreen> createState() => _SousCategorieScreenState();
}

class _SousCategorieScreenState extends State<SousCategorieScreen> {
  List<Product> _products = [];
  ProductService productService = ProductService();
  String nom = 'Sous categorie...';
  bool _loading = true;

  Future<void> getProducts() async {
    ApiResponse response =
        await productService.products('sub_category=${widget.idsous}');
    if (response.error == null) {
      setState(() {
        _products = response.data as List<Product>;
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
            widget.nomsous.toString(),
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
                        mainAxisExtent: 277,
                      ),
                      itemCount: _products.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () => {},
                          child: produitsCard(
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
                          ),
                        );
                      },
                    ),
                  )),
            ),
    );
  }
}
