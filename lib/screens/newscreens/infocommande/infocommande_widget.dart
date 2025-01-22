import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/models/orderClone.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_icon_button.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'infocommande_model.dart';
export 'infocommande_model.dart';

class InfocommandeWidget extends StatefulWidget {
  InfocommandeWidget({
    Key? key,
    required this.produit,
  }) : super(key: key);
  final CloneProduct produit;
  @override
  State<InfocommandeWidget> createState() => _InfocommandeWidgetState();
}

class _InfocommandeWidgetState extends State<InfocommandeWidget> {
  late InfocommandeModel _model;
  final ScrollController _scrollController = ScrollController();
  bool _loading = true; // Chargement initial
  bool isLoadingMore = false; // Chargement pour charger plus de produits
  int currentPage = 1; // Page actuelle de la pagination
  bool hasMore = true; // Indique si plus de produits doivent être chargés
  int selectedTabIndex = 0; // Index du tab sélectionné
  List<OrderClone> products = [];
  int totalCommandes = 0;

  CloneProductService productService = CloneProductService();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfocommandeModel());
    // Ajoute un écouteur pour charger plus de produits lors du scroll
    print("id du produit ${widget.produit.id}");
    getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          hasMore) {
        loadMoreProducts();
      }
    });
  }

  // Récupère les produits avec pagination et filtre
  Future<void> getProducts() async {
    print("=== get all commandes ====");
    setState(() {
      _loading = true;
      currentPage = 1; // Redémarre la pagination à chaque nouveau filtre
      hasMore = true;
      products.clear(); // Vide la liste actuelle
    });

    ApiResponse response =
        await productService.cloneOrder(widget.produit.id, 10, currentPage);
    if (response.error == null) {
      setState(() {
        List<OrderClone> newProducts = response.data as List<OrderClone>;
        print(jsonEncode(newProducts.map((e) => e.toJson()).toList()));
        products.addAll(newProducts);
        _loading = false;

        hasMore = newProducts.length ==
            10; // Si la taille est 10, il y a encore plus de produits à charger
      });
      setState(() {
        totalCommandes = products.length;
      });
    } else {
      print("==erreur== ${response.error}");
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

    ApiResponse response =
        await productService.cloneOrder(widget.produit.id, 10, currentPage);
    if (response.error == null) {
      setState(() {
        List<OrderClone> newProducts = response.data as List<OrderClone>;
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

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, -1),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 40,
                    child: Divider(
                      thickness: 3,
                      color: Color.fromARGB(255, 238, 238, 238),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1, -1),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).secondaryText,
                borderRadius: 20,
                buttonSize: 30,
                fillColor: Color(0xFFF7FBFE),
                icon: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 12,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.produit.product.images[0],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.produit.title,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    Text(
                                      widget.produit.price.toString() + ' Fr',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF1050FF),
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ),
                            ].divide(SizedBox(width: 10)),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.star_sharp,
                                color: Color.fromARGB(255, 255, 0, 0),
                                size: 24,
                              ),
                            ].divide(SizedBox(width: 20)),
                          ),
                          // Text(
                          //   'Il ya 3min',
                          //   style: TextStyle(
                          //     fontFamily: 'Inter',
                          //     color: Color(0xFF707070),
                          //     letterSpacing: 0.0,
                          //   ),
                          // ),
                        ].divide(SizedBox(height: 30)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF7FBFE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'COMMANDES',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF7E7E7E),
                                fontSize: 12,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFCE8E8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'New ( 3 )',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFFFF9000),
                                fontSize: 12,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Total ${totalCommandes}',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF7E7E7E),
                                fontSize: 12,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 220, 0, 0),
              child: SingleChildScrollView(
                child:
                    //  Column(
                    //   mainAxisSize: MainAxisSize.max,
                    //   children: [
                    ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products.elementAt(index).customerName,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF656565),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    products.elementAt(index).customerPhone,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 238, 238, 238),
                                    ),
                                  ),
                                  Text(
                                    'Yamoussourko',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 238, 238, 238),
                                    ),
                                  ),
                                  Text(
                                    'Il y a 1min',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(height: 10)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // ].divide(SizedBox(height: 20)),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
