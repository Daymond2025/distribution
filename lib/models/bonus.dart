class Bonus {
  final int id;
  final String title;
  final String subtitle;
  final int targetCount;
  final int rewardAmount;
  final String rewardCurrency;
  final bool isStarBonus;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final int completedCount;
  final int totalCompleted;
  final String encouragementMessage;

  Bonus({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.targetCount,
    required this.rewardAmount,
    required this.rewardCurrency,
    required this.isStarBonus,
    required this.isActive,
    this.startDate,
    this.endDate,
    required this.completedCount,
    required this.totalCompleted,
    required this.encouragementMessage,
  });

  factory Bonus.fromJson(Map<String, dynamic> json) {
    return Bonus(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      targetCount: json['target_count'],
      rewardAmount: json['reward_amount'],
      rewardCurrency: json['reward_currency'] ?? 'FCFA',
      isStarBonus: json['is_star_bonus'] == 1 || json['is_star_bonus'] == true,
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      completedCount: json['completed_count'] ?? 0,
      totalCompleted: json['total_completed'] ?? 0,
      encouragementMessage: json['encouragement_message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'target_count': targetCount,
      'reward_amount': rewardAmount,
      'reward_currency': rewardCurrency,
      'is_star_bonus': isStarBonus,
      'is_active': isActive,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'completed_count': completedCount,
      'total_completed': totalCompleted,
      'encouragement_message': encouragementMessage,
    };
  }
}

class BonusProgress {
  final int bonusId;
  final int currentProgress;
  final int targetProgress;
  final List<ProgressItem> progressItems;
  final DateTime lastUpdated;

  BonusProgress({
    required this.bonusId,
    required this.currentProgress,
    required this.targetProgress,
    required this.progressItems,
    required this.lastUpdated,
  });

  factory BonusProgress.fromJson(Map<String, dynamic> json) {
    return BonusProgress(
      bonusId: json['bonus_id'],
      currentProgress: json['current_progress'],
      targetProgress: json['target_progress'],
      progressItems: (json['progress_items'] as List)
          .map((item) => ProgressItem.fromJson(item))
          .toList(),
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bonus_id': bonusId,
      'current_progress': currentProgress,
      'target_progress': targetProgress,
      'progress_items': progressItems.map((item) => item.toJson()).toList(),
      'last_updated': lastUpdated.toIso8601String(),
    };
  }
}

class ProgressItem {
  final int id;
  final bool isCompleted;
  final DateTime? completedAt;
  final int? orderId;
  final String? productName;

  ProgressItem({
    required this.id,
    required this.isCompleted,
    this.completedAt,
    this.orderId,
    this.productName,
  });

  factory ProgressItem.fromJson(Map<String, dynamic> json) {
    return ProgressItem(
      id: json['id'],
      isCompleted: json['is_completed'] == 1 || json['is_completed'] == true,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      orderId: json['order_id'],
      productName: json['product_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_completed': isCompleted,
      'completed_at': completedAt?.toIso8601String(),
      'order_id': orderId,
      'product_name': productName,
    };
  }
}
