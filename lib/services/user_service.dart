import 'dart:convert';
import 'dart:io';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // LOGIN -------------------------------
  Future<ApiResponse> login(String contact, String appSignature) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse('${baseURL}auth/seller/send_sms'),
        headers: {'Accept': 'application/json'},
        body: {
          'person': 'seller',
          'option': 'login',
          'phone_number': contact,
          'appSignature': appSignature
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body);
          apiResponse.data as dynamic;
          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;

        case 404:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = e.toString();
    }

    return apiResponse;
  }

// CONFIRM LOGIN -------------------------------
  Future<ApiResponse> confirmLogin(String contact, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse('${baseURL}auth/seller/login'),
          headers: {'Accept': 'application/json'},
          body: {'phone_number': contact, 'password': password});

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body);
          apiResponse.data as dynamic;
          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = e.toString();
    }

    return apiResponse;
  }

// REGISTER ETAPE ONE -------------------------------
  Future<ApiResponse> register(String contact) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse('${baseURL}auth/seller/send_sms'),
        headers: {'Accept': 'application/json'},
        body: {
          'person': 'seller',
          'option': 'register',
          'phone_number': contact,
        },
      );

      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body);
          apiResponse.data as dynamic;
          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;

        case 404:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      apiResponse.error = e.toString();
    }

    return apiResponse;
  }

// Register -------------------------------
  Future<ApiResponse> confirmRegister(
    String firstName,
    String lastName,
    String job,
    String phoneNumber,
    String code,
    int cityId,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .post(Uri.parse('${baseURL}auth/seller/register'), headers: {
        'Accept': 'application/json'
      }, body: {
        'first_name': firstName,
        'last_name': lastName,
        'job': job,
        'phone_number': phoneNumber,
        'city_id': cityId.toString(),
        'password': code,
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body);
          apiResponse.data as dynamic;
          break;

        case 422:
          final errors = jsonDecode(response.body)['message'];
          apiResponse.error = errors;
          break;

        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = serverError;
    }

    return apiResponse;
  }

  // Detail User -------------------------------
  Future<ApiResponse> getUserDetail() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Seller.fromJson(jsonDecode(response.body)['data']);
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
      apiResponse.error = serverError;
    }

    return apiResponse;
  }

  Future<ApiResponse> updateBoutique(
    File? imagePath,
    String nom,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      // Crée un client HTTP multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseURL}seller/update/store'),
      );
      // Ajoute les headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Ajoute les champs du formulaire
      request.fields['nom_boutique'] = nom;

      // Si une image est fournie, ajoute-la au corps de la requête
      if (imagePath != null) {
        var file =
            await http.MultipartFile.fromPath('couverture', imagePath.path);
        request.files.add(file);
      }

      // Envoie la requête et attends la réponse
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Vérifie le statut de la réponse
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 422:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print("erreur : $e");
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  Future<ApiResponse> updateUser(
    File? imagePath,
    String nom,
    String prenom,
    int ville,
    String profession,
    String email,
  ) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();

      print("infos vile : ${ville.toString()} , token : $token ");

      // Crée un client HTTP multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseURL}seller/update'),
      );

      // Ajoute les headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Ajoute les champs du formulaire
      request.fields['first_name'] = nom;
      request.fields['last_name'] = prenom;
      request.fields['city_id'] = ville.toString();
      request.fields['job'] = profession;
      request.fields['email'] = email;

      // Si une image est fournie, ajoute-la au corps de la requête
      if (imagePath != null) {
        var file =
            await http.MultipartFile.fromPath('picture_path', imagePath.path);
        request.files.add(file);
      }

      // Envoie la requête et attends la réponse
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Vérifie le statut de la réponse
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 422:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print("erreur : $e");
      apiResponse.error = serverError;
    }

    return apiResponse;
  }

  // Future<ApiResponse> updateUser(String? image, String nom, String prenom,
  //     int ville, String profession, String email) async {
  //   ApiResponse apiResponse = ApiResponse();
  //   try {
  //     String token = await getToken();
  //     print("infos vile : ${ville.toString()} , token : $token ");

  //     final response = await http.post(Uri.parse('${baseURL}seller/update'),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token'
  //         },
  //         body: image != null
  //             ? {
  //                 'picture_path': image,
  //                 'first_name': nom,
  //                 'last_name': prenom,
  //                 'city_id': ville.toString(),
  //                 'job': profession,
  //                 'email': email,
  //               }
  //             : {
  //                 'first_name': nom,
  //                 'last_name': prenom,
  //                 'city_id': ville.toString(),
  //                 'job': profession,
  //                 'email': email,
  //               });

  //     switch (response.statusCode) {
  //       case 200:
  //         apiResponse.data = jsonDecode(response.body)['message'];
  //         break;

  //       case 422:
  //         apiResponse.error = jsonDecode(response.body)['message'];
  //         break;

  //       case 401:
  //         apiResponse.error = unauthorized;
  //         break;

  //       case 403:
  //         apiResponse.error = jsonDecode(response.body)['message'];
  //         break;

  //       default:
  //         apiResponse.error = somethingWentWrong;
  //     }
  //   } catch (e) {
  //     apiResponse.error = serverError;
  //   }

  //   return apiResponse;
  // }
}

// Detail User -------------------------------
Future<ApiResponse> getCommissions() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}user/vendeur/commissions'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['commandes'];

        apiResponse.data as List;
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
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<String> oneSignalToken(String tokenN) async {
  String apiResponse = '';
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('${baseURL}user/vendeur/one-signal/token'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'token': tokenN,
    });

    switch (response.statusCode) {
      case 200:
        print(tokenN);
        apiResponse = jsonDecode(response.body)['message'].toString();
        break;

      case 401:
        apiResponse = unauthorized;
        break;

      case 403:
        apiResponse = jsonDecode(response.body)['message'].toString();
        break;

      default:
        apiResponse = jsonDecode(response.body)['message'].toString();
    }
  } catch (e) {
    apiResponse = e.toString();
  }

  return apiResponse;
}

//GET TOKEN-----------------------
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//GET USER ID-----------------------
Future<int> getVendeurId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('vendeurId') ?? 0;
}

//GET USER NAME-----------------------
Future<String> getVendeurName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('name') ?? '';
}

//GET LOGOUT-----------------------
Future<bool> logout() async {
  String token = await getToken();
  await http.post(Uri.parse('${baseURL}logout'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove('onesignaltoken');
  return await pref.remove('token');
}

//GET DELETE-----------------------
Future<ApiResponse> deleteVendeurUser() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print('Token: $token'); // Log du token pour vérifier sa validité
    final response = await http.delete(
      // Utilisez http.delete ici
      Uri.parse('${baseURL}seller/delete'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    print(
        'Response status: ${response.statusCode}'); // Log du statut de la réponse
    print('Response body: ${response.body}'); // Log du corps de la réponse

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('token');
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
    print('Error: $e'); // Log de l'erreur
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}

//Get base64 encoded
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
