import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/vainqueur/detail_vendu_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/etoile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NoteVainqueurScreen extends StatefulWidget {
  const NoteVainqueurScreen({super.key});

  @override
  State<NoteVainqueurScreen> createState() => _NoteVainqueurScreenState();
}

class _NoteVainqueurScreenState extends State<NoteVainqueurScreen> {
  bool _loading = false;
  List<dynamic> _publie = [];

  Future<void> publie() async {
    ApiResponse response = await getOuiEtoiles();
    if (response.error == null) {
      setState(() {
        _publie = response.data as List<dynamic>;
        _loading = true;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  @override
  void initState() {
    // publie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.9,
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.zero,
          child: const Text(
            ' Les heureux gagnants',
            style: TextStyle(color: colorYellow),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: Column(
          children: !_loading
              ? _publie.isNotEmpty
                  ? _publie
                      .map(
                        (e) => kCardPubli(
                          e['id'],
                          '${e['vendeur']['nom']} ${e['vendeur']['prenom']}',
                          e['vendeur']['photo'] ?? imgUserDefault,
                          e['photo'] ?? imgProdDefault,
                          e['vendeur']['etoiles'],
                          e['nb_vue'],
                          [e['vendeur']],
                        ),
                      )
                      .toList()
                  : [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: const Text('Heureux gagnant vide!'),
                      ),
                    ]
              : [
                  kChargement(),
                  kChargement(),
                  kChargement(),
                ],
        ),
      ),
    );
  }

  Container kChargement() => Container(
        padding: const EdgeInsets.all(10),
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 255, 255, 255),
          highlightColor: const Color.fromARGB(255, 202, 201, 201),
          child: Container(
            height: 360,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: colorwhite,
            ),
          ),
        ),
      );

  InkWell kCardPubli(int id, String nom, String imageUser, String imagePub,
          int nbEtoileUser, int nbVuePublie, List<dynamic> vendeur) =>
      InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailVenduScreen(id: id, vendeur: vendeur),
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
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        image: DecorationImage(
                          image: NetworkImage(imageUser),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            nom,
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
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'FELICITAION à M/Mme $nom qui bénéficie gratuitement d\'un bonus de 10.000  Fr. Bonus Titulaire de ${(nbEtoileUser / 7).floor()} x 7 étoiles équivalant à ${(nbEtoileUser / 7).floor() * 7} marchés enregistrés Bonus total reçu = ${(nbEtoileUser / 7).floor() * 10000}  Fr',
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
                    image: NetworkImage(imagePub),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.topRight,
                child: Text('$nbVuePublie Vues'),
              ),
            ],
          ),
        ),
      );
}
