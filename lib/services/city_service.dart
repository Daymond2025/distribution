
import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:distribution_frontend/models/city.dart';

class CityService {
  
  Future<ApiResponse> getCity() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}params/data?option=city'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<City>((json) => City.fromJson(json))
              .toList();
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        default:
      }
    } catch (e) {
      apiResponse.error = somethingWentWrong;
    }

    return apiResponse;
  }

  Future<ApiResponse> getCityAndFocalPoint() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}params/data?option=city_focal_points'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print(jsonDecode(response.body));
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<City>((json) => City.fromJsonFocalPoint(json))
              .toList();
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        default:
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = somethingWentWrong;
    }

    return apiResponse;
  }
}