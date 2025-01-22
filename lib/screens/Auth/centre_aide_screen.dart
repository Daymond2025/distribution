import 'package:distribution_frontend/constante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CentreAideScreen extends StatefulWidget {
  const CentreAideScreen({super.key});

  @override
  State<CentreAideScreen> createState() => _CentreAideScreenState();
}

class _CentreAideScreenState extends State<CentreAideScreen> {
  int page = 1;
  bool loading = false;

  _launchURLVendre() async {
    const url = 'https://youtu.be/ora27t7Hy_E';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }

  _launchURLPointCles() async {
    const url = 'https://bit.ly/3LDHoBI';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: page == 2
          ? AppBar(
              backgroundColor: colorblack,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    page = 1;
                  });
                },
                color: colorwhite,
              ),
              title: const Text(
                'COMMENT FONCTIONNE L\'OFFRE DAYMOND ?',
                style: TextStyle(color: colorwhite, fontSize: 16),
              ),
            )
          : AppBar(
              backgroundColor: colorwhite,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                color: colorblack,
              ),
              title: const Text(
                'Centre d\'aide',
                style: TextStyle(color: colorblack),
              ),
            ),
      body: page == 1
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/assistant.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      scale: 2.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        top: 8,
                        bottom: 8,
                      ),
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(242, 243, 247, 100),
                      ),
                      child: InkWell(
                        onTap: () async {
                          String phone = whatsapp;
                          String url =
                              "whatsapp://send?phone=$phone&text=bonjour...";
                          // ignore: deprecated_member_use
                          await canLaunch(url)
                              // ignore: deprecated_member_use
                              ? launch(url)
                              // ignore: avoid_print
                              : print('Whatsapp non ouvert');
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.message),
                            Text(
                              'Entrez votre message',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Text(''),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'QUESTIONS COURANTES',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        top: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(122, 215, 224, 231),
                            width: 2,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            page = 2;
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Comment fonctionne l’offre daymond',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '? ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        top: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(122, 215, 224, 231),
                            width: 2,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Signification7EtoileShowmodal(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Que signifie les 7 Etoiles de daymond',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '? ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        top: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(122, 215, 224, 231),
                            width: 2,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          EtrePayershowMyModal(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Comment être rémunéré ?',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '? ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        top: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(122, 215, 224, 231),
                            width: 2,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          _launchURLVendre();

                          setState(() {
                            loading = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            loading
                                ? const CupertinoActivityIndicator(
                                    color: colorwhite)
                                : const Text(
                                    'Comment vendre les produits daymond',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                            const FaIcon(
                              FontAwesomeIcons.youtube,
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        top: 10,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(122, 215, 224, 231),
                            width: 2,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          _launchURLPointCles();

                          setState(() {
                            loading = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            loading
                                ? const CupertinoActivityIndicator(
                                    color: colorwhite)
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Les 5 points clés pour devenir un',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'pro sur daymond distribution',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                            const FaIcon(
                              FontAwesomeIcons.youtube,
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            )
          : page == 2
              ? const FonctionnementOffre()
              : Container(),
    );
  }
}

class FonctionnementOffre extends StatefulWidget {
  const FonctionnementOffre({super.key});

  @override
  State<FonctionnementOffre> createState() => _FonctionnementOffreState();
}

class _FonctionnementOffreState extends State<FonctionnementOffre> {
  void introDaymondshowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 510,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'INTRODUCTION DAYMOND',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Daymond est une société de marketing et de distribution qui a pour mission la distribution de divers produits partout dans le monde.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Elle utilise le digital pour faciliter la communication et la distribution de ses produits et services.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Dans ces canaux de distribution, nous y trouvons l’application Daymond Distribution. ',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Daymond Distribution est une plateforme d’exposition de produit au prix de grossiste, elle donne la possibilité aux revendeurs de naviguer dans une vaste panoplie de produits à des prix extrêmement bas, ce qui leur permet de revendre et de profiter d’un bénéfice plus élevé que la norme.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Tout le monde est habilité a travailler sur daymond et cela quelque soit votre localision.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          'Daymond distribution est une application totalement gratuite, car il y’a rien à payer à l’installation, rien à payer à l’inscription et rien à payer au retrait de vos commissions.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          'Vous ne paierez jamais de frais pour quoi que ce soit sur daymond distribution.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);

                          missionshowMyModal(context);
                        },
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
  }

  void missionshowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'QUELLE EST MA MISSION ?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Votre mission est de vendre les produits distribués sur l’application daymond distribution et gagner 50% du bénéfice que vous allez ajouter sur le prix grossiste daymond. Pour accomplir vos missions sans complication nous vous recommandons de suivre les étapes ci-dessous.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          introDaymondshowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          prixDaymondshowMyModal(context);
                        },
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
  }

  void prixDaymondshowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'COMPRENDRE LES PRIX DAYMOND',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                          child: const Row(
                        children: [
                          Text('[',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorYellow2)),
                          Text('PRIX GROSSISTE UNITAIRE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                          Text(']',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorYellow2)),
                        ],
                      )),
                      Container(
                        child: const Text(
                          'Le prix grossiste unitaire représente le prix de base auquel daymond achète le produit a l’usine de production.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'En revanche il est impossible de vendre un produit au prix grossiste unitaire.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: const Row(
                        children: [
                          Text('[',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorYellow2)),
                          Text('PRIX DE VENTE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                          Text(']',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorYellow2)),
                        ],
                      )),
                      Container(
                        child: const Text(
                          'Les prix de ventes représentent la valeur du produit. Pour mieux vous situer sur la valeur du produit, daymond affiche les prix auxquels vous pouvez vendre le produit en intervalle.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: const Row(
                        children: [
                          Text(
                            'Par exemple : de ',
                            textAlign: TextAlign.left,
                          ),
                          Text('10.000',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                          Text(' à '),
                          Text('20.000',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                          Text(' CFA '),
                        ],
                      )),
                      Container(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            text:
                                'Vous devrez vendre le produit a l’un des prix de vente ou plus mais jamais en dessous du premier prix de vente qui est de ',
                            children: const <TextSpan>[
                              TextSpan(
                                text: '10.000',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' FCFA ici sur notre exemple.',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);

                          missionshowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);

                          iconeshowMyModal(context);
                        },
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
  }

  void iconeshowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 660,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'COMPRENDRE LES ICONES SUR UN PRODUIT',
                style: TextStyle(
                    fontSize: 15,
                    color: colorblack,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 204, 204, 204),
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 5,
                                    spreadRadius: .2,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {},
                              color: Colors.grey,
                              icon: const Icon(
                                size: 20,
                                Icons.download,
                              ),
                              tooltip: 'Téléchargé',
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  Container(
                                      child: const Row(
                                    children: [
                                      Text('Icône télécharge: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        'Elle vous permet d’enregistrer',
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  )),
                                  Container(
                                    child: const Text(
                                      'les images du produit dans votre galerie.',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 204, 204, 204),
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 5,
                                    spreadRadius: .2,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {},
                              color: Colors.grey,
                              icon: const Icon(
                                size: 20,
                                Icons.copy,
                              ),
                              tooltip: 'Téléchargé',
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  Container(
                                      child: const Row(
                                    children: [
                                      Text('Icône copie: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        'Pour copier l’intégralité des informa-',
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  )),
                                  Container(
                                    child: const Text(
                                      'tions du produit pour les modifier plus tard. ',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 204, 204, 204),
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 5,
                                    spreadRadius: .2,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {},
                              color: Colors.grey,
                              icon: const Icon(
                                size: 20,
                                Icons.star,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  Container(
                                      child: const Row(
                                    children: [
                                      Text('Icône ajout ax favoris: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        'Comme son nom ',
                                      ),
                                    ],
                                  )),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: const Text(
                                      'l’indique cette icône vous permet d’ajouter le ',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: const Text(
                                      'produit sur la liste de vos produits favoris pour',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: const Text(
                                      'la retrouver facilement plus tard.',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 204, 204, 204),
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 5,
                                    spreadRadius: .2,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {},
                              color: Colors.grey,
                              icon: const Icon(
                                size: 20,
                                Icons.change_circle,
                              ),
                              tooltip: 'Téléchargé',
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  Container(
                                      child: const Row(
                                    children: [
                                      Text('Icône Troc: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        'Elle vous permet d’enregistrer ',
                                      ),
                                    ],
                                  )),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: const Text(
                                      'les images du produit dans votre galerie. ',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 1,
                          right: 1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: colorfond,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    'Produit similaire',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 4,
                              child: InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Bouton Produits similaires:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          'Ce bouton vous donne accès à plusieurs autres produits du même type et de la même catégorie. ',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 1,
                          right: 1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: InkWell(
                                // ignore: avoid_print

                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: colorYellow2,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 176, 204, 253),
                                          offset: Offset(1.0, 2.0),
                                          blurRadius: 5,
                                          spreadRadius: .2,
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ]),
                                  child: const Text(
                                    'JE PASSE LA COMMANDE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 4,
                              child: InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Je passe la commande:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: const Row(
                        children: [
                          Text(
                            'Ce bouton vous permet de passer une commande  ',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      )),
                      Container(
                          child: const Row(
                        children: [
                          Text('pour votre client ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline)),
                          Text(
                            'ou',
                          ),
                          Text(' pour vous même ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline)),
                        ],
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 105,
                        margin: const EdgeInsets.only(
                          top: 5,
                        ),
                        decoration: const BoxDecoration(
                          color: colorwhite,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 1.0,
                                offset: Offset(0.0, -0.5))
                          ],
                        ),
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 204, 204, 204),
                                              offset: Offset(1.0, 2.0),
                                              blurRadius: 5,
                                              spreadRadius: .2,
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ),
                                          ]),
                                      child: IconButton(
                                        onPressed: () {
                                          print('download');
                                        },
                                        color: Colors.grey,
                                        icon: const Icon(
                                          size: 20,
                                          Icons.download,
                                        ),
                                        tooltip: 'Téléchargé',
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 204, 204, 204),
                                              offset: Offset(1.0, 2.0),
                                              blurRadius: 5,
                                              spreadRadius: .2,
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ),
                                          ]),
                                      child: IconButton(
                                        onPressed: () {
                                          print('copy');
                                        },
                                        color: Colors.grey,
                                        icon: const Icon(
                                          size: 20,
                                          Icons.copy,
                                        ),
                                        tooltip: 'Copié',
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 204, 204, 204),
                                              offset: Offset(1.0, 2.0),
                                              blurRadius: 5,
                                              spreadRadius: .2,
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ),
                                          ]),
                                      child: IconButton(
                                        onPressed: () {},
                                        color: Colors.grey,
                                        icon: const Icon(
                                          size: 20,
                                          Icons.star,
                                        ),
                                        tooltip: 'Ajouté au favorie',
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 204, 204, 204),
                                              offset: Offset(1.0, 2.0),
                                              blurRadius: 5,
                                              spreadRadius: .2,
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ),
                                          ]),
                                      child: IconButton(
                                        onPressed: () {
                                          print('troc');
                                        },
                                        color: Colors.grey,
                                        icon: const Icon(
                                          size: 20,
                                          Icons.change_circle,
                                        ),
                                        tooltip: 'Troc',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black12,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: colorfond,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Text(
                                          'Produit similaire',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: InkWell(
                                      // ignore: avoid_print

                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: colorYellow2,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 176, 204, 253),
                                                offset: Offset(1.0, 2.0),
                                                blurRadius: 5,
                                                spreadRadius: .2,
                                              ),
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 0.0,
                                                spreadRadius: 0.0,
                                              ),
                                            ]),
                                        child: const Text(
                                          'JE PASSE LA COMMANDE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            text: 'Ce ',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Tableau',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              TextSpan(
                                text:
                                    ' facilite la gestion de vos produits, avec une fonctionalité complète et simple. Il vous permet d’être plus rapide et productif, car chez daymond le temps c’est vraiment de l’argent ',
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
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          prixDaymondshowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          vendreshowMyModal(context);
                        },
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
  }

  void vendreshowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Text(
                      'COMMENT VENDRE UN PRODUIT',
                      style: TextStyle(
                          fontSize: 15,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                    SizedBox(
                        child: Text(
                      '  ?',
                      style: TextStyle(
                          fontSize: 40,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
              ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Pour vendre un produit il faut sélectionner l’un des produits distribués sur l’application daymond distribution.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Ensuite utiliser l’icône télécharger pour enregistrer les images du produit dans votre galerie.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Et l’icône copie pour copier l’intégralité des informations du produit pour les modifier plus tard.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          'A l’aide des images du produit téléchargé et les informations copiées, vous pouvez à présent les collègues et votre entourage sur WhatsApp, Facebook, Tik Tok, Instagram, les sites de vente et',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Pour vendre un produit il faut sélectionner l’un des autres moyens de communications. ',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          iconeshowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          commandershowMyModal(context);
                        },
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
  }

  void commandershowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Text(
                      'COMMENT COMMANDER UN PRODUIT',
                      style: TextStyle(
                          fontSize: 15,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                    SizedBox(
                        child: Text(
                      '  ?',
                      style: TextStyle(
                          fontSize: 40,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
              ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: RichText(
                          text: TextSpan(
                            text:
                                'Après avoir trouvé un client qui veut acheter le produit que vous avez proposé, revenez sur l’application daymond distribution, sélectionner le produit et cliquer sur le bouton',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' Je passe la commande.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    ' Ensuite suivez les instructions pour apparaitre sur le ',
                              ),
                              TextSpan(
                                text: 'Formulaire de commande.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    ' Puis renseignez les informations de votre client et cliquer sur ',
                              ),
                              TextSpan(
                                text: 'Envoyer la commande.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: ' pour terminer.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Bon à savoir: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'En sélectionnant l’option ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: 'Pour moi-même',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    ' daymond vous offre gratuitement une remise allant de ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: '5 à 80% ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    'sur le deuxième prix de vente du produit.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          ' Avec la possibilité de payer via votre portefeuille daymond ou par le moyen de paiement de votre choix.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          vendreshowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          TroqueshowMyModal(context);
                        },
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
  }

  void TroqueshowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Text(
                      'COMMENT TROQUER UN PRODUIT',
                      style: TextStyle(
                          fontSize: 15,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                    SizedBox(
                        child: Text(
                      '  ?',
                      style: TextStyle(
                          fontSize: 40,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
              ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: RichText(
                          text: TextSpan(
                            text:
                                'Pour troquer un produit rien de plus simple, sélectionnez le produit daymond. Assurez-vous que le produit est marqué ',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Troc possible',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: ' et cliquez sur l\'icône ',
                              ),
                              TextSpan(
                                text: 'Troc.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            text:
                                'Ensuite suivez les instructions pour apparaitre sur le',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' Formulaire de troc',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    ' et renseignez les informations du produit à troquer tel que: La ville du produit, la catégorie, 4 photos et 1 video réelle du produit à troquer et cliquez sur ',
                              ),
                              TextSpan(
                                text: 'Envoyer la demande',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: ' pour recevoir l\'estimation du troc.',
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
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          commandershowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          commandeclientshowMyModalBottomSheet(context);
                        },
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
  }

  void commandemoishowMyModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Text(
                      'COMMENT SUIVRE UNE COMMANDE\n                  POUR MOI-MEME',
                      style: TextStyle(
                          fontSize: 15,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                    SizedBox(
                        child: Text(
                      '  ?',
                      style: TextStyle(
                          fontSize: 40,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
              ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Le suivi de vos commandes personnelles est le même concept que celui de vos clients avec une légère différence au niveau du nom des différents états qui se présentent comme suit : ',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Row(
                          children: [
                            Text('1. Commandes en préparations',
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text(
                              ' ',
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: const Row(
                          children: [
                            Text('2. Commandes en routes',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text(
                              ' ',
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: const Row(
                          children: [
                            Text('3. Commandes terminées',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text(
                              ' ',
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: const Row(
                          children: [
                            Text('4. Commandes annulées',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text(
                              ' ',
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: ' Ces ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: '4 étapes ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    'vous permettent de suivre vos commandes en temps réel jusqu\'à réception du produit commandé.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
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
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          commandeclientshowMyModalBottomSheet(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          gestionTrocshowMyModalBottomSheet(context);
                        },
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
  }

  void commandeclientshowMyModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 560,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Text(
                      'COMMENT SUIVRE UNE COMMANDE\n                  POUR MON CLIENT',
                      style: TextStyle(
                          fontSize: 15,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                    SizedBox(
                        child: Text(
                      '  ?',
                      style: TextStyle(
                          fontSize: 40,
                          color: colorblack,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
              ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Le suivi d’une commande Pour mon client se fait à travers 6 étapes qui se présentent comme suit : ',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '1. Nouvelle commande :',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' Après avoir rempli le formulaire d’une commande et cliqué sur le bouton Envoyer la commande vous la trouverez dans l’option commande ou d’annuler la commande. ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '2. Commande en attente : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Dans cette section vous trouverez toutes vos commandes misent en attente par daymond avec les motifs de la mise en attente.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '3. Commande en cours : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Cette section affiche la liste de toutes vos commandes misent en cours par daymond.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '4. Commande validée : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Cette section vous présente la liste des commandes validées et affiche les détails du marché puis l\'argent que vous gagnez pour cette vente.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Une fois une commande validée vous recevez instantanément votre Gain dans votre portefeuille daymond.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '5. Commande annulée : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'dans cette section vous trouverez les commandes annulées par vous-même, par vos clients ou par daymond. Avec les motifs de l\'annulation de la commande.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          'Avec ces 5 étapes le suivi de vos commandes devient plus simple, pratique et facile.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          TroqueshowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                          commandemoishowMyModal(context);
                        },
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
  }

  void gestionTrocshowMyModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white,
        ),
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'GESTION D\'UN TROC',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: 'La gestion des trocs regroupe ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: '4 étapes ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: 'qui se présentent comme suit : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '1. Analyse : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Après avoir rempli le formulaire de troc et cliqué sur le bouton Envoyer la demande vous trouverez votre demande dans la section ANALYSE car daymond prend le soin d’analyser vos demandes avant d’estimer le montant du troc.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '2. Résultat : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Cette section donne la réponse de daymond après avoir analysé votre demande. Dans cette réponse vous verrez l’estimation du montant à ajouter sur votre produit pour prendre le produit daymond et autres détails liés au troc. ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '-  ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Cependant vous aurez la possibilité d’accepter, de discuter avec daymond ou d’annuler la demande du troc.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '3. Validé : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Cette section regroupe tous les trocs que vous avez accepté en cliquant sur le bouton validé.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: const TextSpan(
                            text: '4. Annulé : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Troc annulé donne la liste des trocs annulés par vous-même, par vos clients ou par daymond avec les motifs de l\'annulation du troc.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
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
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                          commandemoishowMyModal(context);
                        },
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_forward, color: Colors.grey),
                        onPressed: () {},
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(122, 215, 224, 231),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 2),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    introDaymondshowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Introduction Daymond',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Icon(
                        Icons.help_outline,
                        color: colorwhite,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    missionshowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Quelle est ma mission',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Icon(
                        Icons.help_outline,
                        color: colorwhite,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    prixDaymondshowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comprendre les prix daymond',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Text(
                        '? ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(235, 149, 156, 159),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    iconeshowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comprendre les icones sur un produit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Icon(
                        Icons.help_outline,
                        color: colorwhite,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    vendreshowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comment vendre un produit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Text(
                        '? ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(235, 149, 156, 159),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    commandershowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comment commander un produit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Text(
                        '? ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(235, 149, 156, 159),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    TroqueshowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comment troquer un produit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Text(
                        '? ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(235, 149, 156, 159),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    commandeclientshowMyModalBottomSheet(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comment suivre une commande \n    pour mon client',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Text(
                        '? ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(235, 149, 156, 159),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    commandemoishowMyModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Comment suivre une commande \n    pour moi-même',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Text(
                        '? ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(235, 149, 156, 159),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorwhite,
                ),
                child: InkWell(
                  onTap: () {
                    gestionTrocshowMyModalBottomSheet(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '    Gestion d\'un troc',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorblack,
                        ),
                      ),
                      Icon(
                        Icons.help_outline,
                        color: colorwhite,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void Signification7EtoileShowmodal(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.680,
        maxChildSize: 0.680,
        minChildSize: 0.680,
        expand: false,
        builder: (context, ScrollController) {
          return SingleChildScrollView(
            controller: ScrollController,
            child: Container(
              height: 650,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 60,
                        child: SizedBox(
                            child: Row(
                          children: [
                            Text(
                              'QUE SIGNIFIE LES 7 ETOILES DE DAYMOND ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: colorblack,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ?',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: colorblack,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                      child: const Row(
                    children: [
                      Text('Pour recompenser ses agents de vente, daymond'),
                      Text(' '),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'offre un bonus de  ',
                        textAlign: TextAlign.left,
                      ),
                      Text('10.000 FCFA ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'Gratuitement à ',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'l\'atteinte de la ',
                        textAlign: TextAlign.left,
                      ),
                      Text('7 ème commande validée. ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('Explication simple ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('1 ', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'commande validée  =   ',
                        textAlign: TextAlign.left,
                      ),
                      Text('1 Etoile  ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      )
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('3 ', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'commande validées  =   ',
                        textAlign: TextAlign.left,
                      ),
                      Text('3 Etoile  ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      )
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('7 ', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'commande validées  =   ',
                        textAlign: TextAlign.left,
                      ),
                      Text('7 Etoiles  ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: colorYellow2,
                        size: 15,
                      )
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'Ce qui vous fait gagnez un bonus de ',
                        textAlign: TextAlign.left,
                      ),
                      Text('10.000 fcfa. ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'gratuitement. ',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                          'Pour conclure une commande validée est égale à une'),
                      Text(' '),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('Etoile supplément et à l\'atteinte de la  '),
                      Text('7ème Etoile,',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('daymond vous offre gratuitement un bonus de'),
                      Text(' '),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('10.000 FCFA ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'comme récompense.',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('Attention ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.red)),
                      Text(
                        ': cette offre est valable uniquement pour les',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        '',
                      ),
                      Text(
                        'produits qui ont une Etoile.',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FonctionnementOffre()),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.pop(context);
                              EtrePayershowMyModal(context);
                            },
                          ),
                        ]),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
  );
}

void EtrePayershowMyModal(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.880,
        maxChildSize: 0.880,
        minChildSize: 0.880,
        expand: false,
        builder: (context, ScrollController) {
          return SingleChildScrollView(
            controller: ScrollController,
            child: Container(
              height: 780,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 7,
                        child: SizedBox(
                            child: Row(
                          children: [
                            Text(
                              'COMMENT ETRE REMUNERE ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: colorblack,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ?',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: colorblack,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                      child: const Row(
                    children: [
                      Text(
                          'Pour une bonne collaboration nous mettons un grand'),
                      Text(''),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'regard sur la rémunération de nos agents de vente. ',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      )
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'Dans ce sens nous partageons le bénéfice de chaque',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'produit vendu à part égale, c\'est-à-dire ',
                        textAlign: TextAlign.left,
                      ),
                      Text('50% / 50% ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('A la fin de chaque produit vendu un versement de'),
                      Text(''),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'votre commission est instantanément viré sur votre',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      )
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'portefeuille daymond, avec possibilité de retirer votre',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'argent à tout moment, quel que soit votre localisation',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'par le moyen de votre choix en envoyer une demande',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'de retrait a daymond. ',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 60,
                        child: SizedBox(
                            child: Row(
                          children: [
                            Text(
                              'COMMENT RETIRER DE L\'ARGENT',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: colorblack,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '  ?',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: colorblack,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                          'Pour retirer de l’argent de votre portefeuille vous'),
                      Text(' '),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('devez envoyer une demande de retrait a daymond en'),
                      Text(' '),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('suivant les instructions suivantes :'),
                      Text(' '),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('Etape 1 : ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        ' Allez sur votre portefeuille et cliquer sur le ',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'bouton ',
                        textAlign: TextAlign.left,
                      ),
                      Text('RETRAIT ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('Etape 2 : ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        ' Sélectionnez un  ',
                        textAlign: TextAlign.left,
                      ),
                      Text('compte mobile money ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('préenregistré ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'ou ',
                        textAlign: TextAlign.left,
                      ),
                      Text('enregistrer un nouveau compte.',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('Etape 3 : ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        ' Entrez le montant à retirer et cliquer sur  ',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text('Envoyer la demande ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        'pour finaliser. ',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: const Row(
                    children: [
                      Text('Apres réception de votre demande, daymond '),
                      Text(''),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'procède immédiatement à un virement direct du ',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      )
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'montant que vous avez demandé par le moyen de ',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'paiement que vous avez choisi lors de la demande. A',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  Container(
                      child: const Row(
                    children: [
                      Text(
                        'la fin vous êtes notifiés des détails de votre paiement',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '',
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                              Signification7EtoileShowmodal(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {},
                          ),
                        ]),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
  );
}
