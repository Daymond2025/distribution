import 'dart:io';

import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/models/seller.dart';

class SellerProvider extends ChangeNotifier {
  Seller? _seller;
  bool _isLoading = false;

  Seller? get seller => _seller;
  bool get isLoading => _isLoading;

  final UserService _userService = UserService();

  Future<void> loadSeller(Seller seller) async {
    _seller = seller;
    notifyListeners();
  }

  Future<void> updateSeller(Seller updatedSeller, {File? image}) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse response = await _userService.updateUser(
      image,
      updatedSeller.firstName,
      updatedSeller.lastName,
      updatedSeller.cityId,
      updatedSeller.job,
      updatedSeller.email ?? '',
    );

    if (response.error == null) {
      _seller = updatedSeller;
    }

    _isLoading = false;
    notifyListeners();
  }
}
