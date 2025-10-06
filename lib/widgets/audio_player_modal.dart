import 'package:flutter/material.dart';

/// Modal de lecture audio pour les annonces/actualités
/// TODO: Intégrer un vrai player audio (audioplayers package)
/// En attente d'implémentation du player audio réel
class AudioPlayerModal extends StatefulWidget {
  final String audioUrl;
  final String title;
  final String subtitle;
  final String profileImageUrl;
  final VoidCallback onClose;
  final VoidCallback? onNext;

  const AudioPlayerModal({
    super.key,
    required this.audioUrl,
    required this.title,
    required this.subtitle,
    required this.profileImageUrl,
    required this.onClose,
    this.onNext,
  });

  @override
  State<AudioPlayerModal> createState() => _AudioPlayerModalState();
}

class _AudioPlayerModalState extends State<AudioPlayerModal> {
  // TODO: Remplacer par un vrai contrôleur audio (AudioPlayer)
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 308,
        height: widget.onNext != null ? 340 : 288,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Fond avec dégradé radial jaune-rouge
            Positioned(
              left: 0,
              top: 65,
              child: Container(
                width: 308,
                height: 161,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const RadialGradient(
                    center: Alignment(0.62, 0.35),
                    radius: 1.0,
                    colors: [Color(0xFFFFCC00), Color(0xFFFF3700)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ),

            // Conteneur blanc du contenu
            Positioned(
              left: 0,
              top: 65,
              child: Container(
                width: 308,
                height: 153,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            // Image de profil centrée en haut
            Positioned(
              left: 98.5,
              top: 0,
              child: Container(
                width: 111,
                height: 114,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(0, -4),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/audio.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Titre et sous-titre de l'annonce
            Positioned(
              left: 20,
              top: 110,
              child: SizedBox(
                width: 268,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFF022C7), Color(0xFF1050FF)],
                        stops: [0.0, 1.0],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        'Affichage sous titre',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Contrôles de lecture audio (play/pause et slider)
            Positioned(
              left: 22,
              top: 165,
              child: Container(
                width: 264,
                height: 39,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Bouton Play/Pause
                    // TODO: Connecter au player audio réel
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF007AFF),
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Barre de progression audio
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF007AFF),
                          inactiveTrackColor: Colors.grey.shade300,
                          thumbColor: const Color(0xFF007AFF),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6,
                          ),
                          trackHeight: 3,
                        ),
                        child: Slider(
                          value: _duration.inMilliseconds > 0
                              ? _position.inMilliseconds /
                                  _duration.inMilliseconds
                              : 0.0,
                          onChanged: (value) {
                            // TODO: Implémenter le changement de position audio
                          },
                        ),
                      ),
                    ),

                    // Affichage du temps écoulé
                    Text(
                      _formatDuration(_position),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bouton "Suivant" (conditionnel)
            if (widget.onNext != null)
              Positioned(
                left: 132,
                top: 238,
                child: GestureDetector(
                  onTap: widget.onNext,
                  child: Container(
                    width: 44,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        center: Alignment(0.62, 0.35),
                        radius: 1.5,
                        colors: [Color(0xFFFFCC00), Color(0xFFFF3700)],
                        stops: [0.0, 1.0],
                      ),
                      border: Border.all(
                        color: const Color(0xFFFFFAFA),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '>',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Bouton de fermeture du modal
            Positioned(
              left: 132,
              top: widget.onNext != null ? 290 : 238,
              child: GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  width: 44,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000).withOpacity(0.57),
                    border: Border.all(
                      color: const Color(0xFFC0C0C0),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                      bottomRight: Radius.circular(4),
                      bottomLeft: Radius.circular(21),
                    ),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formate la durée pour l'affichage (ex: "2:30" ou "45" secondes)
  String _formatDuration(Duration duration) {
    int totalSeconds = duration.inSeconds;

    if (totalSeconds < 60) {
      return totalSeconds.toString();
    }

    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
