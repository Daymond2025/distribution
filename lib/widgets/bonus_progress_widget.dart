import 'package:flutter/material.dart';
import 'package:distribution_frontend/models/bonus.dart';

/// Widget d'affichage de la progression d'un bonus
/// Affiche visuellement l'avancement vers l'obtention d'un bonus (7 étoiles ou Mission 5 vente)
class BonusProgressWidget extends StatelessWidget {
  final Bonus bonus;
  final BonusProgress? progress;
  final Function(int)? onItemTap;

  const BonusProgressWidget({
    super.key,
    required this.bonus,
    this.progress,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: bonus.isStarBonus
              ? [
                  const Color(0xFFFFCC00),
                  const Color(0xFFFF3700),
                ]
              : [
                  const Color(0xFFF022C7),
                  const Color(0xFF1050FF),
                ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressItems(),
            _buildEncouragementMessage(),
          ],
        ),
      ),
    );
  }

  /// Construit l'en-tête avec le titre, sous-titre et icône trophée
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: bonus.isStarBonus
            ? const Color(0xFFFFF5F5)
            : const Color(0xFFF6F5FF),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(height: 4),
                Text(
                  bonus.subtitle,
                  style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (bonus.isStarBonus) _buildTrophyIcon(),
        ],
      ),
    );
  }

  /// Construit le titre avec gradient (ex: "7 étoiles = 5000 FCFA")
  Widget _buildTitle() {
    final titleParts = bonus.title.split('=');
    if (titleParts.length != 2) return Text(bonus.title);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${titleParts[0]}=',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              foreground: Paint()
                ..shader = bonus.isStarBonus
                    ? const LinearGradient(
                        colors: [Color(0xFFFFCC00), Color(0xFFFF3700)],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70))
                    : const LinearGradient(
                        colors: [Color(0xFFF022C7), Color(0xFF1050FF)],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          TextSpan(
            text: ' ${bonus.rewardAmount} ${bonus.rewardCurrency}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              foreground: Paint()
                ..shader = bonus.isStarBonus
                    ? const LinearGradient(
                        colors: [Color(0xFFFFCC00), Color(0xFFFF3700)],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70))
                    : const LinearGradient(
                        colors: [Color(0xFFF022C7), Color(0xFF1050FF)],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit l'icône trophée pour les bonus "7 étoiles"
  Widget _buildTrophyIcon() {
    return Container(
      width: 23,
      height: 25,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/prix.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Construit la liste des éléments de progression (cercles cliquables)
  Widget _buildProgressItems() {
    final currentProgress = progress?.currentProgress ?? 0;
    final targetCount = bonus.targetCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(targetCount, (index) {
          final isActive = index < currentProgress;
          final itemNumber = index + 1;

          return GestureDetector(
            onTap: () => onItemTap?.call(itemNumber),
            child: _buildProgressItem(itemNumber, isActive),
          );
        }),
      ),
    );
  }

  /// Construit un élément de progression individuel (cercle numéroté)
  Widget _buildProgressItem(int itemNumber, bool isActive) {
    return Container(
      width: 41,
      height: 41,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFFFCE8E8) : const Color(0xFFEDEDED),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 24,
              height: 29,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_getItemImage(isActive)),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? const Color(0xFFFF9700)
                    : const Color(0xFF707070),
              ),
              child: Center(
                child: Text(
                  '$itemNumber',
                  style: const TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Retourne l'image appropriée selon l'état et le type de bonus
  String _getItemImage(bool isActive) {
    if (isActive) {
      return bonus.isStarBonus
          ? 'assets/images/7a.png'
          : 'assets/images/5a.png';
    } else {
      return 'assets/images/0a.png';
    }
  }

  /// Construit le message d'encouragement ou de félicitation
  Widget _buildEncouragementMessage() {
    final remaining = bonus.targetCount - (progress?.currentProgress ?? 0);
    final message = remaining > 0
        ? "Continuez, il ne vous reste plus que $remaining article${remaining > 1 ? 's' : ''} ${bonus.isStarBonus ? 'étoilé' : 'non étoilé'}${remaining > 1 ? 's' : ''} à vendre pour gagner un bonus gratuit de ${bonus.rewardAmount} ${bonus.rewardCurrency}."
        : "Félicitations ! Vous avez atteint votre objectif et gagné ${bonus.rewardAmount} ${bonus.rewardCurrency} !";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 7,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
