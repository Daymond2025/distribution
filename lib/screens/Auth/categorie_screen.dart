import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/category.dart';
import 'package:distribution_frontend/models/sub_category_simple.dart';
import 'package:distribution_frontend/screens/Auth/categories/produits_categorie_screen.dart';
import 'package:distribution_frontend/screens/Auth/categories/sous_categorie_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/params_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/widgets/card_categorie_produit.dart';
import 'package:distribution_frontend/widgets/search_product.dart';
import 'package:flutter/material.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({super.key});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  ParamsService paramsService = ParamsService();
  List<Category> categories = [];
  bool _loading = true;

  Future<void> getCategory() async {
    ApiResponse response = await paramsService.params('category_detail');
    if (response.error == null) {
      setState(() {
        categories = (response.data as List)
            .map((item) => Category.fromJson(item))
            .toList();
        categorieId = categories[0].id;
        categorieControlle = categories[0].name;
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

  String categorieControlle = '';
  int categorieId = 0;

  @override
  void initState() {
    getCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            leadingWidth: 40,
            elevation: 0.9,
            backgroundColor: colorwhite,
            titleTextStyle: const TextStyle(color: colorblack),
            title: Row(
              children: [
                Image.asset(
                  'assets/images/categorie_2.png',
                  width: 35,
                  height: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Catégories',
                  style: TextStyle(fontSize: 18),
                )
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
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //categorie avec image
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                              children: categories.map((categorie) {
                            return Container(
                              child: InkWell(
                                onTap: (() {
                                  setState(() {
                                    categorieControlle = categorie.name;
                                    categorieId = categorie.id;
                                  });
                                }),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: CardCategorieProduit(
                                    nom: categorie.name,
                                    url: categorie.imgPath,
                                    controller: categorieId == categorie.id
                                        ? true
                                        : false,
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                        ),
                      ),
                    ),

                    //sous categorie
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Container(
                          color: colorwhite,
                          padding: EdgeInsets.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 5, left: 20),
                                margin: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFFAFAFA)),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProduitsCategorieScreen(
                                        id: categorieId,
                                        name: categorieControlle,
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'TOUT',
                                        style: TextStyle(
                                          color: colorYellow2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: categories.map((categorie) {
                                  return Container(
                                      child:
                                          categorie.name == categorieControlle
                                              ? SubCategories(
                                                  id: categorie.id,
                                                  subCategories:
                                                      categorie.subCategories,
                                                )
                                              : Container());
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //categorie avec image
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Container(
                          height: 90,
                          margin: const EdgeInsets.only(bottom: 5),
                        ),
                      ),
                    ),

                    //sous categorie
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: colorwhite,
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 5, left: 20),
                              margin: const EdgeInsets.only(
                                bottom: 5,
                              ),
                              decoration:
                                  const BoxDecoration(color: Color(0xFFFAFAFA)),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'TOUT',
                                    style: TextStyle(
                                      color: colorYellow2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                  ),
                                ],
                              ),
                            ),
                            const Column(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}

class SubCategories extends StatelessWidget {
  const SubCategories(
      {super.key, required this.subCategories, required this.id});
  final List<SubCategory> subCategories;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: subCategories
          .map(
            (e) => InkWell(
              splashColor: colorBlue100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SousCategorieScreen(
                      id: id, idsous: e.id, nomsous: e.name),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 10, right: 10, left: 10),
                  child: Text(
                    e.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
