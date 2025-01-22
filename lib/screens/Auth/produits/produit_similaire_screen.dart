import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class ProduitSimilaireScreen extends StatefulWidget {
  const ProduitSimilaireScreen({super.key, required this.id});
  final int id;

  @override
  State<ProduitSimilaireScreen> createState() => _ProductSimilaireScreenState();
}

class _ProductSimilaireScreenState extends State<ProduitSimilaireScreen> {
  ProductService productService = ProductService();
  bool _loading = true;

  List<Product> _products = [];

  Future<void> productSimilar() async {
    ApiResponse response =
        await productService.products('sub_category=${widget.id}');
    if (response.error == null) {
      setState(() {
        _products = response.data as List<Product>;
        _loading = !_loading;
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
    productSimilar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          leadingWidth: 40,
          elevation: 0.8,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: colorwhite,
          title: const Text(
            'Produits similiraire',
            style: TextStyle(color: colorblack),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              mainAxisExtent: _loading ? 280 : 280,
            ),
            itemCount: !_loading ? _products.length : 6,
            itemBuilder: (_, index) {
              return !_loading
                  ? InkWell(
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
                    )
                  : produitLoadingCard3x3();
            },
          ),
        ),
      ),
    );
  }
}
