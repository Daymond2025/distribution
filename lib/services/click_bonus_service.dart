import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';

class ClickBonusService {
  static const String baseUrl = "https://v2.daymondboutique.com/api/v2/seller";

  /// 🔑 Récupérer le token stocké (auth:sanctum)
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  /// 📊 Stats clics produits gagnants du vendeur connecté
  Future<ApiResponse> getSellerWinningClickStats() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final token = await _getToken();
      final url = Uri.parse('$baseUrl/winning-click-stats');

      print("📡 Appel API GET: $url");
      print("🔑 Token utilisé: $token");

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("📥 Statut code: ${response.statusCode}");
      print("📥 Réponse brute: ${response.body}");

      switch (response.statusCode) {
        case 200:
          final decoded = jsonDecode(response.body);

          print("✅ Décodé avec succès: $decoded");

          apiResponse.data = decoded['clones'] ?? [];
          apiResponse.message =
              "Total: ${decoded['total_clicks']} clics, ${decoded['total_amount']} CFA";
          break;

        case 401:
          print("⛔ Erreur 401: non autorisé");
          apiResponse.error = unauthorized;
          break;

        default:
          print(
              "⚠️ Erreur inconnue (${response.statusCode}): ${response.body}");
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e, stack) {
      print("🔥 Exception dans getSellerWinningClickStats: $e");
      print("🧵 Stacktrace: $stack");
      apiResponse.error = serverError;
    }

    return apiResponse;
  }
}
