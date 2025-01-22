import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/transaction.dart';
import 'package:distribution_frontend/models/wallet.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/detail_transaction_portefeuille_screen.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_retrait_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/transaction_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

class PortefeuilleScreen extends StatefulWidget {
  const PortefeuilleScreen({super.key});

  @override
  State<PortefeuilleScreen> createState() => _PortefeuilleScreenState();
}

class _PortefeuilleScreenState extends State<PortefeuilleScreen> {
  WalletService walletService = WalletService();
  late Wallet _wallet;
  List<Transaction> _transactions = [];
  bool _loading = true;

  bool _noCnx = false;
  int somme = 0;

  //portefeuille
  Future<void> wallet() async {
    ApiResponse response = await walletService.getWallet();
    if (response.error == null) {
      dynamic data = response.data;

      setState(() {
        _wallet = Wallet.fromJson(data['wallet']);

        if (data.containsKey('transactions') && data['transactions'] is List) {
          _transactions = (data['transactions'] as List)
              .map((item) => Transaction.fromJson(item))
              .toList();
        } else {
          _transactions = [];
        }

        _loading = false;
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

  //show transaction
  Future<void> showUserTransaction(Transaction transaction) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailTransactionPortefeuilleScreen(transaction: transaction),
      ),
    );
  }

  int nbbyDate(String date) {
    int nb = 0;
    if (_transactions.isNotEmpty) {
      for (var element in _transactions) {
        if (element.updatedAt.substring(0, 10) == date) {
          nb += 1;
        }
      }
    }
    return nb;
  }

  chargementAlert() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
      status: 'Chargement...',
      dismissOnTap: false,
    );
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null);
    wallet();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(300),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: colorBlue,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 120,
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(36, 158, 158, 158),
                                    blurRadius: 5,
                                    offset: Offset(1, 2),
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(54, 158, 158, 158),
                                    blurRadius: 5,
                                    offset: Offset(2, 1),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  //total
                                  const Positioned(
                                    top: 15,
                                    left: 20,
                                    child: Text(
                                      'Total',
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 20,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      width: MediaQuery.of(context).size.width -
                                          90,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                formatAmount(
                                                    _wallet.amount ?? 0),
                                                style: const TextStyle(
                                                  color: colorBlue,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                alignment: Alignment.bottomLeft,
                                                child: const Text(
                                                  '    Fr',
                                                  style: TextStyle(
                                                    color: colorBlue,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          _wallet.amount > 0
                                              ? InkWell(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PortefeuilleRetraitScreen(
                                                              amount: _wallet
                                                                  .amount),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: colorBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Text(
                                                      '- Retrait',
                                                      style: TextStyle(
                                                          color: colorwhite),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                  //date dernier transaction
                                ],
                              ),
                            ),
                          ),
                        ),
                        //back
                        Positioned(
                          top: 30,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              color: colorwhite,
                            ),
                          ),
                        ),
                        //image user
                        Positioned(
                          top: 50,
                          right: 25,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: colorwhite,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      _wallet.entity.picture ?? imgUserDefault),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                        Positioned(
                          left: 30,
                          top: 120,
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/portefeuille.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'SOLDES',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   padding: const EdgeInsets.fromLTRB(15, 10, 5, 15),
                    //   child: const Text(
                    //     'TRANSACTIONS',
                    //     style: TextStyle(
                    //       height: 50,
                    //       wid
                    //       color: Colors.white,
                    //       backgroundColor: Colors.black,

                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            // body: Container(
            //   padding: EdgeInsets.symmetric(
            //       vertical: _transactions.isEmpty ? 105 : 0, horizontal: 8),
            //   child: !_loading
            //       ? _transactions.isNotEmpty
            //       ? GroupedListView<dynamic, String>(
            //       elements: _transactions,
            //       groupBy: (element) =>
            //           element.updatedAt.substring(0, 10),
            //       order: GroupedListOrder.DESC,
            //       useStickyGroupSeparators: false,
            //       groupSeparatorBuilder: (String groupByValue) {
            //         DateTime date = DateTime.parse(groupByValue);
            //         String formattedDate =
            //         DateFormat.yMMMMEEEEd('fr_FR').format(date);

            //         return Container(
            //           padding: const EdgeInsets.only(bottom: 5, top: 5),
            //           child: Row(
            //             mainAxisAlignment:
            //             MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 formattedDate.toString(),
            //                 style: const TextStyle(
            //                   color: Colors.black87,
            //                   fontWeight: FontWeight.w400,
            //                   fontSize: 16,
            //                 ),
            //               ),
            //               Text(
            //                 nbbyDate(groupByValue).toString(),
            //                 style: const TextStyle(
            //                   color: Colors.black87,
            //                   fontWeight: FontWeight.w400,
            //                   fontSize: 16,
            //                 ),
            //               )
            //             ],
            //           ),
            //         );
            //       },
            //       itemBuilder: (context, element) {
            //         return kCardTransaction(
            //             element,
            //             element.type == 'withdrawal'
            //                 ? element.operator == 'Mtn'
            //                   ? logoMtn
            //                   : element.operator == 'Moov'
            //                     ? logoMoov
            //                     : element.operator == 'Orange'
            //                       ? logoOrange
            //                       : logoWave
            //                     : element.order!.items[0].product.images[0],
            //             );
            //       })
            //       : Center(
            //     child: Column(
            //       children: [
            //         Image.asset(
            //           'assets/images/pas_transaction.png',
            //           height: 120,
            //           width: 120,
            //         ),
            //         const Text(
            //           'Aucune transaction récente',
            //           style: TextStyle(color: colorattente),
            //         ),
            //         const SizedBox(
            //           height: 3,
            //         ),
            //         const Text(
            //             'Effectuez des ventes et gagnez'
            //           ),
            //           const Text(
            //             'beaucoup plus d\'argent'
            //           )
            //       ],
            //     ),
            //   )
            //       : Shimmer.fromColors(
            //     baseColor: const Color.fromARGB(255, 255, 255, 255),
            //     highlightColor: const Color.fromARGB(255, 236, 235, 235),
            //     child: Container(
            //       height: 55,
            //       width: MediaQuery.of(context).size.width,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8.0),
            //         color: colorwhite,
            //       ),
            //     ),
            //   ),
            // ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: _transactions.isEmpty ? 105 : 0,
                horizontal: 8,
              ),
              child: !_loading
                  ? _transactions.isNotEmpty
                      ? GroupedListView<dynamic, String>(
                          elements: _transactions,
                          groupBy: (element) =>
                              element['updatedAt'].substring(0, 10),
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: false,
                          groupSeparatorBuilder: (String groupByValue) {
                            DateTime date = DateTime.parse(groupByValue);
                            String formattedDate =
                                DateFormat.yMMMMEEEEd('fr_FR').format(date);

                            return Container(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedDate.toString(),
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    nbbyDate(groupByValue).toString(),
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          itemBuilder: (context, element) {
                            return kCardTransaction(
                                element,
                                element['type'] == 'withdrawal'
                                    ? element['operator'] == 'Mtn'
                                        ? logoMtn
                                        : element['operator'] == 'Moov'
                                            ? logoMoov
                                            : element['operator'] == 'Orange'
                                                ? logoOrange
                                                : logoWave
                                    : logoWave);
                          })
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/pas_transaction.png',
                                height: 120,
                                width: 120,
                              ),
                              const Text(
                                'Aucune transaction récente',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 3),
                              const Text('Effectuez des ventes et gagnez'),
                              const Text('beaucoup plus d\'argent')
                            ],
                          ),
                        )
                  : Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 255, 255, 255),
                      highlightColor: const Color.fromARGB(255, 236, 235, 235),
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          );
  }

  InkWell kCardTransaction(Transaction transaction, String image) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          showUserTransaction(transaction);
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: colorwhite,
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: colorBlue100,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //gain
              Expanded(
                flex: 10,
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.type == 'commission'
                            ? 'Commission'
                            : 'Rétrait',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        transaction.updatedAtFr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomRight,
                  height: 50,
                  child: Text(
                    '${formatAmount(transaction.amount)} ',
                    style: TextStyle(
                      color: transaction.type == 'commission'
                          ? colorvalid
                          : Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
