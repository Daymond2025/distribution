import 'package:flutter/material.dart';
import 'package:distribution_frontend/widgets/audio_player_modal.dart';

/// Bouton audio flottant pour les annonces/actualités
/// Affiche un bouton circulaire avec gradient qui ouvre un player audio
/// TODO: Récupérer les données audio depuis l'API
/// En attente d'endpoint : GET /api/announcements/current
class FloatingAudioButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isPlaying;
  final String? audioUrl;
  final String? title;
  final String? subtitle;
  final String? profileImageUrl;

  const FloatingAudioButton({
    super.key,
    this.onPressed,
    this.isPlaying = false,
    this.audioUrl,
    this.title,
    this.subtitle,
    this.profileImageUrl,
  });

  @override
  State<FloatingAudioButton> createState() => _FloatingAudioButtonState();
}

class _FloatingAudioButtonState extends State<FloatingAudioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Gère le tap sur le bouton : animation + ouverture du modal
  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Ouverture du modal de lecture audio
    if (widget.audioUrl != null) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AudioPlayerModal(
            audioUrl: widget.audioUrl!,
            title: widget.title ?? 'Le titre du sujet',
            subtitle: widget.subtitle ?? 'Affichage sous titre',
            profileImageUrl: widget.profileImageUrl ??
                'https://via.placeholder.com/80x80/FF6B6B/FFFFFF?text=👩',
            onClose: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Positionnement du bouton flottant
    final rightPosition = screenWidth * 0.05;
    final topPosition = screenHeight - 170;

    return Positioned(
      right: rightPosition,
      top: topPosition,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: () => _handleTap(),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    center: Alignment(0.62, 0.15),
                    radius: 1.0,
                    colors: [
                      Color(0xFFFFCC00),
                      Color(0xFFFF3700),
                    ],
                    stops: [0.0, 1.0],
                  ),
                  border: Border.all(
                    color: Color(0x33FF00BF),
                    width: 7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
