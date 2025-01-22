import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/models/state_product.dart';
import 'package:distribution_frontend/screens/Auth/produits/produits_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/params_service.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/search_product.dart';
import 'package:flutter/material.dart';

class RecentVenduScreen extends StatefulWidget {
  const RecentVenduScreen({super.key, required this.type});
  final String type;

  @override
  State<RecentVenduScreen> createState() => _RecentVenduScreenState();
}

class _RecentVenduScreenState extends State<RecentVenduScreen> {
  ParamsService paramsService = ParamsService();
  ProductService productService = ProductService();
  List<StateProduct> states = [];
  List<Product> products = [];

  String dropdownName = 'Tout';
  String dropdownValue = '';
  String _popular = '';
  bool _loading = false;

  Future<void> getState() async {
    ApiResponse response = await paramsService.params('state');
    if (response.error == null) {
      setState(() {
        states = (response.data as List)
            .map((item) => StateProduct.fromJson(item))
            .toList();
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

  Future<void> getProducts(String stateProduct) async {
    ApiResponse response = await productService.products(stateProduct);
    if (response.error == null) {
      setState(() {
        products = response.data as List<Product>;
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
    getState();

    setState(() {
      if (widget.type == 'Produits gagnants') {
        _popular = 'popular=true';
      }
      if (widget.type == 'Plus récents') {
        _popular = 'popular=false';
      }
    });
    getProducts(_popular);

    super.initState();
  }

  void onChanged(value) {
    setState(() {
      dropdownValue = value;
      dropdownName =
          states.firstWhere((state) => state.id.toString() == value).name ?? '';
      _loading = true;
    });
    getProducts('state=$value&$_popular');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.8,
          leadingWidth: 40,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: colorwhite,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.type,
                style: const TextStyle(color: colorblack, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButton(
                  underline: DropdownButtonHideUnderline(child: Container()),
                  style: const TextStyle(fontSize: 12, color: colorblack),
                  hint: Text(dropdownName),
                  icon:
                      const Icon(Icons.keyboard_arrow_down, color: colorblack),
                  items: states
                      .map((e) => DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(
                              e.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchR()),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      body: !_loading
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: ProductWidget(
                  products: products,
                ),
              ),
            )
          : Padding(
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
            ),
    );
  }
}
