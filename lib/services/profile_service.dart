import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<ApiResponse> getProfile() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/message_profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Profile>((json) => Profile.fromJson(json))
              .toList();
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

  Future<ApiResponse> getConversations() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/conversation'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:

          apiResponse.data = jsonDecode(response.body)['data']
              .map<Conversation>((json) => Conversation.fromJsonConversation(json))
              .toList();

          break;

        case 404:

          apiResponse.error = json.decode(response.body)['message'];

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

  Future<ApiResponse> getConversation(int id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/conversation/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print(response.body);
      switch (response.statusCode) {
        case 200:

          apiResponse.data =  Conversation.fromJson(jsonDecode(response.body)['data']);

          break;

        case 404:

          apiResponse.error = json.decode(response.body)['message'];

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

  Future<ApiResponse> storeConversation(String idProfile, String message,
      String? object, String? idObject) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.post(
        Uri.parse('${baseURL}seller/conversation'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: object != null
            ? {
                'message_profile_id': idProfile,
                'message': message,
                'category': object,
                'category_id': idObject,
              }
            : {
                'message_profile_id': idProfile,
                'message': message,
              },
      );

      print(response.body);
      switch (response.statusCode) {
        case 200:

          apiResponse.data = Conversation.fromJson(jsonDecode(response.body)['data']);

          break;

        case 422:

          apiResponse.error = json.decode(response.body)['message'];

          break;

        case 404:

          apiResponse.error = json.decode(response.body)['message'];

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> storeMessage(String conversationID, String message) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.post(
        Uri.parse('${baseURL}seller/message'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
       body:  {
          'conversation_id': conversationID,
          'message': message,
        },
      );

      print(response.body);
      switch (response.statusCode) {
        case 200:

          apiResponse.message = jsonDecode(response.body)['message'];

          break;

        case 422:

          apiResponse.error = json.decode(response.body)['message'];

          break;

        case 404:

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
