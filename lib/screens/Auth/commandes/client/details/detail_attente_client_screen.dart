import 'package:distribution_frontend/models/order.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:intl/intl.dart';

//detail attente
class DetailAttenteClientScreen extends StatefulWidget {
  const DetailAttenteClientScreen({super.key, required this.commande});
  final dynamic commande;

  @override
  State<DetailAttenteClientScreen> createState() =>
      _DetailAttenteClientScreenState();
}

class _DetailAttenteClientScreenState extends State<DetailAttenteClientScreen> {
  late Order _order;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _order = widget.commande;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Table(
              defaultColumnWidth:
                  FixedColumnWidth(MediaQuery.of(context).size.width - 40),
              border: TableBorder.all(
                color: colorfond,
                style: BorderStyle.solid,
                width: 1,
              ),
              children: [
                const TableRow(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Commande en attente',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            _order.pending!.reason ?? '',
                            style:
                                const TextStyle(fontSize: 18, color: colorBlue),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    maxChildSize: 0.8,
                    minChildSize: 0.3,
                    expand: false,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Expanded(
                                    child: SizedBox(
                                        child: Text(
                                      '   Formulaire de la demande',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: colorblack,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: colorfond,
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
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                child: Text(
                                  _order.createdAtFr,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  right: 10,
                                  left: 10,
                                ),
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 25),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: colorwhite,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Détail de la commande',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                width: 50,
                                                child: const Divider(),
                                              ),
                                              //taille
                                              _order.items[0].size != null
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 6),
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 8,
                                                            child: Text(
                                                              'Taille du produit',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(_order
                                                                .items[0].size
                                                                .toString()),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              //couleur
                                              _order.items[0].color != null
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 6),
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 8,
                                                            child: Text(
                                                              'Couleur du produit',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(_order
                                                                .items[0]
                                                                .color!),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              //quantite
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        'Quantité',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          '${_order.items[0].quantity} pieces'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //quantite
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        'Prix unitaire du produit',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          '${NumberFormat("###,###", 'en_US').format(_order.items[0].price).replaceAll(',', ' ')}  Fr'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Livraiosn
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        'Livraison ${_order.delivery.city}',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        '${NumberFormat("###,###", 'en_US').format(_order.items[0].totalFees).replaceAll(',', ' ')}  Fr',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: const Divider(),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        'SOMME TOTAL',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        '${NumberFormat("###,###", 'en_US').format(_order.items[0].total).replaceAll(',', ' ')}  Fr',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: colorBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 7),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 25),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: colorwhite,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Détail de la livraison',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                width: 50,
                                                child: const Divider(),
                                              ),
                                              //nom & livraison
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Nom',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            _order.client.name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Livraison',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            _order.delivery.city
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //contact1 & contact2
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Contact 1',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            '+225 ${_order.client.phoneNumber}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Contact 2',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            '...',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //contact1 & contact2
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Date de livraiosn',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            _order
                                                                .delivery.date,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Heure de livraison',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            _order.delivery.time
                                                                .substring(
                                                                    0, 5),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54,
                                                            ),
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

                                        //motif
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorwhite,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        20),
                                            border: TableBorder.all(
                                              color: colorwhite,
                                              style: BorderStyle.solid,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              width: 1,
                                            ),
                                            children: [
                                              TableRow(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            20,
                                                        height: 30,
                                                        child: const Text(
                                                          'Autres détails',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: const Divider(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      _order.detail ?? '',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: colorannule),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                      );
                    }),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 1,
                vertical: 15,
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 204, 244, 255),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                      flex: 6,
                      child: Text(
                        'Formulaire de la commande',
                        style: TextStyle(
                          fontSize: 18,
                          color: colorblack,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        _order.updatedAtFr,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
          _order.inProgress!.time != null
              ? const SizedBox(
                  height: 10,
                )
              : Container(),
          _order.inProgress!.time != null
              ? InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      builder: (context) => DraggableScrollableSheet(
                          initialChildSize: 0.50,
                          maxChildSize: 0.5,
                          minChildSize: 0.28,
                          expand: false,
                          builder: (context, scrollController) {
                            return SingleChildScrollView(
                              controller: scrollController,
                              child: Container(
                                height: 405,
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            width: 15,
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                              child: Text(' Mise en cours',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: colorblack,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 50),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      decoration: const BoxDecoration(
                                        color: colorfond,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                78, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                75, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(2, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        _order.inProgress!.time ?? '10:10',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10,
                                          ),
                                          decoration: const BoxDecoration(
                                              color: colorwhite,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      78, 158, 158, 158),
                                                  blurRadius: 5,
                                                  offset: Offset(1, 2),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      75, 158, 158, 158),
                                                  blurRadius: 5,
                                                  offset: Offset(2, 1),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      (Radius.circular(10)),
                                                  bottomRight:
                                                      (Radius.circular(10)))),
                                          child: Column(
                                            children: <Widget>[
                                              Table(
                                                defaultColumnWidth:
                                                    FixedColumnWidth(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40),
                                                border: TableBorder.all(
                                                  color: colorwhite,
                                                  style: BorderStyle.solid,
                                                  width: 1,
                                                ),
                                                children: [
                                                  const TableRow(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  'Les motifs de la mise en cours',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color:
                                                                          colorBlue),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              _order.inProgress!
                                                                      .reason ??
                                                                  '',
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .grey),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 204, 244, 255),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                            flex: 6,
                            child: Text(
                              'Mise en cours',
                              style: TextStyle(
                                fontSize: 18,
                                color: colorblack,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              _order.inProgress!.time!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
