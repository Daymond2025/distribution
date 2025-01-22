import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> showConversation(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}messagerie/conversation/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['conversation'];
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

//Conversation
Future<ApiResponse> createConversation(
    int idProfil, String message, String object, int idObject) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('${baseURL}messagerie/profil/$idProfil/conversation'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'id': idObject.toString(),
        'object': object,
        'message': message,
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['idConversation'];
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

Future<ApiResponse> storeMessage(
  int id,
  String message,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('${baseURL}messagerie/conversation/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'message': message},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.message = 'Message enregistré';
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

Future<int> getConverationVue() async {
  int post = 0;
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}nb/conversation'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {

      case 200:
        post = json.decode(response.body)['conversation'];
        break;

      default:
        post = 2;
    }
  } catch (e) {
    print(e);
  }

  return post;
}
