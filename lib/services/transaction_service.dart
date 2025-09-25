import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

class WalletService {
  Future<ApiResponse> getWallet() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();

      final response = await http.get(
        Uri.parse('${baseURL}seller/wallet'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("=== [WalletService] STATUS CODE: ${response.statusCode} ===");

      switch (response.statusCode) {
        case 200:
          final raw = response.body;
          print("=== [WalletService] RAW RESPONSE ===");
          print(raw);

          final data = json.decode(raw);
          print("=== [WalletService] DECODED JSON ===");
          print(data);

          // On garde bien la structure complète
          apiResponse.data = {
            "wallet": data['wallet'],
            "transactions": data['transactions'], // ✅ garde {data, meta, links}
            "winning_wallet": data['winning_wallet'],
          };

          print("=== [WalletService] apiResponse.data ===");
          print(apiResponse.data);
          break;

        case 401:
          apiResponse.error = unauthorized;
          print("=== [WalletService] ERROR 401 Unauthorized ===");
          break;

        default:
          apiResponse.error = somethingWentWrong;
          print("=== [WalletService] ERROR ${response.statusCode} ===");
          print(response.body);
      }
    } catch (e) {
      apiResponse.error = 'serverError';
      print("=== [WalletService] Exception ===");
      print(e.toString());
    }

    return apiResponse;
  }
}

Future<ApiResponse> showUtilisateurTransaction(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}seller/transaction/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['transaction'];
        apiResponse.data as List<dynamic>;
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}
