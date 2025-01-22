import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class DetailTrocClientScreen extends StatefulWidget {
  const DetailTrocClientScreen({super.key, required this.commande});
  final dynamic commande;
  @override
  State<DetailTrocClientScreen> createState() => _DetailTrocClientScreenState();
}

class _DetailTrocClientScreenState extends State<DetailTrocClientScreen> {
  dynamic _order = '';
  List<dynamic> _troc = [];

  @override
  void initState() {
    _order = widget.commande;
    _troc = _order['troc']['trocphotos'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: const Text(
                  'Produit à troquer',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 4,
                child: Divider(
                  color: Colors.grey[350],
                  thickness: 2,
                  height: 5,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.only(
              right: 1,
              left: 1,
            ),
            decoration: const BoxDecoration(
              color: colorwhite,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: colorwhite,
                            ),
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'PHOTOS REELLES',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: colorblack),
                                ),
                                SizedBox(
                                  width: 140,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: _troc
                      .map(
                        (e) => Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 15,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: colorwhite,
                                ),
                                child: Image.network(
                                  e['photo'],
                                  height: 90,
                                  width: 70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          _order['troc']['num_categorie_product_troc'] == 1
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: colorwhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 4.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Marque: ${_order['troc']['marque_product_troc']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Série: ${_order['troc']['serie_product_troc']}',
                                      style: const TextStyle(
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
                        color: colorwhite,
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Disque dure: ${_order['troc']['disque_product_troc']} GB',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Ram: ${_order['troc']['ram_product_troc']} GB',
                                      style: const TextStyle(
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
                        decoration: const BoxDecoration(
                          color: colorwhite,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Taille d\'écran: ${_order['troc']['taille_product_troc']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Durée de la batterie: ${_order['troc']['autonomie_product_troc']}',
                                      style: const TextStyle(
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
                    ],
                  ),
                )
              : _order['troc']['num_categorie_product_troc'] == 2
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: colorwhite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 0.0, 15.0, 10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Marque: ${_order['troc']['marque_product_troc']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Modèle: ${_order['troc']['modele_product_troc']}',
                                          style: const TextStyle(
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
                            color: colorwhite,
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 0.0, 15.0, 10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Année: ${_order['troc']['annee_product_troc']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Transmission: ${_order['troc']['transmission_product_troc']}',
                                          style: const TextStyle(
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
                            decoration: const BoxDecoration(
                              color: colorwhite,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 0.0, 15.0, 10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Carburant: ${_order['troc']['carburant_product_troc']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Kilométrage: ${_order['troc']['kilometrage_product_troc']}',
                                          style: const TextStyle(
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
                        ],
                      ),
                    )
                  : Container(),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 1, right: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorwhite,
            ),
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: const Text(
                    'Autres détails',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: _order['troc']['detail'] == null
                      ? const Text(
                          'Aucun détail ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          _order['troc']['detail'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorwhite,
            ),
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 5,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: const Text(
                    'Détails de la livraison',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 1,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Nom',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorblack,
                                    fontWeight: FontWeight.w500),
                              ),
                              _order['troc']['status_personne'] == 1
                                  ? Text(
                                      _order['troc']['nom_client'].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(
                                      '${_order['vendeur']['prenom']} ${_order['vendeur']['nom']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Livraison',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorblack,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _order['troc']['lieu_livraison'].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Contact 1',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorblack,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/images/ci.png',
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _order['troc']['contact1'].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Contact 2',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorblack,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/images/ci.png',
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _order['troc']['contact2'].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Date de livraison',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorblack,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _order['troc']['date_livraison'].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Heure de livraison',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorblack,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _order['troc']['heure_livraison'].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: const Text(
                  'Ajout sur le produit',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 4,
                child: Divider(
                  color: Colors.grey[350],
                  thickness: 2,
                  height: 5,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: colorwhite,
            ),
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: const Text(
                            'Montant du troc',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            '${_order['troc']['montant_troc']} F CFA',
                            style: const TextStyle(
                                fontSize: 16,
                                color: colorblack,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: const Text(
                            'Frais de livraison',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            '${_order['troc']['frais_lieu_livraison']} F CFA',
                            style: const TextStyle(
                                fontSize: 16,
                                color: colorblack,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: const Divider()),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: const Text(
                            'Total à payer',
                            style: TextStyle(
                                fontSize: 16,
                                color: colorblack,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            '${_order['troc']['total']} F CFA',
                            style: const TextStyle(
                                fontSize: 16,
                                color: colorYellow2,
                                fontWeight: FontWeight.w500),
                          ),
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
    );
  }
}
