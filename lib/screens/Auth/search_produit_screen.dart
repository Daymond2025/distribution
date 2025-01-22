import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class SearchProduitScreen extends StatefulWidget {
  const SearchProduitScreen(
      {super.key, required this.search, required this.count});
  final String search;
  final int count;
  @override
  State<SearchProduitScreen> createState() => _SearchProduitScreenState();
}

class _SearchProduitScreenState extends State<SearchProduitScreen> {
  ProductService productService = ProductService();
  List<Product> _products = [];
  bool _loading = true;

  Future<void> produitAll() async {
    ApiResponse response =
        await productService.products('search=${widget.search}');
    if (response.error == null) {
      setState(() {
        _products = response.data as List<Product>;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  @override
  void initState() {
    produitAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: colorwhite,
          title: Text(
            widget.search,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 5),
              alignment: Alignment.center,
              child: Text(
                widget.count != 1
                    ? '${widget.count} résultats'
                    : '${widget.count} résultat',
                style: const TextStyle(color: Colors.black54),
              ),
            )
          ],
          iconTheme: const IconThemeData(
            size: 25, //change size on your need
            color: Colors.black54, //change color on your need
          ),
        ),
      ),
      body: !_loading
          ? _products.isNotEmpty
              ? SearchProduitAll(produit: _products)
              : const Center(
                  child: Text('Vide!'),
                )
          : const Center(
              child: CircularProgressIndicator(
                color: colorblack,
              ),
            ),
    );
  }
}

//all
class SearchProduitAll extends StatefulWidget {
  const SearchProduitAll({super.key, required this.produit});
  final List<Product> produit;

  @override
  State<SearchProduitAll> createState() => _SearchProduitAllState();
}

class _SearchProduitAllState extends State<SearchProduitAll> {
  List<Product> _products = [];
  bool _loading = false;

  Future<void> produit() async {
    setState(() {
      _products = widget.produit;
      _loading = true;
    });
  }

  @override
  void initState() {
    produit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 270,
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
            ),
          )
        : Container(
            child: const Text('data'),
          );
  }
}
