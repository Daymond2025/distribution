import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getEtats() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}etats'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['etats'];

        apiResponse.data as List;
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print(e);
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}
