import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/retraits.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

class RetraitsService {
  Future<ApiResponse> getRetraits(int? page, int? size, String? statut) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      // Construire l'URL avec les query parameters
      Uri uri = Uri.parse('${baseURL}seller/retraits');
      // .replace(
      //   queryParameters: {
      //     if (statut != null) 'statut': statut,
      //     if (page != null) 'page': page,
      //     if (size != null) 'size': size,
      //     if (user_id != null) 'user_id': user_id,
      //   },
      // );
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("retrait statut code ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          // apiResponse.data = json.decode(response.body);
          print('Retrait data ${jsonDecode(response.body)['data']}');
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Retrait>((json) => Retrait.fromJson(json))
              .toList();
          // apiResponse.data as dynamic;

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print('Error retrait : $e');
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> storeRetraits(
    String numero,
    String operateur,
    String montant,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      print('numero $numero , operateur $operateur , montant $montant');
      String token = await getToken();
      final response =
          await http.post(Uri.parse('${baseURL}seller/retraits'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'telephone': numero,
        'operateur': operateur,
        'montant': montant,
      });
      print('le status code == ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          apiResponse.message = jsonDecode(response.body)['message'];
          break;

        case 201:
          apiResponse.message = jsonDecode(response.body)['message'];
          break;

        case 404:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 422:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          var message = jsonDecode(response.body)['message'];
          print('la reponse == $message');
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = 'Error';
    }

    return apiResponse;
  }
}
