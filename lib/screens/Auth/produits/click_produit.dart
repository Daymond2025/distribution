import 'dart:io';

import 'package:dio/dio.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/create/formulaire_commande_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/create/detail_commande_moi_screen.dart';
import 'package:distribution_frontend/screens/Auth/historique_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/clone_produit_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_icon_button.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/persoComp/perso_comp_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/messages/add_new_conversation_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/produit_similaire_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:distribution_frontend/services/produit_service.dart';
import 'package:distribution_frontend/widgets/image_view.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:http/http.dart' as http;

class ClickProduit extends StatefulWidget {
  const ClickProduit({super.key, this.product});
  final Product? product;

  @override
  State<ClickProduit> createState() => _ClickProduitState();
}

class _ClickProduitState extends State<ClickProduit> {
  late Product _product;
  bool favorite = false;
  int favoriteCount = 0;

  //localisation
  bool location = false;
  bool nolocation = false;
  String choixlocal = '';

  //troc
  String choixtroptype = '';

  //cmd type
  bool commandemoi = false;
  bool nocommandemoi = false;
  String choixtype = '';

  //profil
  List<Profile> _profiles = [];
  late Profile _profile;

  ProductService productService = ProductService();
  ProfileService profileService = ProfileService();

  bool telech = false;

  //message
  Future<void> getProfiles() async {
    ApiResponse response = await profileService.getProfile();
    if (response.error == null) {
      setState(() {
        _profiles = response.data as List<Profile>;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  //profile
  void _showConversation() async {
    final List<int>? results = await showDialog(
      context: context,
      builder: (BuildContext context) => AddNewConversationScreen(
        profile: _profile,
        idCategory: widget.product!.id.toString(),
        category: 'product',
      ),
    );

    if (results != null) {
    } else {}
  }

  // copy
  Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(
        text: _product.type == 'grossiste'
            ? '${_product.name} \n${_product.subTitle ?? ''} \n${_product.description ?? ''} \nPRIX GROSSISTE UNITAIRE: ${_product.price.price}  Fr \nVOUS POUVEZ VENDRE LE PRODUIT ENTRE ${_product.price.min}  Fr ET ${_product.price.max}  Fr'
            : _product.type == 'vente'
                ? '${_product.name} \n${_product.subTitle ?? ''} \n${_product.description ?? ''} \nPRIX DE VENTE: ${_product.price.price}  Fr \nCOMMISSION: ${_product.price.commission}  Fr'
                : '${_product.name} \n${_product.subTitle ?? ''} \n${_product.description ?? ''} \nPRIX A LOUER: ${_product.price.price}  Fr \nCOMMISSION: ${_product.price.commission}  Fr'));

    Fluttertoast.showToast(
        msg: 'La copie a été effectuée.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //download

  Future<void> downloadImages() async {
    // Demander la permission d'accéder au stockage
    var status = await Permission.manageExternalStorage.request();
    if (await status.isPermanentlyDenied) {
      await openAppSettings();
    }

    setState(() {
      // isDownloading = true;
    });

    try {
      // Obtenir le dossier de stockage externe
      final directory = await getExternalStorageDirectory();
      final String picturesDir = '/storage/emulated/0/Pictures/Daymond';

      // Créer le dossier s'il n'existe pas
      final Directory saveDir = Directory(picturesDir);
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      Dio dio = Dio();

      for (String url in _product.images) {
        String fileName = url.split('/').last;
        String savePath = '${saveDir.path}/$fileName';

        await dio.download(url, savePath);

        // Sauvegardez l'image dans la galerie
        await MediaStoreHelper.saveImageToGallery(savePath);
        print('✅ Image téléchargée : $savePath');
      }
      Fluttertoast.showToast(
          msg: 'Téléchargement terminé.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        telech = false;
      });
    } catch (e) {
      print('Erreur : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du téléchargement')),
      );
    } finally {
      setState(() {
        // isDownloading = false;
      });
    }
  }

  Future<void> downloadImage() async {
    print(_product.images);
    Fluttertoast.showToast(
        msg: 'Téléchargements en cours...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // for (var i = 0; i < _product.images.length; i++) {
    //   String url = _product.images[i];
    //   print('image url == $url');

    //   final Directory tempDir = await getTemporaryDirectory();
    //   final path = '${tempDir.path}/${_product.name}$i.jpg';

    //   await Dio().download(url, path);

    //   // await GallerySaver.saveImage(path, albumName: 'Daymond');
    // }

    downloadImages();
  }

  //produit favorie
  Future<void> showProduct() async {
    ApiResponse response = await productService.find(widget.product!.id);
    if (response.error == null) {
      dynamic data = response.data;
      setState(() {
        favorite = data['favorite'];
        favoriteCount = data['favorite_count'];
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  Future<void> deleteAddFavorite() async {
    ApiResponse response =
        await productService.deleteFavorite(widget.product!.id);
    if (response.error == null) {
      Fluttertoast.showToast(
          msg: '${response.message}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      showProduct();
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

  int message = 10;
  bool controller = false;
  Future<void> getannonce() async {
    int vue = await getControllerAnnonce();
    setState(() {
      message = vue;
      if (message == 1) {
        controller = true;
      }
    });
  }

  Future<void> getannonceUpdate() async {
    String vue = await getUpdateAnnonce();
    if (vue == 'ok') {
      setState(() {
        controller = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _product = widget.product!;
    print('le produit == ${jsonEncode(_product.toJson())}');
    showProduct();
    getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(76.0),
        child: Column(
          children: [
            AppBar(
              leadingWidth: 50,
              backgroundColor: colorwhite,
              elevation: 0.0,
              iconTheme: const IconThemeData(
                color: Colors.black87,
              ),
              title: const Text(
                'Aperçu',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(48)),
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoriqueScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.star_purple500_rounded,
                            color: Colors.black54,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 233, 233, 1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              favoriteCount.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(243, 78, 137, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                PopupMenuButton(
                  color: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.more_vert_outlined,
                    ),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'write',
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text('Ecris à un agent'),
                        ],
                      ),
                    ),
                    // const PopupMenuItem(
                    //   value: 'clone',
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.category),
                    //       const SizedBox(
                    //         width: 6,
                    //       ),
                    //       const Text('Produit similaire'),
                    //     ],
                    //   ),
                    // ),
                  ],
                  onSelected: (val) {
                    if (val == 'write') {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.3,
                            maxChildSize: 0.7,
                            minChildSize: 0.3,
                            expand: false,
                            builder: (context, scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 40),
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Selectionnez un agent',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      _profiles.isNotEmpty
                                          ? Column(
                                              children: _profiles
                                                  .map(
                                                    (e) => Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _profile = e;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                          _showConversation();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorfond,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            48),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(
                                                                          e.picturePath ??
                                                                              imgUserDefault),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 6,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        e.name,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        e.role,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            )
                                          : const Text('Pas d\'agent actif'),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else if (val == 'clone') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProduitSimilaireScreen(
                            id: _product.subCategoryId,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            Container(
              padding: EdgeInsets.zero,
              height: 20,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            top: 1, bottom: 1, left: 12, right: 30),
                        decoration: const BoxDecoration(
                          color: colorYellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(_product.state.name),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      _product.star == 1
                          ? Image.asset(
                              'assets/images/star.png',
                              width: 15,
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                        builder: (context) =>
                            SliderShowFullmages(image: _product.images),
                      ),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  width: double.infinity,
                                  child: Image.network(
                                    _product.images[0],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                _product.link != ''
                                    ? Positioned(
                                        bottom: 20,
                                        right: 20,
                                        child: InkWell(
                                          onTap: () async {
                                            String url = _product.link!;
                                            await canLaunch(url)
                                                ? launch(url)
                                                : print('Youtue non ouvert');
                                          },
                                          child: Image.asset(
                                            'assets/images/youtube.png',
                                            height: 40,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            _product.images.length > 1
                                ? Container(
                                    padding: const EdgeInsets.only(left: 5),
                                    height: 100,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _product.images.length -
                                          1, //Product.products.length
                                      itemBuilder: (context, index) {
                                        //return ProductsCarousel(product: Product.products[index]);
                                        return Stack(
                                          children: [
                                            ImageCarousel(
                                                imageitem: _product.images
                                                    .elementAt(index + 1)),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 10),
                        child: Text(
                          _product.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Text(
                          _product.subTitle ?? '',
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: colorwhite,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 15,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _product.type == 'grossiste'
                                ? 'Prix daymond :  '
                                : _product.type == 'vente'
                                    ? 'Prix de vente :  '
                                    : 'Prix de location :  ',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15.0,
                            ),
                          ),
                          TextSpan(
                            text: NumberFormat("###,###", 'en_US')
                                .format(_product.price.price)
                                .replaceAll(',', ' '),
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            // ignore: unnecessary_null_comparison
                            text: ' Fr',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: '      ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[400],
                            ),
                          ),
                          _product.reducedPrice != null
                              ? TextSpan(
                                  text: _product.reducedPrice.toString(),
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black45,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : const TextSpan(),
                          _product.reducedPrice != null
                              ? const TextSpan(
                                  text: ' Fr',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black87,
                                  ),
                                )
                              : const TextSpan(),
                        ],
                      ),
                    ),
                  ),
                  /*_product.type == 'grossiste'
                      ? controller
                      ? Container(
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 55, 79, 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 3,
                              color: colorwhite,
                              margin: const EdgeInsets.only(right: 5),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'VENTE IMPOSSIBLE AU PRIX GROSSISTE UNITAIRE.',
                                      style: TextStyle(
                                        color: colorwhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      'Vendez le produit a l\'un des prix de vente ou plus et gagnez 50% de la somme ajouté sur le prix grossiste unitaire.',
                                      style: TextStyle(
                                        color: colorwhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: -18,
                          top: -18,
                          child: IconButton(
                              onPressed: () {
                                getannonceUpdate();
                              },
                              icon: Icon(
                                Icons.close,
                                color: colorwhite,
                              )),
                        ),
                      ],
                    ),
                  ) */

                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: _product.type == 'grossiste'
                        ? RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Prix de vente de: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                  ),
                                ),
                                TextSpan(
                                  text: NumberFormat("###,###", 'en_US')
                                      .format(_product.price.min)
                                      .replaceAll(',', ' '),
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: ' à ',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextSpan(
                                  text: NumberFormat("###,###", 'en_US')
                                      .format(_product.price.max)
                                      .replaceAll(',', ' '),
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  // ignore: unnecessary_null_comparison
                                  text: ' Fr',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black87),
                                ),
                              ],
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Commission: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                  ),
                                ),
                                TextSpan(
                                  text: NumberFormat("###,###", 'en_US')
                                      .format(_product.price.commission)
                                      .replaceAll(',', ' '),
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  // ignore: unnecessary_null_comparison
                                  text: ' Fr',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const Text(
                    "Frais de Livraison: ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${_product.shop.city.name} ',
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                          TextSpan(
                            text: NumberFormat("###,###", 'en_US')
                                .format(_product.delivery.city)
                                .replaceAll(',', ' '),
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' Fr',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                          const TextSpan(
                            text: '  -  ',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                          TextSpan(
                            text: 'Hors ${_product.shop.city.name} ',
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                          TextSpan(
                            text: NumberFormat("###,###", 'en_US')
                                .format(_product.delivery.noCity)
                                .replaceAll(',', ' '),
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' Fr',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //detail
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 5),
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              decoration: const BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black12,
                  //     blurRadius: 1.0,
                  //     offset: Offset(0.0, -0.5),
                  //   ),
                  // ],
                  ),
              //caracteristique
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Détails',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: colorwhite,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/ville.png',
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${_product.shop.city.name} '),
                      ],
                    ),
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Text('État du produit : ${_product.state.name}'),
                  ),

                  _product.sizes.isNotEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            children: [
                              const Text('Taille du produit   '),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 2,
                                  color: Colors.black26,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  _product.sizes.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10, top: 10),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 25.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: 30,
                            ),
                            itemCount: _product.sizes.length,
                            itemBuilder: (_, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colorfond,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Text(_product.sizes[index]),
                              );
                            },
                          ),
                        )
                      : Container(),
                  //verifier si la couleur du produit a été bien enregistrer pour montré la disponibilité
                  _product.colors.length > 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            children: [
                              const Text('Couleur du produit   '),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width - 200,
                                height: 2,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  _product.colors.length > 0
                      ? Container(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 5, right: 10, top: 10),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 25.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: 30,
                            ),
                            itemCount: _product.colors.length,
                            itemBuilder: (_, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colorfond,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: colorfond,
                                    ),
                                    color: Color(int.parse((_product
                                            .colors[index]["value"] as String)
                                        .replaceFirst("#", "0xFF"))),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Text(
                                    _product.colors[index]["name"],
                                    style: TextStyle(
                                      color: _product.colors[index]["name"] ==
                                              'Blanc'
                                          ? colorblack
                                          : colorwhite,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),

                  //Caracteristique
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            child: Text(_product.description ?? ''),
                          ),
                        ),
                        Positioned(
                          top: -4,
                          left: 20,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 4,
                              right: 4,
                            ),
                            color: colorwhite,
                            child: const Text('Caracteristique'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: //traitement dans la base de donnée
          Container(
        height: 105,
        margin: const EdgeInsets.only(
          top: 5,
        ),
        decoration: const BoxDecoration(
          color: colorwhite,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 1.0,
                offset: Offset(0.0, -0.5))
          ],
        ),
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //download
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 204, 204, 204),
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5,
                              spreadRadius: .2,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: telech == true
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  CircularProgressIndicator(color: Colors.grey),
                            )
                          : FlutterFlowIconButton(
                              onPressed: () async {
                                setState(() {
                                  telech = true;
                                });
                                await downloadImage();
                              },
                              buttonSize: 30,
                              showLoadingIndicator: true,
                              borderRadius: 8,
                              fillColor: Colors.white,
                              icon: const Icon(
                                color: Colors.grey,
                                size: 15,
                                Icons.download,
                              ),
                            ),
                    ),
                    //copy
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 204, 204, 204),
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5,
                              spreadRadius: .2,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: IconButton(
                        onPressed: () => copyToClipboard(),
                        color: Colors.grey,
                        icon: const Icon(
                          size: 20,
                          Icons.copy,
                        ),
                        tooltip: 'Copié',
                      ),
                    ),
                    //favories
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: favorite ? colorYellow2 : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 204, 204, 204),
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5,
                              spreadRadius: .2,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: IconButton(
                        onPressed: () {
                          // setState(() {
                          //   favorite == 0 ? 1 : 0;
                          // });
                          deleteAddFavorite();
                        },
                        color: favorite ? Colors.white : Colors.grey,
                        icon: const Icon(
                          size: 20,
                          Icons.star,
                        ),
                        tooltip: 'Ajouté au favorie',
                      ),
                    ),
                    //trocs
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 204, 204, 204),
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5,
                              spreadRadius: .2,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProduitSimilaireScreen(
                                id: _product.subCategoryId,
                              ),
                            ),
                          );
                          // if (_product.stock == 0 &&
                          //     _product.unavailable == 0) {
                          // } else {
                          //   if (_product.stock == 1) {
                          //     Fluttertoast.showToast(
                          //       msg: 'Produit en rupture de stock.',
                          //       toastLength: Toast.LENGTH_SHORT,
                          //       gravity: ToastGravity.TOP,
                          //       timeInSecForIosWeb: 1,
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0,
                          //     );
                          //   }
                          //   if (_product.unavailable == 1) {
                          //     Fluttertoast.showToast(
                          //       msg: 'Produit indisponible.',
                          //       toastLength: Toast.LENGTH_SHORT,
                          //       gravity: ToastGravity.TOP,
                          //       timeInSecForIosWeb: 1,
                          //       backgroundColor: Colors.blue,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0,
                          //     );
                          //   }
                          // }
                        },
                        color: Colors.grey,
                        icon: const Icon(
                          size: 20,
                          Icons.category,
                        ),
                        tooltip: 'Produit similaire',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: InkWell(
                      onTap: () {
                        //showDialogType();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormulaireCommandeScreen(
                              product: _product,
                              category: 'client',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: colorYellow2,
                            )),
                        child: const Text(
                          'Je passe la commande',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorYellow2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.9,
                                child: PersoCompWidget(
                                  product: _product,
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }
                      //  () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         CloneProduitScreen(product: _product),
                      //   ),
                      // )
                      ,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colorYellow2,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 176, 204, 253),
                                offset: Offset(1.0, 2.0),
                                blurRadius: 5,
                                spreadRadius: .2,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                            ]),
                        child: const Text(
                          'Vendre ce produit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showDialogType() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => Dialog(
                  insetPadding: const EdgeInsets.only(
                    right: 50,
                    left: 50,
                  ),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Container(
                    height: 270,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: const Text(
                                'JE COMMANDE',
                                style: TextStyle(
                                  color: colorYellow2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 3,
                              color: Colors.black12,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxListTile(
                                activeColor: colorYellow2,
                                title: const Text(
                                  'Pour mon client',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                value: commandemoi,
                                onChanged: (isChecked) {
                                  setState(() {
                                    commandemoi = isChecked!;
                                    nocommandemoi = false;
                                    choixtype = 'client';
                                    if (!isChecked) {
                                      choixtype = '';
                                    }
                                  });
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxListTile(
                              activeColor: colorYellow2,
                              title: const Text(
                                'Pour moi même',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              value: nocommandemoi,
                              onChanged: (isChecked) => setState(() {
                                nocommandemoi = isChecked!;
                                commandemoi = false;
                                choixtype = 'moi';
                                if (!isChecked) {
                                  choixtype = '';
                                }
                              }),
                            ),
                          ],
                        ),
                        choixtype != ''
                            ? InkWell(
                                onTap: (() {
                                  Navigator.pop(context);
                                  if (choixtype == 'moi') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailCommandeMoiScreen(
                                          product: _product,
                                          category: choixtype,
                                        ),
                                      ),
                                    );
                                  } else if (choixtype == 'client') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FormulaireCommandeScreen(
                                          product: _product,
                                          category: choixtype,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                                child: Container(
                                  color: colorYellow2,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorwhite),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                color: colorfond,
                                height: 40,
                                alignment: Alignment.center,
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                )),
      );
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.imageitem});
  final String imageitem;
  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 4, right: 4),
            height: 90,
            width: MediaQuery.of(context).size.width / 3.6,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.imageitem,
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => const Icon(Icons.error),
                ),
                borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
    );
  }
}

class MediaStoreHelper {
  static const platform =
      MethodChannel('com.daymondboutique.distribution_frontend/media_store');

  static Future<void> saveImageToGallery(String imagePath) async {
    try {
      final result = await platform
          .invokeMethod('saveImageToGallery', {"imagePath": imagePath});
      print(result); // "Image enregistrée avec succès"
    } on PlatformException catch (e) {
      print("Erreur lors de l'enregistrement : ${e.message}");
    }
  }
}
