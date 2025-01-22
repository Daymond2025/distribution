import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/post.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

// GET ALL POSTs -------------------------------
class PostService{

  Future<ApiResponse> findAll() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/post'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );

      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Post>((json) => Post.fromJson(json))
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

  Future<ApiResponse> likeNo(int postId) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse('${baseURL}seller/post/$postId/like_on_unlike'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> find(int postId) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse('${baseURL}seller/post/$postId'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Post.fromJsonByComments(jsonDecode(response.body)['data']);
          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> storeComment(int postId, String commentaire) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http
          .post(Uri.parse('${baseURL}seller/post/$postId/comment'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'comment': commentaire
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteComment(int id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/comment/$id'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

}



