import 'package:flutter/material.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllProduitScreen extends StatefulWidget {
  const AllProduitScreen({super.key});

  @override
  State<AllProduitScreen> createState() => _AllProduitScreenState();
}

class _AllProduitScreenState extends State<AllProduitScreen> {
  final ProductService productService = ProductService();
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  bool _noCnx = false;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      allProduit(pageKey);
    });
  }

  Future<void> allProduit(int pageKey) async {
    try {
      ApiResponse response =
          await productService.products('page=$pageKey&size=10');
      if (response.error == null) {
        final List<Product> newProducts = response.data as List<Product>;
        print(newProducts.length);
        final isLastPage = newProducts.length < 10;

        if (isLastPage) {
          _pagingController.appendLastPage(newProducts);
        } else {
          print('pageKey: $pageKey');
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newProducts, nextPageKey);
        }
        setState(() {
          _noCnx = false;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false)
            });
      } else {
        setState(() {
          _noCnx = true;
        });
        _pagingController.error = response.error;
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
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
                  'Produits',
                  style: TextStyle(color: colorblack),
                ),
              ),
            ),
            body: PagedGridView<int, Product>(
              pagingController: _pagingController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.60,
              ),
              builderDelegate: PagedChildBuilderDelegate<Product>(
                itemBuilder: (context, product, index) {
                  return InkWell(
                    onTap: () => {},
                    child: produitsCard(
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
                    ),
                  );
                },
                firstPageProgressIndicatorBuilder: (_) => const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularProgressIndicator(),
                    CircularProgressIndicator(),
                  ],
                ),
                newPageProgressIndicatorBuilder: (_) => produitLoadingCard3x3(),
                noMoreItemsIndicatorBuilder: (_) =>
                    const Center(child: Text('Plus de produits disponibles')),
              ),
            ),
          )
        : kRessayer(context, () {
            _pagingController.refresh();
          });
  }
}

Widget produitLoading() {
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
      itemCount: 6,
      itemBuilder: (_, index) => produitLoadingCard3x3(),
    ),
  );
}
