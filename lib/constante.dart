import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/newscreens/articleComp/article_comp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

// ROUTe-------------------------------------------------
const baseURLm = 'http://192.168.1.12:8000/api/v2/';
const baseURL = 'https://v2.daymondboutique.com/api/v2/';

const site = 'https://v2.daymondboutique.com';

// ERROr-------------------------
const serverError = 'Erreur du server';
const unauthorized = 'Pas autorisé';
const somethingWentWrong = 'Quelque chose s\'est mal passé, réessayez!';

const MESSAGE_SIMPLE = 'simple';
const MESSAGE_ORDER = 'order';
const MESSAGE_PRODUCT = 'product';

//colors
const colorBlue = Color.fromRGBO(2, 133, 254, 1);
const colorBlue100 = Color.fromRGBO(218, 239, 255, 1);
const colorwhite = Color.fromARGB(255, 255, 255, 255);
const colorblack = Color.fromARGB(235, 14, 13, 13);
const colorYellow = Color.fromRGBO(255, 192, 0, 1);
const colorYellow2 = Color.fromRGBO(255, 151, 0, 1);
const colorYellow3 = Color.fromRGBO(255, 149, 0, 1);
const colorfond = Color.fromRGBO(247, 251, 254, 1);
const colorvalid = Color.fromARGB(255, 3, 153, 60);
const colorannule = Color.fromARGB(255, 221, 68, 22);
const colorattente = Color.fromARGB(255, 82, 19, 94);
const colorhistorique = Color.fromARGB(255, 105, 105, 105);

// info daymond
const whatsapp = '+2250707545252';
const smsnumber = '+2250707545252';
const callnumber = '+2250707545252';
const mailinnovat = 'contact@daymonddistribution.com';
const facebooklink = 'https://web.facebook.com/Daymonddistribution';
const instagramlink = 'https://www.instagram.com/daymond_distribution/';

//info developer
const developerName = 'TRAORE Lamine';
const developerPhoneNumber = '+2250704051152';

//operateur network
const logoOrange = '${site}assets/orange.jpg';
const logoWave = '${site}assets/wave.png';
const logoMoov = '${site}assets/moov.jpg';
const logoMtn = '${site}assets/mtn.jpg';

//operateur asset
const assetlogoOrange = 'assets/operateurs/orange.jpg';
const assetlogoWave = 'assets/operateurs/wave.png';
const assetlogoMoov = 'assets/operateurs/moov.jpg';
const assetlogoMtn = 'assets/operateurs/mtn.jpg';

//img network
const iconDaymond = '${site}assets/icon.png';
const imgUserDefault = 'https://v2.daymondboutique.com/data/images/user.png';
const imgProdDefault = '${site}assets/empty.png';
const imgEmpty = '${site}assets/empty.png';
const imgEtoile = '${site}assets/etoile.png';
const textSharing =
    '🔥 *Offre spéciale !* \n\n Découvrez notre promotion à prix réduit. Cliquez ici 👇 pour voir les photos et les bonus offert. \n\n';

String formatAmount(int amount) {
  return NumberFormat("###,###", 'en_US').format(amount).replaceAll(',', ' ');
}

//produit
InkWell produitsCard(
        BuildContext context,
        dynamic produit,
        int id,
        String nom,
        int prix,
        int? reduit,
        String etat,
        int etoile,
        String img,
        int stock,
        int disponible) =>
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClickProduit(
              product: produit,
            ),
          ),
        );
      },
      child: ArticleCompWidget(
        article: produit,
      )

      // Container(
      //   alignment: Alignment.topLeft,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: const [
      //       BoxShadow(
      //         color: Color.fromARGB(10, 158, 158, 158),
      //         blurRadius: 5,
      //         offset: Offset(1, 2),
      //       ),
      //       BoxShadow(
      //         color: Color.fromARGB(12, 158, 158, 158),
      //         blurRadius: 5,
      //         offset: Offset(2, 1),
      //       ),
      //     ],
      //     borderRadius: BorderRadius.circular(6.0),
      //   ),
      //   child: Column(
      //     children: <Widget>[
      //       Container(
      //         alignment: Alignment.topLeft,
      //         height: 20,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: <Widget>[
      //             Container(
      //               alignment: Alignment.topLeft,
      //               child: Container(
      //                 padding: const EdgeInsets.only(
      //                   top: 2,
      //                   bottom: 2,
      //                   right: 10,
      //                   left: 8,
      //                 ),
      //                 decoration: const BoxDecoration(
      //                   color: colorYellow,
      //                   borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(6),
      //                     bottomRight: Radius.circular(6),
      //                   ),
      //                 ),
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   child: Text(
      //                     etat.toString(),
      //                     style: const TextStyle(
      //                       color: colorblack,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 13.0,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             etoile == 1
      //                 ? Container(
      //                     alignment: Alignment.topRight,
      //                     padding: const EdgeInsets.all(2.0),
      //                     child: Image.asset(
      //                       'assets/images/star.png',
      //                       width: 15,
      //                     ))
      //                 : Container(),
      //           ],
      //         ),
      //       ),
      //       Stack(
      //         children: [
      //           Container(
      //             height: 170,
      //             decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 image: NetworkImage(img),
      //                 fit: BoxFit.cover,
      //                 onError: (exception, stackTrace) =>
      //                     const Icon(Icons.error),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 9.0),
      //         child: Column(
      //           children: <Widget>[
      //             Container(
      //               alignment: Alignment.centerLeft,
      //               height: 44,
      //               child: RichText(
      //                 overflow: TextOverflow.ellipsis,
      //                 maxLines: 2,
      //                 text: TextSpan(
      //                   children: [
      //                     TextSpan(
      //                       text: nom,
      //                       style: const TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 17,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Text(
      //                   '${NumberFormat("###,###", 'en_US').format(prix).replaceAll(',', ' ')} Fr  ',
      //                   style: const TextStyle(
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Text(
      //                     reduit != null && reduit != 0
      //                         ? reduit.toString()
      //                         : '',
      //                     overflow: TextOverflow.ellipsis,
      //                     textAlign: TextAlign.right,
      //                     style: const TextStyle(
      //                       decoration: TextDecoration.lineThrough,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // )

      ,
    );

InkWell produitsCarroussel(BuildContext context, dynamic produit, int id,
        String img, int? prix, int stock, int disponible) =>
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClickProduit(
              product: produit,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 5),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 70,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '${NumberFormat("###,###", 'en_US').format(prix).replaceAll(',', ' ')} Fr  ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colorBlue,
                  letterSpacing: .5,
                ),
              ),
            ),
          ],
        ),
      ),
    );

Container produitLoadingCard3x3() => Container(
      alignment: Alignment.topLeft,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 255, 255, 255),
        highlightColor: const Color.fromARGB(255, 253, 250, 250),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(10, 158, 158, 158),
                blurRadius: 5,
                offset: Offset(1, 2),
              ),
              BoxShadow(
                color: Color.fromARGB(12, 158, 158, 158),
                blurRadius: 5,
                offset: Offset(2, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(8.0),
            color: colorwhite,
          ),
        ),
      ),
    );

Container produitLoadingCarroussel() => Container(
      alignment: Alignment.topLeft,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 255, 255, 255),
        highlightColor: const Color.fromARGB(255, 253, 250, 250),
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: colorwhite,
          ),
        ),
      ),
    );

Scaffold pageChargement(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingFour(color: colorYellow, size: 50.0),
            SizedBox(
              height: 40,
            ),
            Text(
              'Chargement',
              style: TextStyle(color: colorYellow, fontSize: 22),
            ),
          ],
        ),
      ),
    );

// INPUT decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    focusColor: colorYellow,
    contentPadding: const EdgeInsets.all(10),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: colorYellow,
      ),
    ),
  );
}

InputDecoration kInputDecorationMobileMoney(String label) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    labelStyle: const TextStyle(color: Colors.black26),
    focusColor: colorBlue,
    contentPadding: const EdgeInsets.all(10),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.black12,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.black12,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: colorBlue,
      ),
    ),
  );
}

// Button decoration
TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    style: TextButton.styleFrom(
      backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
      padding: const EdgeInsets.only(top: 13, bottom: 13, right: 30, left: 30),
      minimumSize: const Size(340, 40),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}

// Button decorationa
TextButton kTextButtonCmd(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: colorYellow2,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}

// INPUT decoration commande
InputDecoration kCmdInputDecoration(String label) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    focusColor: colorYellow,
    contentPadding: const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 20,
      right: 20,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: label == 'Autre détail' ? Colors.transparent : Colors.black12,
      ),
    ),
  );
}

InputDecoration kCmdInputDecorationClone(String label) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    focusColor: colorYellow,
    contentPadding: const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 20,
      right: 20,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: colorYellow,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: colorYellow,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.black26,
      ),
    ),
  );
}

// INPUT decoration commande
Container kRessayer(BuildContext context, Function onTap) {
  return Container(
    padding: const EdgeInsets.only(top: 40),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            'Pas de connexion',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Icon(
            Icons.wifi,
            size: 100,
            color: Colors.black26,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            'Un problème de connexion s\'est produit, veillez réessayer',
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              color: Colors.black26,
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                'REESSAYEZ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

//DEV
//TRAORE Lamine
//0704051152 | 0503356512
