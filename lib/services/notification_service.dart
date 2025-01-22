import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/notification_view.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getNotifications() async {
  ApiResponse apiResponse = ApiResponse();

  try {

    String token = await getToken();
    final response = await http.get(
        Uri.parse('${baseURL}notifications'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['notifications']
            .map<NotificationView>((json) => NotificationView.fromJson(json))
            .toList();
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

Future<ApiResponse> showNotification(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}notification/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['notification'];
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
    apiResponse.error = 'Echec à la connexion avec le serveur!';
  }

  return apiResponse;
}

Future<ApiResponse> deleteNotification(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('${baseURL}notification/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['message'];
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
