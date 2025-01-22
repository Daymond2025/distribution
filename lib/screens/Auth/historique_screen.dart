import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/favorite.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/produit_similaire_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/favorie_service.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

import '../../api_response.dart';
import '../../services/user_service.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  bool _loading = true;
  bool _noCnx = false;
  List<Favorite> _favorites = [];
  ProductService productService = ProductService();

  Future<void> index() async {
    ApiResponse response = await productService.getFavorites();
    if (response.error == null) {
      setState(() {
        _favorites = response.data as List<Favorite>;
        _loading = false;
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
    }
  }

  Future<void> deleteFavorite(int id) async {
    ApiResponse response = await productService.deleteFavorite(id);
    if (response.error == null) {
      index();
      successAlert(response.message.toString());
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  successAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        isOverlayTapDismiss: false,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    index();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            appBar: AppBar(
              elevation: 0.2,
              backgroundColor: colorwhite,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                color: colorblack,
              ),
              title: const Text(
                'Favories',
                style: TextStyle(color: colorblack),
              ),
            ),
            body: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 8.0, right: 10, left: 10),
                      child: _favorites.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: !_loading ? _favorites.length : 3,
                              itemBuilder: (_, index) {
                                Favorite favorite = _favorites[index];
                                return !_loading
                                    ? cardFavorie(
                                        favorite.product,
                                        favorite.id,
                                        favorite.product.subCategoryId,
                                        favorite.product.state.name,
                                        favorite.product.images[0],
                                        favorite.product.name,
                                        favorite.product.price.price,
                                        favorite.product.reducedPrice ?? 0)
                                    : favoriesLoading();
                              },
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height - 140,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Text(
                                'Favories vide!',
                                style: TextStyle(
                                  color: _loading ? colorblack : colorfond,
                                ),
                              ),
                            ),
                    ),
                  ),
          )
        : kRessayer(context, () {
            index();
          });
  }

  Stack cardFavorie(Product product, int idFavorite, int idSous, String etat,
          String image, String nom, int prix, int prixReduit) =>
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: colorwhite,
            ),
            child: Column(
              children: [
                Container(
                  color: colorwhite,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClickProduit(
                              product: product,
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                  child: Image.network(
                                    image,
                                    height: 90,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      nom,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          prix.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          prixReduit != 0
                                              ? prixReduit.toString()
                                              : '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 5,
                    left: 5,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: colorfond,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClickProduit(
                                  product: product,
                                ),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Voir les détails',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // ignore: sort_child_properties_last
                          child: const Text(''),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: colorfond,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProduitSimilaireScreen(
                                  id: product.subCategoryId,
                                ),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Produits similaire',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
                top: 2,
                bottom: 2,
              ),
              decoration: const BoxDecoration(
                color: colorYellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                etat,
                style: const TextStyle(
                  color: colorblack,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 30,
            child: IconButton(
              onPressed: () {
                deleteFavorite(product.id);
                setState(() {
                  _loading = false;
                });
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      );

  Container favoriesLoading() => Container(
        padding: const EdgeInsets.only(bottom: 5),
        alignment: Alignment.topLeft,
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 255, 255, 255),
          highlightColor: const Color.fromARGB(255, 253, 250, 250),
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colorwhite,
            ),
          ),
        ),
      );
}
