import 'package:flutter/material.dart';
import 'package:distribution_frontend/models/bonus.dart';
import 'package:distribution_frontend/services/bonus_mock_service.dart';
import 'package:distribution_frontend/widgets/bonus_progress_widget.dart';
import 'package:distribution_frontend/api_response.dart';

class MesBonusScreen extends StatefulWidget {
  const MesBonusScreen({super.key});

  @override
  State<MesBonusScreen> createState() => _MesBonusScreenState();
}

class _MesBonusScreenState extends State<MesBonusScreen> {
  List<Bonus> _bonuses = [];
  Map<int, BonusProgress> _progressMap = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBonuses();
  }

  /// Charge la liste des bonus disponibles
  Future<void> _loadBonuses() async {
    setState(() {
      _loading = true;
    });

    try {
      // TODO: Remplacer par un appel API réel
      // En attente d'endpoint : GET /api/bonuses
      ApiResponse bonusesResponse = await BonusMockService.getBonuses();

      if (bonusesResponse.error == null) {
        setState(() {
          _bonuses = (bonusesResponse.data as List)
              .map((item) => Bonus.fromJson(item as Map<String, dynamic>))
              .toList();
        });

        // Charge la progression pour chaque bonus disponible
        for (Bonus bonus in _bonuses) {
          await _loadBonusProgress(bonus.id);
        }
      } else {
        _showError('Erreur lors du chargement des bonus');
      }
    } catch (e) {
      _showError('Erreur de connexion');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  /// Charge la progression d'un bonus spécifique
  Future<void> _loadBonusProgress(int bonusId) async {
    try {
      // TODO: Remplacer par un appel API réel
      // En attente d'endpoint : GET /api/bonuses/{bonusId}/progress
      ApiResponse progressResponse =
          await BonusMockService.getBonusProgress(bonusId);
      if (progressResponse.error == null) {
        setState(() {
          _progressMap[bonusId] = BonusProgress.fromJson(
              progressResponse.data as Map<String, dynamic>);
        });
      }
    } catch (e) {
      print(
          'Erreur lors du chargement de la progression pour le bonus $bonusId: $e');
    }
  }

  /// Affiche un message d'erreur à l'utilisateur
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Gère le tap sur un élément de progression
  /// TODO: Récupérer les détails de la commande via API
  /// En attente d'endpoint : GET /api/bonuses/{bonusId}/orders/{itemNumber}
  void _onProgressItemTap(int bonusId, int itemNumber) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Détails de la commande $itemNumber'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FBFE),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _loading ? _buildLoadingView() : _buildBonusesList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Construit l'en-tête avec gradient et logo
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 143,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFFCC00),
            Color(0xFFFF6600),
            Color(0xFFFF3700),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(21),
          bottomRight: Radius.circular(21),
        ),
      ),
      child: Stack(
        children: [
          // Bouton de retour
          Positioned(
            left: 20,
            top: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          // Logo BonuSuprise
          Positioned(
            left: 31,
            top: 38,
            child: Container(
              width: 376,
              height: 89,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bonusuprise.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
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

  /// Construit la liste des bonus avec leur progression
  Widget _buildBonusesList() {
    if (_bonuses.isEmpty) {
      return const Center(
        child: Text(
          'Aucun bonus disponible pour le moment',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: _bonuses.length,
      itemBuilder: (context, index) {
        final bonus = _bonuses[index];
        final progress = _progressMap[bonus.id];

        return BonusProgressWidget(
          bonus: bonus,
          progress: progress,
          onItemTap: (itemNumber) => _onProgressItemTap(bonus.id, itemNumber),
        );
      },
    );
  }
}
