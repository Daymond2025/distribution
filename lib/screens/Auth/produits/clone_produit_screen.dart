import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/lien/lien_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:distribution_frontend/widgets/image_view.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:flutter/services.dart';

class CloneProduitScreen extends StatefulWidget {
  const CloneProduitScreen({super.key, required this.product});
  final Product product;

  @override
  State<CloneProduitScreen> createState() => _CloneProduitScreenState();
}

class _CloneProduitScreenState extends State<CloneProduitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _soustitreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();

  late String _type;
  late int price;

  bool _link = false;
  String lien = site;

  _submit() async {
    List<dynamic> data;
    AlertComponent().loading();
    ApiResponse response = await CloneProductService().storeClone(
      widget.product.id,
      _nomController.text,
      _soustitreController.text,
      _descriptionController.text,
      _prixController.text,
      _contactController.text,
      int.parse(_prixController.text),
      // 🆕 Ajouts obligatoires
      widget.product.isWinningProduct ?? false,
      widget.product.winningBonusAmount ?? 0,
    );

    AlertComponent().endLoading();

    if (response.error == null) {
      Fluttertoast.showToast(
        msg: 'Produit clone avec succès',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      setState(() {
        lien = response.message ?? '';
        _link = !_link;
      });

      // ignore: use_build_context_synchronously
      // showModalBottomSheet(
      //   isScrollControlled: true,
      //   context: context,
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      //   builder: (context) => DraggableScrollableSheet(
      //       initialChildSize: 0.5,
      //       maxChildSize: 0.5,
      //       minChildSize: 0.5,
      //       expand: false,
      //       builder: (context, scrollController) {
      //         return Container(
      //           padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Column(
      //                 children: [
      //                   Row(
      //                     children: [
      //                       Expanded(
      //                         child: Container(),
      //                       ),
      //                       IconButton(
      //                         onPressed: () => Navigator.of(context).pop(),
      //                         icon: const Icon(
      //                           Icons.close_rounded,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Container(
      //                     padding: const EdgeInsets.symmetric(
      //                       horizontal: 20,
      //                       vertical: 20,
      //                     ),
      //                     child: Column(
      //                       mainAxisSize: MainAxisSize.max,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         const Text(
      //                           'Lien de l\'article',
      //                           style: TextStyle(
      //                             fontSize: 24,
      //                           ),
      //                         ),
      //                         Container(
      //                           padding: const EdgeInsets.all(10),
      //                           margin:
      //                               const EdgeInsets.symmetric(vertical: 10),
      //                           width: MediaQuery.sizeOf(context).width,
      //                           decoration: BoxDecoration(
      //                             border: Border.all(
      //                               width: 1,
      //                               color: Colors.black12,
      //                             ),
      //                             borderRadius: BorderRadius.circular(8),
      //                           ),
      //                           child: Text(
      //                             lien,
      //                             maxLines: 1,
      //                             overflow: TextOverflow.ellipsis,
      //                             style: const TextStyle(
      //                               fontSize: 20,
      //                               color: Colors.blue,
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Container(
      //                 padding: const EdgeInsets.all(20),
      //                 child: GestureDetector(
      //                   onTap: () async {
      //                     await Clipboard.setData(ClipboardData(text: lien));
      //                     Fluttertoast.showToast(
      //                         msg: 'Lien copié.',
      //                         toastLength: Toast.LENGTH_SHORT,
      //                         gravity: ToastGravity.TOP,
      //                         timeInSecForIosWeb: 1,
      //                         backgroundColor: Colors.red,
      //                         textColor: Colors.white,
      //                         fontSize: 16.0);

      //                     Navigator.of(context).pop();
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: Container(
      //                     width: MediaQuery.sizeOf(context).width,
      //                     height: 50,
      //                     alignment: Alignment.center,
      //                     decoration: BoxDecoration(
      //                         color: colorYellow2,
      //                         borderRadius: BorderRadius.circular(8)),
      //                     child: const Text(
      //                       'COPIER LE LIEN',
      //                       style: TextStyle(
      //                         fontSize: 22,
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         );
      //       }),
      // );
      // Navigator.pop(context);
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: LienWidget(
                lien: lien,
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));
    } else {
      print(response.error);
    }
  }

  @override
  void initState() {
    if (widget.product.type == 'grossiste') {
      price = widget.product.price.min;
    } else {
      price = widget.product.price.price;
    }

    _nomController.text = widget.product.name;
    _soustitreController.text = widget.product.subTitle ?? '';
    _descriptionController.text = widget.product.description ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorwhite,
        elevation: 0.8,
        title: const Text(
          'Personnalisation',
          style: TextStyle(
            color: colorblack,
          ),
        ),
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: colorwhite,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(10, 158, 158, 158),
                    blurRadius: 5,
                    offset: Offset(1, 0),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SliderShowFullmages(image: widget.product.images),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Image.network(
                                widget.product.images.isNotEmpty
                                    ? widget.product.images[0]
                                    : imgProdDefault,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        widget.product.images.length > 1
                            ? Container(
                                padding: const EdgeInsets.only(left: 5),
                                height: 100,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.product.images.length -
                                      1, //Product.products.length
                                  itemBuilder: (context, index) {
                                    //return ProductsCarousel(product: Product.products[index]);
                                    return Stack(
                                      children: [
                                        ImageCarousel(
                                            imageitem: widget.product.images
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: colorwhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _nomController,
                        decoration:
                            kCmdInputDecorationClone('Nom de l\'article'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nom de l\'article obligatoire.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: colorwhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _soustitreController,
                        decoration: kCmdInputDecorationClone('Sous titre'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: colorwhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        minLines: 2,
                        maxLines: 10,
                        controller: _descriptionController,
                        decoration: kCmdInputDecorationClone('Description'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description obligatoire.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 8),
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: widget.product.type == 'grossiste'
                          ? Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(children: [
                                    const TextSpan(
                                      text: 'Daymond vous donne ce produit au ',
                                      style: TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'prix grossiste ',
                                      style: TextStyle(
                                        color: colorblack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' de ',
                                      style: TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${widget.product.price.price} CFA.',
                                      style: const TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                  ]),
                                ),
                                const Divider(color: Colors.black26),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(children: [
                                    const TextSpan(
                                      text: 'Vous pouvez vendre ce produit de ',
                                      style: TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.product.price.min.toString(),
                                      style: const TextStyle(
                                        color: colorYellow,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' à ',
                                      style: TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.product.price.max.toString(),
                                      style: const TextStyle(
                                        color: colorYellow,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' CFA.',
                                      style: TextStyle(
                                        color: colorblack,
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            )
                          : RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Vous pouvez vendre ce produit à ',
                                  style: TextStyle(
                                    color: colorblack,
                                  ),
                                ),
                                TextSpan(
                                  text: price.toString(),
                                  style: const TextStyle(
                                    color: colorYellow,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' CFA.',
                                  style: TextStyle(
                                    color: colorblack,
                                  ),
                                ),
                              ]),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: colorwhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _prixController,
                        keyboardType: TextInputType.phone,
                        decoration:
                            kCmdInputDecorationClone('Votre prix de vente'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Prix de vente obligatoire.';
                          } else if (int.parse(value) < price) {
                            return 'Prix de vente bas.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: colorwhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _contactController,
                        keyboardType: TextInputType.phone,
                        decoration: kCmdInputDecorationClone(
                            'Votre numéro de téléphone'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le numéro de téléphone du vendeur ne doit pas être vide.';
                          } else if (value.length < 10 || value.length >= 11) {
                            return 'Le numéro doit comporter 10 chiffres!';
                          }
                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Frais de Livraison: ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${widget.product.shop.city.name} ',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                    TextSpan(
                                      text: NumberFormat("###,###", 'en_US')
                                          .format(widget.product.delivery.city)
                                          .replaceAll(',', ' '),
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const TextSpan(
                                      text: ' FCFA',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                    const TextSpan(
                                      text: '  -  ',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                    TextSpan(
                                      text:
                                          'Hors ${widget.product.shop.city.name} ',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                    TextSpan(
                                      text: NumberFormat("###,###", 'en_US')
                                          .format(
                                              widget.product.delivery.noCity)
                                          .replaceAll(',', ' '),
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const TextSpan(
                                      text: ' FCFA',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                ),
                                child: Text(
                                  'Annuler',
                                  style: TextStyle(
                                    color: Colors.red.shade200,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                padding:
                                    WidgetStateProperty.all(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AlertComponent().confirm(
                                      context,
                                      'Voulez vous vraiment cloner le produit?',
                                      () => _submit());
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colorYellow2,
                                  ),
                                  color: colorYellow2,
                                ),
                                child: const Text(
                                  'Enregistrer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
            ),
          ],
        ),
      ),
    );
  }
}
