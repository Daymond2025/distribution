import 'dart:convert';

import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/models/orderClone.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:distribution_frontend/api_response.dart';
import 'package:flutter/services.dart'; // pour Clipboard
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloneProductService {
  Future<ApiResponse> allProducts() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/share/product'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("le staut code clone ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<CloneProduct>((json) => CloneProduct.fromJson(json))
              .toList();
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = e.toString();
    }

    return apiResponse;
  }

  Future<ApiResponse> cloneOrder(int clone_id, int size, int page) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse(
            '${baseURL}seller/share/product-clone/$clone_id/orders?size=$size&page=$page'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']['orders']
              .map<OrderClone>((json) => OrderClone.fromJson(json))
              .toList();

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print("Erreur : " + e.toString());
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> cloneAndCopyLink({
    required int productId,
    required String title,
    required String subTitle,
    required String description,
    required num price,
    required int commission,
  }) async {
    ApiResponse apiResponse = ApiResponse();

    // 🔢 Conversion du prix en String
    String priceStr = price.toString();
    print("Prix reçu en num : $price");
    print("Prix converti en string : $priceStr");

    try {
      // 🔐 Récupérer le token
      String token = await getToken();
      print("TOKEN RÉCUPÉRÉ : $token");

      // 🔍 Corriger le format s’il contient un pipe '|'
      if (token.contains('|')) {
        token = token.split('|')[1];
      }

      // 📦 Chercher le numéro localement
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phoneNumber = prefs.getString('phone_number');

      // 🔄 Sinon on appelle l’API
      if (phoneNumber == null || phoneNumber.isEmpty) {
        phoneNumber = await getPhoneNumber(token);
      }

      // ❌ Si toujours pas trouvé
      if (phoneNumber == null || phoneNumber.isEmpty) {
        apiResponse.error =
            "Erreur : Numéro de téléphone introuvable. Veuillez vous reconnecter.";
        return apiResponse;
      }

      // 🚀 Requête de clonage
      final response = await http.post(
        Uri.parse('${baseURL}seller/share/product'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'product_id': productId.toString(),
          'title': title,
          'sub_title': subTitle,
          'description': description,
          'price': priceStr,
          'phone_number_customer': phoneNumber,
          'commission': commission.toString(),
        },
      );

      print("BODY /seller/share/product : ${response.body}");

      switch (response.statusCode) {
        case 201:
          final body = jsonDecode(response.body);
          final link = body['message']; // ✅ Le lien est ici

          if (link != null && link is String && link.isNotEmpty) {
            await Clipboard.setData(ClipboardData(text: link));
            apiResponse.data = link;
            apiResponse.message = "Lien copié avec succès.";
          } else {
            apiResponse.error = "Lien introuvable dans la réponse.";
          }
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          final message = jsonDecode(response.body)['message'];
          apiResponse.error = message ?? somethingWentWrong;
      }
    } catch (e) {
      print("Erreur lors du clonage automatique : $e");
      apiResponse.error = 'Une erreur s\'est produite.';
    }

    return apiResponse;
  }

// 📡 Fonction pour récupérer le numéro via l'API si non présent localement
  Future<String?> getPhoneNumber(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${baseURL}seller/phone_number/main'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Réponse de l'API /phone_number/main : ${response.body}");
      print("Status code /phone_number/main : ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final phone = data['phone_number'];

        if (phone != null && phone is String && phone.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('phone_number', phone);
          return phone;
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération via /phone_number/main : $e");
    }

    return null;
  }

  Future<ApiResponse> storeClone(
      int product,
      String title,
      String subTitle,
      String description,
      String price,
      String phoneNumber,
      int commission) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http
          .post(Uri.parse('${baseURL}seller/share/product'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'product_id': product.toString(),
        'title': title,
        'sub_title': subTitle,
        'description': description,
        'price': price,
        'phone_number_customer': phoneNumber,
        'commission': commission.toString()
      });

      switch (response.statusCode) {
        case 201:
          apiResponse.data = jsonDecode(response.body)['data'] as dynamic;
          apiResponse.message = jsonDecode(response.body)['message'];
          apiResponse.message as dynamic;

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> deleteClone(int id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http
          .delete(Uri.parse('${baseURL}seller/share/product/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.message = jsonDecode(response.body)['message'];

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }
}
