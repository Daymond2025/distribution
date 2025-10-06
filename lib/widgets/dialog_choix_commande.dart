import 'package:flutter/material.dart';

/// Dialogue de sélection du type de commande
/// Permet de choisir entre : "Pour mon client" ou "Pour moi même"
class DialogChoixCommande extends StatefulWidget {
  const DialogChoixCommande({super.key});

  @override
  State<DialogChoixCommande> createState() => _DialogChoixCommandeState();
}

class _DialogChoixCommandeState extends State<DialogChoixCommande> {
  String? selectedOption;

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
          maxHeight: 350,
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Titre du dialogue
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'JE COMMANDE POUR',
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

              const SizedBox(height: 25),

              // Option : Commande pour un client
              InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = 'client';
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pour mon client',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedOption == 'client'
                                ? const Color(0xFFFFA500)
                                : const Color(0xFF707070),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: selectedOption == 'client'
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

              const SizedBox(height: 15),

              // Option : Commande personnelle
              InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = 'moi';
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pour moi même',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedOption == 'moi'
                                ? const Color(0xFFFFA500)
                                : const Color(0xFF707070),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: selectedOption == 'moi'
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

              const SizedBox(height: 30),

              // Bouton de validation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: InkWell(
                  onTap: () {
                    if (selectedOption != null) {
                      Navigator.of(context).pop(selectedOption);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: selectedOption != null
                          ? const Color(0xFFFFA500)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color:
                            selectedOption != null ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

/// Affiche le dialogue de choix du type de commande
/// Retourne 'client' ou 'moi' selon la sélection de l'utilisateur
Future<String?> showDialogChoixCommande(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const DialogChoixCommande();
    },
  );
}
