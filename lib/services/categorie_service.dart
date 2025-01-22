import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getCategories() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}categories'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['categories'];

        apiResponse.data as List<dynamic>;
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'Echec à la connexion. Veillez réessayer svp!';
  }

  return apiResponse;
}

Future<ApiResponse> getSousCategoriesInCategire(String nom) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}categorie/$nom'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['categories'];

        apiResponse.data as List<dynamic>;
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

Future<ApiResponse> getSousCategoriesInCategireInId(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}categorie/id/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['categories'];

        apiResponse.data as List<dynamic>;
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

Future<ApiResponse> getProduitsCategories(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produits/categorie/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['categories'];

        apiResponse.data as List<dynamic>;
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

Future<ApiResponse> getProduitsSousCategorie(int id, int idsous) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}souscategorie/$idsous'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['souscategories'];

        apiResponse.data as List<dynamic>;
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
