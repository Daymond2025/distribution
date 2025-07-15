import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const routeName = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! RemoteMessage) {
      return const Scaffold(
        body: Center(
          child: Text(
            '📭 Aucune notification à afficher',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    final RemoteMessage message = args;
    final Map<String, dynamic> data = message.data;
    final String? imageUrl = data['image'];
    final String notifType = data['type'] ?? 'default';
    final String? redirectScreen = data['screen'];
    //final hiddenKeys = ['click_action', 'image'];
    final String? formattedDate = message.sentTime != null
        ? DateFormat('HH:mm - dd MMM yyyy', 'fr_FR').format(message.sentTime!.toLocal())
        : null;

    final badgeColor = _getBadgeColor(notifType);
    final badgeLabel = _getBadgeLabel(notifType);

    return Scaffold(
      appBar: AppBar(
        title: const Text('📩 Daymond distribution'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badgeLabel.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const Spacer(),
                if (formattedDate != null)
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              message.notification?.title ?? 'Sans titre',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message.notification?.body ?? 'Sans message',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 32),
            
            if (redirectScreen != null && redirectScreen.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Aller à l\'écran associé'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/$redirectScreen');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getBadgeColor(String type) {
    switch (type) {
      case 'order':
        return Colors.orange;
      case 'login':
        return Colors.green;
      case 'warning':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String _getBadgeLabel(String type) {
    switch (type) {
      case 'order':
        return 'Commande';
      case 'login':
        return 'Connexion';
      case 'warning':
        return 'Alerte';
      case 'default':
        return 'Info';
      default:
        return type;
    }
  }
}
