import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getCouvertures() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}couvertures'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {

      case 200:
        apiResponse.data = json.decode(response.body)['couvertures'];

        apiResponse.data as List;
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

Future<int> getPostVue() async {
  int post = 0;
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}couvertures'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {

      case 200:
        post = json.decode(response.body)['post'];
        break;

      default:
        post = 2;
    }
  } catch (e) {
    post = -1;
  }

  return post;
}
