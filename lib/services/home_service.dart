import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

class HomeService{

  Future<ApiResponse> getAd() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/new_ad'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = json.decode(response.body);
          apiResponse.data as dynamic;
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

  Future<ApiResponse> getDashboard() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/dashboard'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = json.decode(response.body);
          apiResponse.data as dynamic;
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

  Future<ApiResponse> menu() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/menu'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = json.decode(response.body);
          apiResponse.data as dynamic;
          break;

        case 403:
          apiResponse.error = json.decode(response.body)['message'];
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


