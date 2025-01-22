import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/product.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/create/formulaire_commande_moi_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailCommandeMoiScreen extends StatefulWidget {
  const DetailCommandeMoiScreen({
    super.key,
    required this.product,
    required this.category,
  });

  final String category;
  final Product product;

  @override
  State<DetailCommandeMoiScreen> createState() =>
      _DetailCommandeMoiScreenState();
}

class _DetailCommandeMoiScreenState extends State<DetailCommandeMoiScreen> {
  int _nbcmd = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          leadingWidth: 40,
          backgroundColor: colorwhite,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          title: const Text(
            'Offre spécial',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colorwhite,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorwhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClickProduit(
                          product: widget.product,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                child: Image.network(
                                  widget.product.images[0],
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          widget.product.name,
                                          overflow: TextOverflow.ellipsis,
                                          //style: Theme.of(context).textTheme.subtitle1,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            child: const Text(
                                              'Qualité de produit',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (_nbcmd != 1) {
                                                      _nbcmd = _nbcmd - 1;
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  size: 30,
                                                  color: _nbcmd == 1
                                                      ? const Color.fromARGB(
                                                          255, 219, 219, 219)
                                                      : colorYellow2,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(_nbcmd.toString()),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _nbcmd = _nbcmd + 1;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.add_circle_rounded,
                                                  size: 30,
                                                  color: colorYellow2,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const Icon(
                                  Icons.star,
                                  color: colorYellow,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    right: 5,
                                    left: 5,
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: colorYellow,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    widget.product.state.name,
                                    style: const TextStyle(
                                      color: colorblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Prix de vente chez Daymond : ',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${NumberFormat("###,###", 'en_US').format(widget.product.price.price).replaceAll(',', ' ')}  Fr',
                          style: const TextStyle(
                            color: colorBlue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colorwhite,
            ),
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            margin: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Félicitation Vous offre un bon de réduction d\'une valeur de ${NumberFormat("###,###", 'en_US').format(widget.product.price.price - widget.product.price.seller).replaceAll(',', ' ')}  Fr sur le produit',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: colorvalid, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Prix après réduction du bons : ',
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      '${NumberFormat("###,###", 'en_US').format(widget.product.price.seller * _nbcmd).replaceAll(',', ' ')}  Fr',
                      style: const TextStyle(
                        color: colorBlue,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Frais de livraison ${widget.product.shop.city.name} :',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      '${NumberFormat("###,###", 'en_US').format(widget.product.delivery.city * _nbcmd).replaceAll(',', ' ')}  Fr',
                      style: const TextStyle(
                        fontSize: 13,
                        color: colorBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Frais de livraison hors ${widget.product.shop.city.name} :',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      '${NumberFormat("###,###", 'en_US').format(widget.product.delivery.noCity * _nbcmd).replaceAll(',', ' ')}  Fr',
                      style: const TextStyle(
                        fontSize: 13,
                        color: colorBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Vous économisez au total ${NumberFormat("###,###", 'en_US').format((widget.product.price.price - widget.product.price.seller) * _nbcmd).replaceAll(',', ' ')}  Fr',
                    style: const TextStyle(fontSize: 13, color: colorBlue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: colorfond,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulaireCommandeMoiScreen(
                qte: _nbcmd,
                product: widget.product,
              ),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colorYellow2,
            ),
            child: const Text(
              'JE VALIDE',
              style: TextStyle(
                  color: colorwhite, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
