// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/screens/Auth/clone/clone_screen.dart';
import 'package:distribution_frontend/screens/Auth/portefeuille/portefeuille_screen.dart';
import 'package:distribution_frontend/screens/Auth/produits/click_produit.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_theme.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_util.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_widgets.dart';
import 'package:distribution_frontend/screens/newscreens/infocommande/infocommande_widget.dart';
import 'package:distribution_frontend/services/clone_produit_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'produit_comp_model.dart';
export 'produit_comp_model.dart';

/// Carte "produit gagnant 25 FCFA / clic" conforme à la maquette.
/// - Image produit
/// - Titre + étoile + badge état (ex: Neuf)
/// - Prix (bleu)
/// - Temps relatif ("Il y a 3 min") basé sur createdAt/updatedAt
/// - Icône "paramètres" qui ouvre un menu: Copier lien / Partager / Supprimer
/// - Bas de carte : `XX Clics` (orange) + `Gain reçu : XXXX CFA` (bleu)
class WinningCloneCard extends StatelessWidget {
  const WinningCloneCard({
    super.key,
    required this.clone,
    required this.vendeur,
    this.onDelete, // pour déléguer la suppression au parent (mes_clics_screen)
  });

  /// `clone` : objet de type `CloneProduct` ou structure JSON similaire.
  /// On lit de façon “défensive” (tryRead) pour rester robuste.
  final dynamic clone;
  final Seller vendeur;

  /// Callback fourni par le parent pour supprimer (ex: `() => deleteClone(clone.id)`)
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    // --- Données principales (robustes aux variations de structure) ------------
    final String image = _firstImageUrl(clone) ?? '';
    final String title = (clone?.title ?? '').toString();
    final int price = _asInt(clone?.price);

    final String etat = _stateName(clone) ?? 'Neuf';
    final String timeAgo = _timeAgo(
      _tryRead(clone, ['updatedAt']) ??
          _tryRead(clone, ['updated_at']) ??
          _tryRead(clone, ['createdAt']) ??
          _tryRead(clone, ['created_at']),
    );

    // ✅ Directement depuis CloneProduct (plus simple et fiable)
    final int effectiveClicks = (clone is CloneProduct) ? clone.clicksCount : 0;

    final double effectiveEarnings =
        (clone is CloneProduct) ? clone.totalEarnings : 0.0;

    final double bonus =
        (clone is CloneProduct) ? (clone.winningBonusAmount ?? 0.0) : 0.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: const Color(0x33000000),
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Ligne haute : image + titre/prix + étoile/état + engrenage(menu)
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image.isNotEmpty
                      ? Image.network(
                          image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(Icons.image, size: 28),
                        ),
                ),
                const SizedBox(width: 10),

                // Titre + prix + temps relatif
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre (max 2 lignes)
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Prix + "il y a …"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatCFA(price),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF1050FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (timeAgo.isNotEmpty)
                            Text(
                              timeAgo,
                              style: theme.bodySmall.override(
                                fontFamily: 'Inter',
                                letterSpacing: 0,
                                color: const Color(0xFF707070),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Étoile + badge état + engrenage (menu)
                // Étoile + badge état (alignés horizontalement)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_sharp,
                        color: Color(0xFFFFD900), size: 20),
                    const SizedBox(width: 4),
                    _stateChip(etat),
                  ],
                ),
              ],
            ),
          ),

          // Séparateur
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 2,
              color: Color(0xFFEEEEEE),
            ),
          ),

          // Ligne bas : XX Clics (orange) + Gain reçu (bleu)
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _settingsMenu(context),
                Row(
                  children: [
                    _metricChip('${effectiveClicks} Clics', orange: true),
                    const SizedBox(width: 8),

                    // === Gain reçu cliquable ===
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PortefeuilleScreen(),
                          ),
                        );
                      },
                      child: _metricChip(
                        'Gain reçu : ${_formatCFA(effectiveEarnings)}',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -- MENU (copier / partager / supprimer) ------------------------------------

  Widget _settingsMenu(BuildContext context) {
    return PopupMenuButton<String>(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) async {
        switch (value) {
          case 'copy':
            await _copyLink();
            Fluttertoast.showToast(
              msg: 'Lien copié.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            break;
          case 'share':
            _shareLink();
            break;
          case 'remove':
            if (onDelete != null) onDelete!();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'copy',
          child: Row(
            children: [
              Icon(Icons.content_copy, size: 18),
              SizedBox(width: 6),
              Text('Copier le lien'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'share',
          child: Row(
            children: [
              Image.asset('assets/images/share.png', width: 20, height: 20),
              const SizedBox(width: 6),
              const Text('Partager le produit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'remove',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 18),
              SizedBox(width: 6),
              Text('Supprimer le produit'),
            ],
          ),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: const Icon(Icons.settings, size: 18, color: Color(0xFF7E7E7E)),
      ),
    );
  }

  Future<void> _copyLink() async {
    final url = _url();
    await Clipboard.setData(ClipboardData(text: '$textSharing$url'));
  }

  void _shareLink() {
    final url = _url();
    // si besoin d’embarquer id vendeur + id clone :
    final payload =
        jsonEncode({'idSeller': vendeur.id, 'idProduit': _asInt(clone?.id)});
    Share.share('$textSharing$url');
  }

  String _url() {
    // ProduitCompWidget fait: textSharing + widget.produit.url
    final u = _tryRead(clone, ['url'])?.toString() ?? '';
    return u;
  }

  // -- UI helpers --------------------------------------------------------------

  Widget _stateChip(String text) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFC000),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _metricChip(String text, {bool orange = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: orange ? const Color(0xFFFFF1E0) : const Color(0xFFE9F2FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: orange ? const Color(0xFFFFC089) : const Color(0xFFBFD7FF),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: orange ? const Color(0xFFE27B00) : const Color(0xFF0D47A1),
        ),
      ),
    );
  }

  // -- Data helpers ------------------------------------------------------------

  String? _firstImageUrl(dynamic c) {
    try {
      final imgs = c?.product?.images;
      if (imgs is List && imgs.isNotEmpty) return imgs.first.toString();
    } catch (_) {}
    return null;
  }

  String? _stateName(dynamic c) {
    try {
      final name = c?.product?.state?.name;
      if (name is String && name.isNotEmpty) {
        return name[0].toUpperCase() + name.substring(1);
      }
    } catch (_) {}
    return null;
  }

  String _formatCFA(num value) {
    final s = value.toStringAsFixed(value % 1 == 0 ? 0 : 2);
    final parts = s.split('.');
    final digits = parts[0];
    final buff = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i != 0 && (digits.length - i) % 3 == 0) buff.write(' ');
      buff.write(digits[i]);
    }
    final dec = parts.length > 1 ? ',${parts[1]}' : '';
    return '${buff.toString()}$dec CFA';
  }

  int _asInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  double _asDouble(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  dynamic _tryRead(dynamic root, List<String> keys) {
    try {
      dynamic cur = root;
      for (final k in keys) {
        cur = cur?[k];
        if (cur == null) break;
      }
      return cur;
    } catch (_) {
      try {
        dynamic cur = root;
        for (final k in keys) {
          cur = cur?.toJson()?[k];
          if (cur == null) break;
        }
        return cur;
      } catch (_) {
        return null;
      }
    }
  }

  String _timeAgo(dynamic isoString) {
    if (isoString == null) return '';
    try {
      final dt = DateTime.tryParse(isoString.toString());
      if (dt == null) return '';
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 1) return "À l'instant";
      if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
      if (diff.inHours < 24) return 'Il y a ${diff.inHours} h';
      return 'Il y a ${diff.inDays} j';
    } catch (_) {
      return '';
    }
  }
}
