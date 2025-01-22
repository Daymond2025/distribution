import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/phone_number.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;


Future<ApiResponse> getContacts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}seller/phone_number'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map<PhoneNumber>((json) => PhoneNumber.fromJson(json))
            .toList();
        break;

      case 404:
        apiResponse.error = jsonDecode(response.body)['message'];
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

Future<ApiResponse> deleteContact(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('${baseURL}seller/phone_number/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.message = jsonDecode(response.body)['message'];
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

Future<ApiResponse> createContact(String numero, String operateur) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('${baseURL}seller/phone_number'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'phone_number': numero,
      'operator': operateur,
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.message = jsonDecode(response.body)['message'];
        break;

      case 422:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'Error';
  }

  return apiResponse;
}

Future<ApiResponse> storeTransactionRetrait(
  String numero,
  String operateur,
  String montant,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('${baseURL}seller/payment/withdrawal'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'phone_number': numero,
          'operator': operateur,
          'amount': montant,
        });

    switch (response.statusCode) {
      case 200:
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
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'Error';
  }

  return apiResponse;
}
