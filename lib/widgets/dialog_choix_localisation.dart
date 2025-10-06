import 'package:flutter/material.dart';
import 'package:distribution_frontend/services/params_service.dart';
import 'package:distribution_frontend/api_response.dart';

/// Dialogue de sélection de la zone de livraison
/// Permet de choisir entre : "Abidjan" ou "Hors Abidjan" avec affichage des prix
class DialogChoixLocalisation extends StatefulWidget {
  final int prixAbidjan;
  final int prixHorsAbidjan;

  const DialogChoixLocalisation({
    super.key,
    required this.prixAbidjan,
    required this.prixHorsAbidjan,
  });

  @override
  State<DialogChoixLocalisation> createState() =>
      _DialogChoixLocalisationState();
}

class _DialogChoixLocalisationState extends State<DialogChoixLocalisation> {
  String? selectedZone;
  late int prixAbidjan;
  late int prixHorsAbidjan;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeliveryPrices();
  }

  /// Charge les prix de livraison depuis l'API
  /// TODO: Endpoint API via ParamsService
  /// En attente d'endpoint : GET /params/delivery_prices
  Future<void> _loadDeliveryPrices() async {
    try {
      ParamsService paramsService = ParamsService();
      ApiResponse response = await paramsService.params('delivery_prices');

      if (response.error == null && response.data != null) {
        setState(() {
          List<dynamic> prices = response.data as List;
          for (var price in prices) {
            if (price['type'] == 'city') {
              prixAbidjan = price['price'] ?? widget.prixAbidjan;
            } else if (price['type'] == 'no_city') {
              prixHorsAbidjan = price['price'] ?? widget.prixHorsAbidjan;
            }
          }
          isLoading = false;
        });
      } else {
        // Utilisation des prix par défaut en cas d'erreur
        setState(() {
          prixAbidjan = widget.prixAbidjan;
          prixHorsAbidjan = widget.prixHorsAbidjan;
          isLoading = false;
        });
      }
    } catch (e) {
      // Utilisation des prix par défaut en cas d'erreur
      setState(() {
        prixAbidjan = widget.prixAbidjan;
        prixHorsAbidjan = widget.prixHorsAbidjan;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 305,
        constraints: const BoxConstraints(
          maxHeight: 400,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF707070),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Titre du dialogue
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 5),
                child: Text(
                  'TYPE DE LIVRAISON',
                  style: TextStyle(
                    color: Color(0xFFFFA500),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 115),
                child: const Divider(
                  color: Color(0xFF707070),
                  thickness: 1,
                ),
              ),

              const SizedBox(height: 20),

              // Chargement des prix ou affichage des options
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFA500),
                  ),
                )
              else ...[
                // Option : Livraison à Abidjan
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedZone = 'abidjan';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Tout\nAbidjan : ${prixAbidjan.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} FCFA',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedZone == 'abidjan'
                                  ? const Color(0xFFFFA500)
                                  : const Color(0xFF707070),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: selectedZone == 'abidjan'
                              ? const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Color(0xFFFFA500),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Option : Livraison hors Abidjan
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedZone = 'hors_abidjan';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Hors\nAbidjan : ${prixHorsAbidjan.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} FCFA',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedZone == 'hors_abidjan'
                                  ? const Color(0xFFFFA500)
                                  : const Color(0xFF707070),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: selectedZone == 'hors_abidjan'
                              ? const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Color(0xFFFFA500),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Bouton de validation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: InkWell(
                    onTap: () {
                      if (selectedZone != null) {
                        Navigator.of(context).pop(selectedZone);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedZone != null
                            ? const Color(0xFFFFA500)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color:
                              selectedZone != null ? Colors.white : Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Affiche le dialogue de choix de la zone de livraison
/// Retourne 'abidjan' ou 'hors_abidjan' selon la sélection de l'utilisateur
Future<String?> showDialogChoixLocalisation(
  BuildContext context, {
  required int prixAbidjan,
  required int prixHorsAbidjan,
}) async {
  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return DialogChoixLocalisation(
        prixAbidjan: prixAbidjan,
        prixHorsAbidjan: prixHorsAbidjan,
      );
    },
  );
}
