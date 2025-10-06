import 'package:distribution_frontend/api_response.dart';

/// Service mock pour simuler les bonus en développement
/// À remplacer par BonusService lors de l'intégration API réelle
class BonusMockService {
  /// Données mockées pour simuler les bonus disponibles
  static final List<Map<String, dynamic>> _mockBonuses = [
    {
      'id': 1,
      'title': '7 étoiles =',
      'subtitle': 'Récompense dès 7 articles étoilés vendus',
      'target_count': 7,
      'reward_amount': 5000,
      'reward_currency': 'FCFA',
      'is_star_bonus': true,
      'is_active': true,
      'start_date': null,
      'end_date': null,
      'completed_count': 3,
      'total_completed': 2,
      'encouragement_message':
          'Continuez, il ne vous reste plus que 4 articles étoilés à vendre pour gagner un bonus gratuit de 5000 FCFA.',
    },
    {
      'id': 2,
      'title': 'Mission 5 vente =',
      'subtitle':
          'Vendez 5 articles non étoilés cette semaine et obtenez un bonus de 3000 Fr. offert !',
      'target_count': 5,
      'reward_amount': 3000,
      'reward_currency': 'FCFA',
      'is_star_bonus': false,
      'is_active': true,
      'start_date':
          DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      'end_date': DateTime.now().add(const Duration(days: 4)).toIso8601String(),
      'completed_count': 3,
      'total_completed': 0,
      'encouragement_message':
          'Continuez, il ne vous reste plus que 2 articles non étoilés à vendre pour gagner un bonus gratuit de 3000 FCFA.',
    },
  ];

  /// Données mockées pour la progression du bonus "7 étoiles"
  static final Map<String, dynamic> _mockProgress1 = {
    'bonus_id': 1,
    'current_progress': 3,
    'target_progress': 7,
    'last_updated': DateTime.now().toIso8601String(),
    'progress_items': [
      {
        'id': 1,
        'is_completed': true,
        'completed_at':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'order_id': 101,
        'product_name': 'Samsung Galaxy S23',
      },
      {
        'id': 2,
        'is_completed': true,
        'completed_at':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'order_id': 102,
        'product_name': 'iPhone 14 Pro',
      },
      {
        'id': 3,
        'is_completed': true,
        'completed_at':
            DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
        'order_id': 103,
        'product_name': 'MacBook Pro',
      },
      {
        'id': 4,
        'is_completed': false,
        'completed_at': null,
        'order_id': null,
        'product_name': null,
      },
      {
        'id': 5,
        'is_completed': false,
        'completed_at': null,
        'order_id': null,
        'product_name': null,
      },
      {
        'id': 6,
        'is_completed': false,
        'completed_at': null,
        'order_id': null,
        'product_name': null,
      },
      {
        'id': 7,
        'is_completed': false,
        'completed_at': null,
        'order_id': null,
        'product_name': null,
      },
    ],
  };

  /// Données mockées pour la progression du bonus "Mission 5 vente"
  static final Map<String, dynamic> _mockProgress2 = {
    'bonus_id': 2,
    'current_progress': 3,
    'target_progress': 5,
    'last_updated': DateTime.now().toIso8601String(),
    'progress_items': [
      {
        'id': 8,
        'is_completed': true,
        'completed_at':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'order_id': 201,
        'product_name': 'Téléphone basique',
      },
      {
        'id': 9,
        'is_completed': true,
        'completed_at': DateTime.now()
            .subtract(const Duration(hours: 12))
            .toIso8601String(),
        'order_id': 202,
        'product_name': 'Écouteurs Bluetooth',
      },
      {
        'id': 10,
        'is_completed': true,
        'completed_at':
            DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        'order_id': 203,
        'product_name': 'Chargeur USB',
      },
      {
        'id': 11,
        'is_completed': false,
        'completed_at': null,
        'order_id': null,
        'product_name': null,
      },
      {
        'id': 12,
        'is_completed': false,
        'completed_at': null,
        'order_id': null,
        'product_name': null,
      },
    ],
  };

  /// Retourne la liste des bonus mockés
  /// Simule l'endpoint : GET /bonuses
  static Future<ApiResponse> getBonuses() async {
    // Simulation du délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    return ApiResponse()..data = _mockBonuses;
  }

  /// Retourne la progression mockée d'un bonus spécifique
  /// Simule l'endpoint : GET /bonuses/{bonusId}/progress
  static Future<ApiResponse> getBonusProgress(int bonusId) async {
    // Simulation du délai réseau
    await Future.delayed(const Duration(milliseconds: 300));

    Map<String, dynamic> progressData;
    if (bonusId == 1) {
      progressData = _mockProgress1;
    } else if (bonusId == 2) {
      progressData = _mockProgress2;
    } else {
      return ApiResponse()..error = 'Bonus non trouvé';
    }

    return ApiResponse()..data = progressData;
  }

  /// Retourne l'historique mocké des bonus obtenus
  /// Simule l'endpoint : GET /bonuses/history
  static Future<ApiResponse> getBonusHistory() async {
    // Simulation du délai réseau
    await Future.delayed(const Duration(milliseconds: 400));

    return ApiResponse()
      ..data = [
        {
          'id': 100,
          'bonus_title': '7 étoiles = 5000 FCFA',
          'amount': 5000,
          'currency': 'FCFA',
          'completed_at': DateTime.now()
              .subtract(const Duration(days: 10))
              .toIso8601String(),
          'status': 'completed',
        },
        {
          'id': 101,
          'bonus_title': '7 étoiles = 5000 FCFA',
          'amount': 5000,
          'currency': 'FCFA',
          'completed_at': DateTime.now()
              .subtract(const Duration(days: 20))
              .toIso8601String(),
          'status': 'completed',
        },
      ];
  }
}
