import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/transaction.dart';
import 'package:distribution_frontend/screens/Auth/commandes/client/details_commande_client_screen.dart';
import 'package:distribution_frontend/screens/Auth/commandes/moi/details_commande_moi.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/produit_similaire_screen.dart';
import 'package:distribution_frontend/widgets/commande_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DetailTransactionPortefeuilleScreen extends StatefulWidget {
  const DetailTransactionPortefeuilleScreen(
      {super.key, required this.transaction});

  final Transaction transaction;
  @override
  State<DetailTransactionPortefeuilleScreen> createState() =>
      _DetailTransactionPortefeuilleScreenState();
}

class _DetailTransactionPortefeuilleScreenState
    extends State<DetailTransactionPortefeuilleScreen> {
  late Transaction _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = widget.transaction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.95,
          backgroundColor: colorwhite,
          iconTheme: const IconThemeData(color: Colors.black87),
          title: const Text(
            'Détail de transaction',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 50),
        child: Column(
          children: [
            _transaction.type == 'commission'
                ? CommissionCard(transaction: _transaction)
                : WithdrawalCard(transaction: _transaction)
          ],
        ),
      ),
      bottomSheet: _transaction.type == 'withdrawal'
          ? Container(
              padding: EdgeInsets.zero,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: const Text(
                          'Retour à la liste',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.zero,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Retour à la liste',
                          style: TextStyle(fontSize: 18),
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
                              id: _transaction
                                      .order?.items[0].product.subCategoryId ??
                                  0),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'Produits similaires',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class WithdrawalCard extends StatelessWidget {
  const WithdrawalCard({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: colorwhite,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: const Icon(
                  Icons.check_circle_outline_outlined,
                  color: colorvalid,
                  size: 72,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Retrait effectué',
                  style: TextStyle(
                    color: colorvalid,
                    fontSize: 22,
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'MONTANT RETIRER \n${NumberFormat("###,###", 'en_US').format(transaction.amount).replaceAll(',', ' ')}  Fr',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'NUMERO DE TELEPHONE \n${transaction.phoneNumber}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'REFERENCE DU RETRAIT \n${transaction.reference}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 40,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            transaction.operator == 'Orange'
                                ? assetlogoOrange
                                : transaction.operator == 'Mtn'
                                    ? assetlogoMtn
                                    : transaction.operator == 'Moov'
                                        ? assetlogoMoov
                                        : assetlogoWave,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Rétiré le ${transaction.updatedAtFr} à ${transaction.updatedAt.substring(11, 16)}',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CommissionCard extends StatelessWidget {
  const CommissionCard({super.key, required this.transaction});
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClickProduit(
                product: transaction.order!.items[0].product,
              ),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: colorwhite,
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: colorwhite,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  transaction.order!.items[0].product.images[0],
                                ),
                                fit: BoxFit.contain,
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
                                    transaction.order!.items[0].product.name,
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
                                        '${formatAmount(transaction.order!.items[0].product.price.price)} Fr',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      transaction.order!.items[0].product.star == 1
                          ? const Icon(
                              Icons.star,
                              color: colorYellow,
                              size: 20,
                            )
                          : Container(),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 2,
                          bottom: 2,
                        ),
                        decoration: const BoxDecoration(
                          color: colorYellow,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          transaction.order!.items[0].product.state.name,
                          style: const TextStyle(
                            color: colorblack,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
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
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: colorwhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: const Text(
                  'Félication votre commande a été effectué avec succès',
                  style: TextStyle(
                    color: colorvalid,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CommandeItem(
                titre: 'Quantité',
                valeur: '0${transaction.order!.items[0].quantity}',
              ),
              const SizedBox(
                height: 10,
              ),
              //grossiste
              CommandeItem(
                titre: 'Prix ',
                valeur:
                    '${formatAmount(transaction.order!.items[0].product.price.price)}  Fr',
              ),
              const SizedBox(
                height: 10,
              ),
              CommandeItem(
                titre: 'Prix d\'achat unitaire',
                valeur:
                    '${formatAmount(transaction.order!.items[0].price)}  Fr',
              ),
              const SizedBox(
                height: 10,
              ),
              if (transaction.order!.items[0].quantity == 1) ...[
                CommandeItem(
                    titre: 'Prix d\'achat des produits',
                    valeur:
                        '${formatAmount(transaction.order!.items[0].price * transaction.order!.items[0].quantity)} Fr'),
                const SizedBox(
                  height: 10,
                ),
              ],

              CommandeItem(
                titre: 'Frais de livraison',
                valeur:
                    '${NumberFormat("###,###", 'en_US').format(transaction.order!.items[0].totalFees).replaceAll(',', ' ')}  Fr',
              ),
              const SizedBox(
                height: 10,
              ),
              transaction.order!.items[0].product.type == 'grossiste'
                  ? CommandeItem(
                      titre: 'Revenu total',
                      valeur:
                          '${NumberFormat("###,###", 'en_US').format(transaction.order!.items[0].orderCommission).replaceAll(',', ' ')}  Fr',
                    )
                  : Container(),
              transaction.order!.items[0].product.type == 'grossiste'
                  ? const SizedBox(
                      height: 10,
                    )
                  : Container(),
              transaction.order!.items[0].product.type == 'grossiste'
                  ? CommandeItem(
                      titre:
                          '${transaction.order!.items[0].percentage}% du revenu total',
                      valeur:
                          '${NumberFormat("###,###", 'en_US').format(transaction.order!.items[0].sellerCommission).replaceAll(',', ' ')}  Fr',
                    )
                  : Container(),
              transaction.order!.items[0].product.type == 'grossiste'
                  ? const SizedBox(
                      height: 30,
                    )
                  : Container(),

              transaction.order!.items[0].product.type == 'commission'
                  ? CommandeItem(
                      titre: 'Commission',
                      valeur:
                          '${NumberFormat("###,###", 'en_US').format(transaction.order!.items[0].sellerCommission).replaceAll(',', ' ')}  Fr',
                    )
                  : Container(),
              transaction.order!.items[0].product.type == 'commission'
                  ? const SizedBox(
                      height: 30,
                    )
                  : Container(),
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Vous bénéficiez de ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: colorvalid,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${NumberFormat("###,###", 'en_US').format(transaction.order!.items[0].sellerCommission).replaceAll(',', ' ')}  Fr',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: colorvalid,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              /*transaction.order!.items[0].product.star == 1
                  ? const Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            'NOMBRE D\'ETOILES',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.star,
                            color: colorYellow,
                          ),
                        ),
                      ],
                    )
                  : Container(),*/
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsCommandeClientScreen(
                  order: transaction.order!,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: colorwhite,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            child: const Text(
              'Historique de la commande',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
