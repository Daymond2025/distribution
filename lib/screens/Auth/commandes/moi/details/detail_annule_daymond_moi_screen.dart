import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/produit_similaire_screen.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/constante.dart';

import 'package:intl/intl.dart';

//detail en cours
class DetailAnnuleDaymondMoiScreen extends StatefulWidget {
  const DetailAnnuleDaymondMoiScreen({super.key, required this.order});
  final Order order;

  @override
  State<DetailAnnuleDaymondMoiScreen> createState() =>
      _DetailAnnuleDaymondMoiScreenState();
}

class _DetailAnnuleDaymondMoiScreenState
    extends State<DetailAnnuleDaymondMoiScreen> {
  late Order _order;
  int bon = 0;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    bon = _order.items[0].product.price.price * _order.items[0].quantity -
        _order.items[0].totalProduct;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //produit
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClickProduit(
                    product: _order.items[0].product,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    left: 5,
                    right: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: colorwhite,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(78, 158, 158, 158),
                        blurRadius: 5,
                        offset: Offset(1, 2),
                      ),
                      BoxShadow(
                        color: Color.fromARGB(75, 158, 158, 158),
                        blurRadius: 5,
                        offset: Offset(2, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              child: Image.network(
                                _order.items[0].product.images[0].img,
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    _order.items[0].product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.zero,
                                        child: const Text(
                                          'Quantité du produit',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: colorblack,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(_order.items[0].quantity
                                              .toString()),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 30,
                        height: 1,
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Prix de vente  chez daymond : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: '${_order.items[0].product.price}  Fr',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: colorBlue,
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
                  top: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _order.items[0].product.star == 1
                          ? const Icon(
                              Icons.star,
                              color: colorYellow,
                            )
                          : const SizedBox(
                              width: 4,
                            ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: colorYellow,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          _order.items[0].product.state.name,
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 120),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Votre commande a été annulée',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(
                        MediaQuery.of(context).size.width - 40),
                    border: TableBorder.all(
                      color: colorfond,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            child: const Text(
                              'Motif de l\'annulation',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _order.canceled!.reason ?? '',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  onPressed: (() {
                                    Scaffold.of(context).showBottomSheet(
                                        (BuildContext context) {
                                      return SizedBox(
                                        height: 600,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Expanded(
                                                  child: Text(
                                                    'Détails de la commande',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorBlue),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.expand_less,
                                                    size: 23,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: colorBlue,
                                              thickness: 2,
                                              height: 5,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  margin: const EdgeInsets.only(
                                                    right: 5,
                                                    left: 5,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 6,
                                                                child: Text(
                                                                  'Bon de réduction de ${NumberFormat("###,###", 'en_US').format(bon).replaceAll(',', ' ')}  Fr offert ',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          16),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                  'Prix après réduction du bons :'),
                                                            ),
                                                            Text(
                                                              '${NumberFormat("###,###", 'en_US').format(_order.items[0].totalProduct).replaceAll(',', ' ')}  Fr',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    colorBlue,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                  'Frais de livraison :'),
                                                            ),
                                                            Text(
                                                              '${NumberFormat("###,###", 'en_US').format(_order.items[0].totalFees).replaceAll(',', ' ')}  Fr',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    colorBlue,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          color: colorBlue,
                                                          height: 2,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            const Expanded(
                                                              child: Text(
                                                                'A régler',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${NumberFormat("###,###", 'en_US').format(_order.items[0].total).replaceAll(',', ' ')}  Fr',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    colorBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    const Divider(
                                                      thickness: 1.4,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(15.0, 0.0,
                                                          15.0, 10.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10,
                                                                bottom: 10,
                                                              ),
                                                              child:
                                                                  const Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Contact',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10,
                                                              bottom: 10,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  '+225 ${_order.client.phoneNumber}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(15.0, 0.0,
                                                          15.0, 10.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10,
                                                                bottom: 10,
                                                              ),
                                                              child:
                                                                  const Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Lieu de livraison',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10,
                                                              bottom: 10,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  _order
                                                                      .delivery
                                                                      .city
                                                                      .name,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(15.0, 0.0,
                                                          15.0, 15.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          const Expanded(
                                                            child: Text(
                                                              'Date de livraison',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            _order
                                                                .delivery.date,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(15.0, 0.0,
                                                          15.0, 15.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          const Expanded(
                                                            child: Text(
                                                              'Heure de livraison',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            _order.delivery.time
                                                                .substring(
                                                                    0, 5),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    _order.detail != null
                                                        ? Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    10.0),
                                                            child: const Text(
                                                              'Autres détails',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    _order.detail != null
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: colorwhite,
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    colorfond,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    8),
                                                              ),
                                                            ),
                                                            child: Table(
                                                              defaultColumnWidth:
                                                                  FixedColumnWidth(
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          40),
                                                              children: [
                                                                TableRow(
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height:
                                                                          80,
                                                                      child:
                                                                          Text(
                                                                        _order.detail ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  }),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0.0, 5.0, 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                              bottom: 10,
                                            ),
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Détails de la commande',
                                                  style: TextStyle(
                                                    color: colorblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            bottom: 10,
                                          ),
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.expand_more,
                                                color: colorblack,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  color: colorfond,
                  height: 2,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(0),
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  onPressed: (() {
                                    Scaffold.of(context).showBottomSheet(
                                        (BuildContext context) {
                                      return SizedBox(
                                        height: 315,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Expanded(
                                                  child: Text(
                                                    ' Détails du remboursement',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorBlue),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.expand_less,
                                                    size: 23,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: colorBlue,
                                              thickness: 2,
                                              height: 5,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15.0,
                                                          0.0,
                                                          15.0,
                                                          10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 10,
                                                            bottom: 10,
                                                          ),
                                                          child: const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                'MODE DE PAIEMENT',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Retrait dans le portefeuille, remboursement crée',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15.0,
                                                          0.0,
                                                          15.0,
                                                          10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 10,
                                                            bottom: 10,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              const Text(
                                                                'MONTANT',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${_order.items[0].total}  Fr',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  }),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0.0, 5.0, 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                              bottom: 10,
                                            ),
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Détails de paiement',
                                                  style: TextStyle(
                                                    color: colorblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            bottom: 10,
                                          ),
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.expand_more,
                                                color: colorblack,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  color: colorfond,
                  height: 2,
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 30,
                            bottom: 10,
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Remboursement éffectué avec succès.',
                                style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: colorfond,
                ),
              ),
            ),
            height: 40,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  // ignore: avoid_print
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Retour à la liste',
                    style: TextStyle(color: colorblack, fontSize: 16),
                  ),
                ),
                Container(
                  height: 20,
                  width: 2,
                  color: colorfond,
                ),
                TextButton(
                  // ignore: avoid_print
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProduitSimilaireScreen(
                            id: _order.items[0].product.subCategoryId)),
                  ),
                  child: const Text(
                    'Produits similiaires ',
                    style: TextStyle(color: colorblack, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
