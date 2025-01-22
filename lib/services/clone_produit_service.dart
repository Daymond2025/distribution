import 'dart:convert';

import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/clone.dart';
import 'package:distribution_frontend/models/orderClone.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:distribution_frontend/api_response.dart';

class CloneProductService {
  Future<ApiResponse> allProducts() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/share/product'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<CloneProduct>((json) => CloneProduct.fromJson(json))
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

  Future<ApiResponse> cloneOrder(int clone_id, int size, int page) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse(
            '${baseURL}seller/share/product-clone/$clone_id/orders?size=$size&page=$page'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']['orders']
              .map<OrderClone>((json) => OrderClone.fromJson(json))
              .toList();

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print("Erreur : " + e.toString());
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> storeClone(int product, String title, String subTitle,
      String description, String price, String phoneNumber) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http
          .post(Uri.parse('${baseURL}seller/share/product'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'product_id': product.toString(),
        'title': title,
        'sub_title': subTitle,
        'description': description,
        'price': price,
        'phone_number_customer': phoneNumber,
      });

      switch (response.statusCode) {
        case 201:
          apiResponse.data = jsonDecode(response.body)['data'] as dynamic;
          apiResponse.message = jsonDecode(response.body)['message'];
          apiResponse.message as dynamic;

          break;

        case 401:
          apiResponse.error = unauthorized;
          break;

        default:
          apiResponse.error = jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> deleteClone(int id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http
          .delete(Uri.parse('${baseURL}seller/share/product/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.message = jsonDecode(response.body)['message'];

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
