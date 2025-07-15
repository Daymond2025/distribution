import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/order.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<ApiResponse> count() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/order-count'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = json.decode(response.body)['data'];
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
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }

  Future<ApiResponse> findAll(String params) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/order?$params'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("le statut code ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          print("la reponse ${jsonDecode(response.body)['data']}");
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Order>((json) => Order.fromJson(json))
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
      print(e.toString());
      apiResponse.error = 'serverError';
    }

    return apiResponse;
  }
}

Future<ApiResponse> storeCommandeClient(
  int id,
  String cityId,
  String fullName,
  String contact,
  int qte,
  int fees,
  String date,
  String hour,
  String price,
  int focalPoint,
  int commission,
  String detail,
  String size,
  String color,
) async {
  ApiResponse apiResponse = ApiResponse();
  print("prix tapé dans lapi ${date}  ${hour}");
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse('${baseURL}seller/order'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'person': 'client',
      'product_id': id.toString(),
      'city_id': cityId,
      'name': fullName,
      'frais': fees.toString(),
      'phone_number': contact,
      'quantity': qte.toString(),
      'date': date,
      'time': hour,
      'focal_point_id': focalPoint.toString(),
      'price': price,
      'detail': detail,
      'size': size,
      'color': color,
      'commission': commission.toString()
    });

    print("commande statut code ${response.statusCode}");
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
    print(e.toString());
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}

Future<ApiResponse> updateCommandeClient(
    int idCommande,
    String qte,
    String nom,
    String contact1,
    String contact2,
    String frais,
    String lieu,
    int ambassador,
    String date,
    String heure,
    String prix,
    String detail,
    String taille,
    String couleur) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('${baseURL}client/commande/$idCommande'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'qte': qte,
      'nom': nom,
      'contact1': contact1,
      'contact2': contact2,
      'frais': frais,
      'lieu': lieu,
      'ambassador_id': ambassador.toString(),
      'date': date,
      'heure': heure,
      'prix': prix == '' ? '0' : prix,
      'detail': detail,
      'taille': taille,
      'couleur': couleur,
    });
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
        print("ERREUR STATUS CODE ${response.statusCode}");
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print('===Erreur == ${e.toString()}');
    apiResponse.error = 'Error';
  }

  return apiResponse;
}

Future<ApiResponse> renovieCommandeClient(
    int idCommande,
    String qte,
    String nom,
    String contact1,
    String contact2,
    String frais,
    String lieu,
    int ambassador,
    String date,
    String heure,
    String prix,
    String detail,
    String taille,
    String couleur) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('${baseURL}client/renvoie/commande/$idCommande'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'qte': qte,
          'nom': nom,
          'contact1': contact1,
          'contact2': contact2,
          'frais': frais,
          'lieu': lieu,
          'ambassador_id': ambassador.toString(),
          'date': date,
          'heure': heure,
          'prix': prix == '' ? '0' : prix,
          'detail': detail,
          'taille': taille,
          'couleur': couleur,
        });
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
    apiResponse.error = 'Error';
  }

  return apiResponse;
}

Future<ApiResponse> storeCommandeMoi(
    String idProduit,
    String qte,
    String contact1,
    String cityId,
    String ambassador,
    String date,
    String heure,
    String detail) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse('${baseURL}seller/order'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'person': 'seller',
      'product_id': idProduit,
      'quantity': qte,
      'phone_number': contact1,
      'city_id': cityId,
      'ambassador_id': ambassador.toString(),
      'date': date,
      'time': heure,
      'detail': detail,
    });

    print(response.body);
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

Future<ApiResponse> indexCommande() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}commandes'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['data'];
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
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}

Future<ApiResponse> commandeData(int status) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}client/commandes/$status'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['orders']
            .map<Order>((json) => Order.fromJson(json))
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

Future<ApiResponse> showCommande(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}commande/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['commande'];
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
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}

Future<ApiResponse> vueCommandez(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse('${baseURL}commandevue/$id'),
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

Future<ApiResponse> cancelCommande(int id, String motif) async {
  ApiResponse apiResponse = ApiResponse();
  print(motif);
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse('${baseURL}seller/order/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'motif': motif},
    );
    print("le status commande ${response.statusCode} ");
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['message'];
        break;

      case 403:
        apiResponse.error = json.decode(response.body)['message'];
        break;

      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        print(
            "le message erreur commande ${jsonDecode(response.body)['message']} ");
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}

Future<ApiResponse> getCommandeMoi(
  int status,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}moi/commandes/$status'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['orders']
            .map<Order>((json) => Order.fromJson(json))
            .toList();

        apiResponse.data as List<dynamic>;
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'Une erreur s\'est produite: $e';
  }

  return apiResponse;
}

Future<ApiResponse> getToutCommandeMoi() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}moi/commandes'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['orders']
            .map<Order>((json) => Order.fromJson(json))
            .toList();
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'Une erreur s\'est produite: $e';
  }

  return apiResponse;
}

Future<ApiResponse> reclamation(
  int id,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse('${baseURL}commande/reclamation/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.message = 'Reclamation effectuée avec succès!';
        break;

      case 403:
        apiResponse.error = 'error';
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'Une erreur s\'est produite: $e';
  }

  return apiResponse;
}

Future<ApiResponse> updateCommandeMoi(
    int idCommande,
    String qte,
    String contact1,
    String frais,
    String lieu,
    String date,
    String heure,
    String detail,
    String taille,
    String couleur) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('${baseURL}moi/commande/$idCommande'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'qte': qte,
      'contact1': contact1,
      'frais': frais,
      'lieu': lieu,
      'date': date,
      'heure': heure,
      'detail': detail,
      'taille': taille,
      'couleur': couleur,
    });
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
    apiResponse.error = 'Error';
  }

  return apiResponse;
}

Future<ApiResponse> renovieCommandeMoi(
  int idCommande,
  String qte,
  String contact1,
  String frais,
  String lieu,
  String date,
  String heure,
  String detail,
  String taille,
  String couleur,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('${baseURL}moi/renvoie/commande/$idCommande'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'qte': qte,
          'contact1': contact1,
          'frais': frais,
          'lieu': lieu,
          'date': date,
          'heure': heure,
          'detail': detail,
          'taille': taille,
          'couleur': couleur,
        });
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
    apiResponse.error = 'Error';
  }

  return apiResponse;
}
