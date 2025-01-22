import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:distribution_frontend/models/city.dart';

class CountryService {
  Future<ApiResponse> all() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse('${baseURL}params/data?option=country_detail'),
        headers: {
          'Accept': 'application/json',
        },
      );
      // print(jsonDecode(response.body));
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Country>((json) => Country.fromJson(json))
              .toList();
          // print("reponse ${apiResponse.data}");
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
