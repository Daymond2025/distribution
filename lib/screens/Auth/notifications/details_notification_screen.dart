import 'package:dio/dio.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/notification_view.dart';
import 'package:distribution_frontend/models/notification.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/Auth/produits/produit_similaire_screen.dart';
import 'package:distribution_frontend/screens/Auth/vainqueur/note_vainqueur_screen.dart';
import 'package:distribution_frontend/screens/home_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/notification_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailsNotificationScreen extends StatefulWidget {
  const DetailsNotificationScreen({super.key, required this.notificationView});
  final NotificationView notificationView;
  @override
  State<DetailsNotificationScreen> createState() =>
      _DetailsNotificationScreenState();
}

class _DetailsNotificationScreenState extends State<DetailsNotificationScreen> {
  late NotificationS _notification;
  bool _loading = false;
  String type = '';

  Future<void> goNotification(int id) async {
    await showNotification(id);
  }

  void deleteNotif() async {
    setState(() {
      _loading = false;
    });

    ApiResponse response = await deleteNotification(widget.notificationView.id);
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
      showDialogConfirmation();
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false));
    } else if (response.message == '403') {
      errorAlert('Notification existant dans la bd');
    } else {
      errorAlert('Echec du server');
    }
  }

  Future<void> downloadImage() async {
    String url = _notification.publishStar!.picturePath;

    final tempDir = await getTemporaryDirectory();
    final path =
        '${tempDir.path}/${_notification.publishStar!.seller.firstName}.jpg';

    await Dio().download(url, path);

    // await GallerySaver.saveImage(path, albumName: 'Daymond');

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Images en cours de téléchargement!'),
      ),
    );
  }

  errorAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  confirmAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        isOverlayTapDismiss: false,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.of(context).pop();
            deleteNotif();
          },
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Confirmé",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  successAlert(String text) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        overlayColor: Colors.black54,
        isOverlayTapDismiss: false,
        backgroundColor: Colors.white);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _notification = widget.notificationView.notification;
    });
    goNotification(widget.notificationView.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: colorblack),
        backgroundColor: colorwhite,
        elevation: 0.95,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: colorBlue,
                borderRadius: BorderRadius.circular(36),
              ),
              child: Container(
                padding: const EdgeInsets.all(1),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  borderRadius: BorderRadius.circular(36),
                  color: colorwhite,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'REGIE DAYMOND',
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ],
        ),
        actions: [
          _notification.publishStar != null
              ? IconButton(
                  onPressed: () {
                    downloadImage();
                  },
                  icon: const Icon(Icons.download_outlined),
                )
              : Container(),
          IconButton(
            onPressed: () {
              _loading ? deleteNotif() : print('Patientez');
            },
            icon: const Icon(Icons.delete_outline_outlined),
          ),
        ],
      ),
      body: _loading
          ? type == 'notification'
              ? Container(
                  child: _notification.orderDetail != null
                      ? kCardCommande()
                      : kCardPubli(),
                )
              : Container(
                  child: _notification.productDetail != null
                      ? kCardVente()
                      : kCardImage(),
                )
          : const Center(
              child: CircularProgressIndicator(
              color: colorYellow,
            )),
    );
  }

  SizedBox kCardCommande() => SizedBox(
        height: MediaQuery.of(context).size.height - 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: colorwhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClickProduit(
                              product: _notification
                                  .orderDetail!.order.items[0].product,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(_notification.orderDetail!
                                      .order.items[0].product.images[0].img),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _notification.orderDetail!.order.items[0]
                                          .product.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: colorblack,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        _notification.orderDetail!.order
                                                .items[0].product.subTitle ??
                                            ' ',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(
                      top: 30, right: 25, left: 25, bottom: 30),
                  decoration: BoxDecoration(
                    color: colorwhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: _notification.orderDetail!.status == '3'
                              ? 'Votre commande a été validée avec succès '
                              : 'Votre commande a été annulée ',
                          style: TextStyle(color: Colors.grey.shade700),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'le ',
                              style: const TextStyle(color: Colors.blue),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${_notification.createdAtFr} à ${_notification.createdAt.substring(11, 16)}',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '.',
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                      children: const <TextSpan>[
                                        // _notification
                                        //             .orderDetail!.status ==
                                        //         '3'
                                        //     ? _notification
                                        //                 .orderDetail!.order.items[0].bonus !=
                                        //             null
                                        //         ? TextSpan(
                                        //             text:
                                        //                 'Vous bénéficiez de ${_notification.orderDetail!.order.bonus}',
                                        //             children: const <TextSpan>[
                                        //               TextSpan(
                                        //                 text: '  Fr;',
                                        //               ),
                                        //             ],
                                        //           )
                                        //         : const TextSpan()
                                        //     : const TextSpan(),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Il ne vous reste que ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${7 - (_notification.orderDetail!.order.seller.stars - ((_notification.orderDetail!.order.seller.stars / 7).floor() * 7))}',
                              style: const TextStyle(color: Colors.blue),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' étoiles ',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'pour bénéficier\n',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                      children: const <TextSpan>[
                                        TextSpan(
                                          text: ' d\'un bonus de 10000',
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '  Fr gratuitement.',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.zero,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorwhite,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Retour à la liste',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorvalid,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Voir les détailles',
                            style: TextStyle(
                              fontSize: 15,
                              color: colorwhite,
                            ),
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
      );

  SingleChildScrollView kCardPubli() => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteVainqueurScreen(),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    '7 étoiles',
                    style: TextStyle(color: colorYellow2, fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: colorwhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                image: DecorationImage(
                                  image: NetworkImage(_notification
                                          .publishStar!.seller.picture ??
                                      imgUserDefault),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    '${_notification.publishStar!.seller.firstName} ${_notification.publishStar!.seller.lastName}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 25),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 30,
                                    color: Color(0xFFFF9700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'FELICITAION à M/Mme ${_notification.publishStar!.seller.firstName} ${_notification.publishStar!.seller.lastName} qui bénéficie gratuitement d\'un bonus de 10.000  Fr. Bonus Titulaire de ${(_notification.publishStar!.seller.stars / 7).floor()} x 7 étoiles équivalant à ${(_notification.publishStar!.seller.stars / 7).floor() * 7} marchés enregistrés Bonus total reçu = ${(_notification.publishStar!.seller.stars / 7).floor() * 10000}  Fr',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                            image: NetworkImage(
                              _notification.publishStar!.picturePath,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${_notification.publishStar!.nbView} vues',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: colorYellow2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Voir les heureux gagnant',
                    style: TextStyle(
                      color: colorwhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Container kCardProduit() => Container(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                                color: Colors.grey.shade400,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  _notification.detail ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _notification.productDetail != null
                                  ? Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: const Text(
                                            'Nombre de pièces disponible : ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _notification.productDetail!.quantity
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            image: const DecorationImage(
                              image: NetworkImage(iconDaymond),
                              fit: BoxFit.contain,
                            ),
                            color: colorYellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClickProduit(
                            product: _notification.productDetail!.product,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(1, 1),
                            color: Colors.grey.shade400,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(_notification
                                    .productDetail!.product.images[0].img),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    _notification.productDetail!.product.name,
                                    style: const TextStyle(
                                      color: colorblack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  _notification
                                          .productDetail!.product.subTitle ??
                                      '',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${_notification.productDetail!.product.price.price}  Fr',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
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
            Container(
              padding: EdgeInsets.zero,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorwhite,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Retour à la liste',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProduitSimilaireScreen(
                                  id: _notification
                                      .productDetail!.product.subCategoryId),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorYellow,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Produits similaires',
                            style: TextStyle(
                              fontSize: 18,
                              color: colorwhite,
                            ),
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
      );

  Container kCardImage() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: const BoxDecoration(
            color: colorwhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _notification.detail != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        _notification.detail ?? '',
                        style: const TextStyle(
                          color: colorblack,
                          fontSize: 19,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  color: colorwhite,
                  image: DecorationImage(
                    image: NetworkImage(_notification.picturePath ?? ''),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  SingleChildScrollView kCardVente() => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colorwhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              _notification.detail != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(_notification.detail ?? ''),
                    )
                  : Container(),
              _notification.productDetail != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Nombre dans le stock : ${_notification.productDetail!.quantity}',
                      ),
                    )
                  : Container(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      color: colorwhite,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClickProduit(
                                  product: _notification.productDetail!.product,
                                ),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                      ),
                                      child: Image.network(
                                        _notification.productDetail!.product
                                            .images[0].img,
                                        height: 90,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          _notification
                                              .productDetail!.product.name,
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
                                              '${_notification.productDetail!.product.price.price}  Fr',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.zero,
                                            child: Text(
                                              _notification.productDetail!
                                                  .product.reducedPrice
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.lineThrough,
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
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 2,
                          bottom: 2,
                        ),
                        decoration: const BoxDecoration(
                          color: colorYellow,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          _notification.productDetail!.product.state.name,
                          style: const TextStyle(
                            color: colorblack,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Future showDialogConfirmation() => showDialog(
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
                  SizedBox(
                    height: 170,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: colorvalid,
                          size: 60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Notification supprimée',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: colorYellow2,
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorwhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
