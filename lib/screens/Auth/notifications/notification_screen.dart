import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/notification_view.dart';
import 'package:distribution_frontend/screens/Auth/notifications/details_notification_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/notification_service.dart';
import 'package:distribution_frontend/services/user_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NotificationScreen1 extends StatefulWidget {
  const NotificationScreen1({super.key});
  static const routeName = '/notification';

  @override
  State<NotificationScreen1> createState() => _NotificationScreen1State();
}

class _NotificationScreen1State extends State<NotificationScreen1> {
  List<NotificationView> _notifications = [];
  bool _loading = false;
  bool _noCnx = false;

  Future<void> allNotifications() async {
    ApiResponse response = await getNotifications();
    if (response.error == null) {
      setState(() {
        _notifications = response.data as List<NotificationView>;
        _loading = true;
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
        _loading = true;
      });
    }
  }

  chargementAlert() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
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
    // TODO: implement initState
    super.initState();
    allNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorfond,
      appBar: AppBar(
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0.9,
      ),
      body: !_noCnx
          ? _loading
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: _notifications.isNotEmpty
                        ? _notifications
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsNotificationScreen(
                                                notificationView: e),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: e.view == 1
                                          ? colorwhite
                                          : colorBlue100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 5),
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/logo.png'),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: colorwhite,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.notification.publishStar !=
                                                        null
                                                    ? '7 Etoiles'
                                                    : e.notification.name ??
                                                        'ETOILE',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              e.notification.orderDetail != null
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            e.notification.orderDetail!
                                                                        .status ==
                                                                    '3'
                                                                ? 'Votre commande à été validée'
                                                                : 'Votre commande a été annulée',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: e.notification.orderDetail!
                                                                            .status ==
                                                                        '3'
                                                                    ? colorvalid
                                                                    : colorannule,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                        Text(
                                                          e.createdAtFr,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    )
                                                  : e.notification
                                                              .publishStar !=
                                                          null
                                                      ? Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${e.notification.publishStar!.seller.firstName} ${e.notification.publishStar!.seller.lastName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color:
                                                                        colorblack,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                            ),
                                                            Text(
                                                              e.createdAtFr,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            )
                                                          ],
                                                        )
                                                      : e.notification
                                                                  .productDetail !=
                                                              null
                                                          ? Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    e.notification
                                                                            .detail ??
                                                                        'Produit ${e.notification.productDetail!.product.name}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        color:
                                                                            colorblack,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  e.createdAtFr,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    e.notification
                                                                            .detail ??
                                                                        '',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        color:
                                                                            colorblack,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  e.createdAtFr,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )
                                                              ],
                                                            ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()
                        : [
                            Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height - 100,
                              child: const Text('Pas de notifiattions!'),
                            ),
                          ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )
          : kRessayer(context, () {
              setState(() {
                _loading = false;
              });
              allNotifications();
            }),
    );
  }
}
