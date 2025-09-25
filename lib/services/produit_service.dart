import 'dart:convert';

import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/models/favorite.dart';
import 'package:distribution_frontend/models/product.dart';

import 'package:distribution_frontend/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:distribution_frontend/constante.dart';

class ProductService {
  Future<ApiResponse> products(String params) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      print("==le token $token , $params");
      final response = await http.get(
        Uri.parse('${baseURL}seller/product?$params'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          // print('==produits ${jsonDecode(response.body)['data'][0].images}');
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Product>((json) => Product.fromJson(json))
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

  //Produits gagnants clics 25
  Future<ApiResponse> getWinningProducts(
      {int page = 1, int perPage = 10}) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();
      print("[API] Token récupéré : $token");

      final response = await http.get(
        Uri.parse(
            '${baseURL}front/product/winning?page=$page&per_page=$perPage'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("[API] Status code: ${response.statusCode}");
      print("[API] Response body: ${response.body}");

      switch (response.statusCode) {
        case 200:
          var jsonData = jsonDecode(response.body);

          print("[API] Structure JSON reçue: ${jsonData.keys}");

          // ⚡ Ici 'data' est directement un tableau
          var listData = jsonData['data'] as List;

          apiResponse.data = {
            "products": listData.map((p) => Product.fromJson(p)).toList(),
            "currentPage": jsonData['meta']['current_page'],
            "lastPage": jsonData['meta']['last_page'],
          };

          print("[API] Produits reçus: ${listData.length}, "
              "page ${jsonData['meta']['current_page']}/${jsonData['meta']['last_page']}");
          break;

        case 401:
          apiResponse.error = unauthorized;
          print("[API] Erreur 401 : Token expiré ou invalide");
          break;

        default:
          apiResponse.error = somethingWentWrong;
          print(
              "[API] Erreur inconnue (${response.statusCode}) : ${response.body}");
      }
    } catch (e, stack) {
      apiResponse.error = serverError;
      print("[API] Exception attrapée: $e");
      print("[API] Stacktrace: $stack");
    }

    return apiResponse;
  }

  Future<ApiResponse> aliasProducts(String alias) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/product/$alias'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Product>((json) => Product.fromJson(json))
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

  Future<ApiResponse> getFavorites() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/favorite'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data']
              .map<Favorite>((json) => Favorite.fromJson(json))
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

  Future<ApiResponse> find(int id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/product/$id/show'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = json.decode(response.body);
          apiResponse.data as dynamic;
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

  Future<ApiResponse> deleteFavorite(int id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse('${baseURL}seller/favorite/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.message = json.decode(response.body)['message'];
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

Future<int> getControllerAnnonce() async {
  int post = 0;
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}danger/controller'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        post = json.decode(response.body)['res'];
        break;

      default:
        post = 2;
    }
  } catch (e) {
    post = -1;
  }

  return post;
}

Future<String> getUpdateAnnonce() async {
  String post = '';
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}danger/update'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        post = json.decode(response.body)['message'];
        break;

      default:
        post = "";
    }
  } catch (e) {
    print(e);
  }

  return post;
}

Future<ApiResponse> allProducts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}all/produits'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
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

Future<ApiResponse> getProduit(String nomEtat) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produits/$nomEtat'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
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

Future<ApiResponse> getProduitVendus(String nomEtat) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produits/vendus/$nomEtat'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
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

Future<ApiResponse> getProduitDetail(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produit/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produit'];

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

Future<ApiResponse> getProduitDetail1(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produit/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            Product.fromJson(jsonDecode(response.body)['product']);

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

Future<ApiResponse> getProduitDetailFavorie(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produit/$id/vendeur/favorie'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);

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

//sous cateogrie => produits()
Future<ApiResponse> getProduitsSimilaire(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}produit/similaire/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
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

//search
Future<ApiResponse> searchProduit() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}search/produits'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map<Product>((json) => Product.fromJson(json))
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

Future<ApiResponse> aliasRecherche(String search) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('${baseURL}search/produits'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'search': search},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
            .toList();
        break;

      case 403:
        apiResponse.error = 'Produit non trouvé!';
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

Future<ApiResponse> controllerSearch(String search) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('${baseURL}searchAjax/produits/$search'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map<Product>((json) => Product.fromJson(json))
            .toList();
        break;

      case 403:
        apiResponse.error = 'Produits non trouvé!';
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }

  return apiResponse;
}

Future<ApiResponse> aliasRechercheRecent(String search) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('${baseURL}search/produits/recents'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'search': search},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
            .toList();
        break;

      case 403:
        apiResponse.error = 'Produit non trouvé!';
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

Future<ApiResponse> aliasRechercheVendu(String search) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('${baseURL}search/produits/vendus'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'search': search},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['produits']
            .map<Product>((json) => Product.fromJson(json))
            .toList();
        break;

      case 403:
        apiResponse.error = 'Produit non trouvé!';
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
