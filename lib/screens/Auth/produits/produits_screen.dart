import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/models/state_product.dart';
import 'package:distribution_frontend/services/params_service.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/search_product.dart';
import 'package:flutter/material.dart';

class ProduitsScreen extends StatefulWidget {
  const ProduitsScreen({super.key});

  @override
  State<ProduitsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProduitsScreen> {
  ParamsService paramsService = ParamsService();
  ProductService productService = ProductService();
  List<StateProduct> states = [];
  List<Product> products = [];

  String dropdownName = 'Tout';
  String dropdownValue = '';
  bool _loading = true; // Chargement initial
  bool isLoadingMore = false; // Chargement pour charger plus de produits
  int currentPage = 1; // Page actuelle de la pagination
  bool hasMore = true; // Indique si plus de produits doivent être chargés
  int selectedTabIndex = 0; // Index du tab sélectionné

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getState();
    getProducts('', 0); // Initialisation avec des paramètres par défaut

    // Ajoute un écouteur pour charger plus de produits lors du scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          hasMore) {
        loadMoreProducts();
      }
    });
  }

  // Récupère les états des produits
  Future<void> getState() async {
    ApiResponse response = await paramsService.params('state');
    if (response.error == null) {
      setState(() {
        states = (response.data as List)
            .map((item) => StateProduct.fromJson(item))
            .toList();
      });
    } else if (response.error == unauthorized) {
      logout().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      });
    }
  }

  // Récupère les produits avec pagination et filtre
  Future<void> getProducts(String stateProduct, int popular) async {
    setState(() {
      _loading = true;
      currentPage = 1; // Redémarre la pagination à chaque nouveau filtre
      hasMore = true;
      products.clear(); // Vide la liste actuelle
    });

    String filter = stateProduct.isNotEmpty
        ? 'state=$stateProduct&popular=$popular&page=$currentPage&size=10'
        : 'popular=$popular&page=$currentPage&size=10';

    ApiResponse response = await productService.products(filter);
    if (response.error == null) {
      setState(() {
        List<Product> newProducts = response.data as List<Product>;
        products.addAll(newProducts);
        _loading = false;
        hasMore = newProducts.length ==
            10; // Si la taille est 10, il y a encore plus de produits à charger
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  // Charge plus de produits lorsque l'utilisateur fait défiler vers le bas
  Future<void> loadMoreProducts() async {
    if (isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
      currentPage++; // Incrémente le numéro de la page pour charger plus
    });

    String filter = dropdownValue.isNotEmpty
        ? 'state=$dropdownValue&popular=$selectedTabIndex&page=$currentPage&size=10'
        : 'popular=$selectedTabIndex&page=$currentPage&size=10';

    ApiResponse response = await productService.products(filter);
    if (response.error == null) {
      setState(() {
        List<Product> newProducts = response.data as List<Product>;
        products.addAll(newProducts);
        isLoadingMore = false;
        hasMore = newProducts.length == 10;
      });
    } else {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  // Mise à jour des filtres lorsque l'utilisateur change le dropdown
  void onChanged(String? value) {
    if (value != null) {
      setState(() {
        dropdownValue = value;
        dropdownName =
            states.firstWhere((state) => state.id.toString() == value).name ??
                '';
      });
      getProducts(value, selectedTabIndex == 0 ? 0 : 1);
    }
  }

  // Mise à jour de la sélection du tab (Plus récents vs Plus vendus)
  void onTabChanged(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    getProducts(dropdownValue, index == 0 ? 0 : 2);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorwhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: colorwhite,
            elevation: 0.8,
            title: const Text(
              'PRODUIT',
              style: TextStyle(color: colorblack, fontSize: 18),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchR()),
                  );
                },
                icon: const Icon(Icons.search, size: 25),
              ),
            ],
            bottom: TabBar(
              onTap: onTabChanged,
              tabs: const [
                Tab(text: 'Plus récents'),
                Tab(text: 'Produits gagnants'),
              ],
              labelColor: colorYellow2,
              unselectedLabelColor: Colors.black54,
              indicatorColor: colorYellow2,
              labelStyle: const TextStyle(fontSize: 17),
            ),
          ),
        ),
        body: _loading
            ? produitLoading(4) // Affiche le loading initial
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ProductWidget(products: products),
                    isLoadingMore ? produitLoading(2) : Container()
                  ],
                ),
              ),
        // bottomNavigationBar: isLoadingMore
        //     ? const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child:
        //             Center(child: CircularProgressIndicator()), // Loader en bas
        //       )
        //     : null,
      ),
    );
  }
}

// Widget de chargement pour les produits
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
      itemCount: elements, // Affiche 6 éléments de chargement
      itemBuilder: (_, index) => produitLoadingCard3x3(),
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
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
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
            return InkWell(
              onTap: () => {},
              child: produitsCard(
                context,
                products.elementAt(index),
                products.elementAt(index).id,
                products.elementAt(index).name,
                products.elementAt(index).price.price,
                products.elementAt(index).price.normal,
                products.elementAt(index).state.name,
                products.elementAt(index).star,
                products.elementAt(index).images.isEmpty
                    ? imgProdDefault
                    : products.elementAt(index).images[0],
                products.elementAt(index).stock,
                products.elementAt(index).unavailable,
              ),
            );
          },
        ),
      ),
    );
  }
}
