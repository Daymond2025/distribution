import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/etoile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class DetailVenduScreen extends StatefulWidget {
  const DetailVenduScreen({super.key, required this.id, required this.vendeur});
  final int id;
  final List<dynamic> vendeur;
  @override
  State<DetailVenduScreen> createState() => _DetailVenduScreenState();
}

class _DetailVenduScreenState extends State<DetailVenduScreen> {
  List<dynamic> vendeur = [];

  int etoiles = 0;
  double nbX7 = 0;

  bool _loading = false;
  bool _noCnx = false;

  List<dynamic> _publie = [];
  List<dynamic> _itemList = [];

  Future<void> showP() async {
    ApiResponse response = await showPublie(widget.id);
    if (response.error == null) {
      setState(() {
        _publie = response.data as List<dynamic>;
        _itemList = _publie[0]['itemetoiles'];
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
        _noCnx = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showP();
    vendeur = widget.vendeur;
    etoiles = vendeur[0]['etoiles'];
    nbX7 = etoiles / 7;
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(280),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 250, 250, 1),
                ),
                child: Column(
                  children: [
                    AppBar(
                      elevation: 0,
                      backgroundColor: const Color.fromRGBO(255, 250, 250, 1),
                      iconTheme: const IconThemeData(color: colorblack),
                      actions: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Icon(
                            Icons.star,
                            color: Color(0xFFFF9700),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              image: DecorationImage(
                                image: NetworkImage(
                                    vendeur[0]['photo'] ?? imgUserDefault),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            '${vendeur[0]['nom']} ${vendeur[0]['prenom']}',
                            style: const TextStyle(
                                color: colorblack, fontSize: 20),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Membre depuis le ',
                                style: const TextStyle(
                                    color: colorblack, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${vendeur[0]['created_at'].substring(8, 10)}/${vendeur[0]['created_at'].substring(5, 7)}/${vendeur[0]['created_at'].substring(0, 4)}',
                                    style: const TextStyle(
                                        color: colorblack, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: nbX7.floor().toString(),
                              style: const TextStyle(
                                  color: colorYellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' FOIS ',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '7',
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' ETOILES',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          mainAxisExtent: _loading ? 270 : 250,
                        ),
                        itemCount: _loading ? _itemList.length : 4,
                        itemBuilder: (_, index) {
                          return _loading
                              ? InkWell(
                                  onTap: () => {},
                                  child: produitsCard(
                                    context,
                                    _itemList.elementAt(index)['produit'],
                                    _itemList.elementAt(index)['produit']['id'],
                                    _itemList.elementAt(index)['produit']
                                        ['nom'],
                                    _itemList.elementAt(index)['produit']
                                                ['type'] ==
                                            'commission'
                                        ? _itemList.elementAt(index)['produit']
                                            ['prix_vente']
                                        : _itemList.elementAt(index)['produit']
                                                    ['type'] ==
                                                'grossiste'
                                            ? _itemList
                                                    .elementAt(index)['produit']
                                                ['prix_grossiste_unitaire']
                                            : _itemList.elementAt(
                                                index)['produit']['prix_louer'],
                                    _itemList.elementAt(index)['produit']
                                        ['prix_reduit'],
                                    _itemList.elementAt(index)['produit']
                                        ['etat']['nom'],
                                    _itemList.elementAt(index)['produit']
                                        ['etoile'],
                                    _itemList
                                                .elementAt(index)['produit']
                                                    ['photoprods']
                                                .length ==
                                            0
                                        ? imgProdDefault
                                        : _itemList.elementAt(index)['produit']
                                            ['photoprods'][0]['photo'],
                                    _itemList.elementAt(index)['produit']
                                        ['stock'],
                                    _itemList.elementAt(index)['produit']
                                        ['indisponible'],
                                  ),
                                )
                              : produitLoadingCard3x3();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : kRessayer(context, () {
            showP();
          });
  }
}
