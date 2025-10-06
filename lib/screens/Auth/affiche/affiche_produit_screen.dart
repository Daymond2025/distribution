import 'dart:async';
import 'dart:math';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:flutter/material.dart';

class AfficheProduitScreen extends StatefulWidget {
  const AfficheProduitScreen({super.key});

  @override
  State<AfficheProduitScreen> createState() => _AfficheProduitScreenState();
}

class _AfficheProduitScreenState extends State<AfficheProduitScreen> {
  bool _loading = true;

  // TODO: Remplacer par un appel API pour récupérer les affiches
  // Données mockées en attente d'API
  List<Map<String, dynamic>> _affiches = [
    {
      'id': '1',
      'images': [
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
      ],
    },
    {
      'id': '2',
      'images': [
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
      ],
    },
    {
      'id': '3',
      'images': [
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
      ],
    },
    {
      'id': '4',
      'images': [
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
      ],
    },
    {
      'id': '5',
      'images': [
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
      ],
    },
    {
      'id': '6',
      'images': [
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
        'assets/images/affiche2.png',
        'assets/images/affiche1.png',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadAffiches();
  }

  Future<void> _loadAffiches() async {
    // TODO: Remplacer par un appel API pour récupérer les affiches produits
    // En attente d'endpoint API
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loading = false;
    });
  }

  /// Télécharge une seule image
  Future<void> _downloadSingleImage(String imagePath) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Téléchargement de l\'image...'),
          duration: Duration(seconds: 1),
        ),
      );

      // TODO: Remplacer par un appel API pour télécharger l'image depuis le serveur
      // En attente d'endpoint de téléchargement
      await Future.delayed(const Duration(milliseconds: 500));
      print('Téléchargement image: $imagePath');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image téléchargée avec succès !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors du téléchargement: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  /// Télécharge toutes les images de l'affiche
  Future<void> _downloadAllImages(List<String> images) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Téléchargement de ${images.length} image(s)...'),
          duration: const Duration(seconds: 2),
        ),
      );

      // TODO: Remplacer par un appel API pour télécharger toutes les images depuis le serveur
      // En attente d'endpoint de téléchargement
      for (int i = 0; i < images.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500));
        print('Téléchargement image ${i + 1}/${images.length}: ${images[i]}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('${images.length} image(s) téléchargée(s) avec succès !'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors du téléchargement: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  /// Affiche le modal avec les détails de l'affiche produit
  /// Navigation automatique toutes les 3 secondes si 3+ images disponibles
  Future<void> _showAfficheModal(
      BuildContext context, Map<String, dynamic> affiche) async {
    int currentImageIndex = 0;
    Timer? autoNavigationTimer;

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            List<String> images = affiche['images'] as List<String>;

            /// Démarre la navigation automatique entre les images
            /// Active uniquement si 3 images ou plus sont disponibles
            void startAutoNavigation() {
              if (images.length >= 3) {
                autoNavigationTimer =
                    Timer.periodic(const Duration(seconds: 3), (timer) {
                  if (context.mounted) {
                    setState(() {
                      // Sélection aléatoire d'une image différente de l'actuelle
                      int newIndex;
                      do {
                        newIndex = Random().nextInt(images.length);
                      } while (newIndex == currentImageIndex);
                      currentImageIndex = newIndex;
                    });
                  } else {
                    timer.cancel();
                  }
                });
              }
            }

            /// Arrête la navigation automatique entre les images
            void stopAutoNavigation() {
              autoNavigationTimer?.cancel();
              autoNavigationTimer = null;
            }

            // Démarrage automatique de la navigation
            startAutoNavigation();

            return WillPopScope(
              onWillPop: () async {
                stopAutoNavigation();
                return true;
              },
              child: Dialog(
                insetPadding: const EdgeInsets.only(
                    left: 23, top: 148, right: 23, bottom: 148),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 379,
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      children: [
                        // Conteneur de l'image avec bouton de téléchargement
                        Container(
                          key: ValueKey(
                              'image_${currentImageIndex}_${images[currentImageIndex]}'),
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 353,
                            maxHeight: 347,
                          ),
                          margin: const EdgeInsets.only(top: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            image: DecorationImage(
                              image: AssetImage(images[currentImageIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Bouton de téléchargement positionné en haut à droite
                              Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    stopAutoNavigation();
                                    _downloadSingleImage(
                                        images[currentImageIndex]);
                                  },
                                  child: Container(
                                    width: 23,
                                    height: 23,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                          0xAD050000), // rgba(5, 0, 0, 0.68)
                                      border: Border.all(
                                        color: const Color(
                                            0x29000000), // rgba(0, 0, 0, 0.16)
                                        width: 3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Contrôles de navigation avec indicateur de position
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                stopAutoNavigation();
                                setState(() {
                                  if (currentImageIndex > 0) {
                                    currentImageIndex--;
                                  } else {
                                    currentImageIndex = images.length - 1;
                                  }
                                });
                              },
                              icon: const Icon(Icons.chevron_left),
                            ),
                            Text('${currentImageIndex + 1}/${images.length}'),
                            IconButton(
                              onPressed: () {
                                stopAutoNavigation();
                                setState(() {
                                  if (currentImageIndex < images.length - 1) {
                                    currentImageIndex++;
                                  } else {
                                    currentImageIndex = 0;
                                  }
                                });
                              },
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // Boutons d'action : Télécharger et Voir le produit
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  stopAutoNavigation();
                                  _downloadAllImages(images);
                                  Navigator.of(context).pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Color(0xFFFFA500)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text(
                                  'Télécharger',
                                  style: TextStyle(color: Color(0xFFFFA500)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                // TODO: Récupérer les détails du produit via API avant navigation
                                // En attente d'endpoint pour les détails du produit
                                onPressed: () {
                                  stopAutoNavigation();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClickProduit(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFA500),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text(
                                  'Voir le produit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: AppBar(
        elevation: 0.95,
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        automaticallyImplyLeading: true,
        title: const Text(
          'Affiche produit',
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
      ),
      body: _loading ? _buildLoadingView() : _buildAffichesGrid(),
    );
  }

  /// Affiche l'indicateur de chargement
  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9C27B0)),
      ),
    );
  }

  /// Construit la grille d'affiches avec 2 colonnes
  Widget _buildAffichesGrid() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 196 / 193,
        ),
        itemCount: _affiches.length,
        itemBuilder: (context, index) {
          return _buildAfficheCard(_affiches[index]);
        },
      ),
    );
  }

  /// Construit une carte d'affiche dans la grille
  Widget _buildAfficheCard(Map<String, dynamic> affiche) {
    List<String> images = affiche['images'] as List<String>;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showAfficheModal(context, affiche),
        child: Stack(
          children: [
            // Affichage de la première image de l'affiche
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                images[0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
