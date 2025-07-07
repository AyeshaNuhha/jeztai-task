import 'package:flutter/material.dart';
import 'package:jezt_intern_task/service/api_services.dart';

class AuthProvider extends ChangeNotifier {
  String? token;

  bool get isAuthenticated => token != null;

  Future<bool> login(String companyId, String password) async {
    final result = await ApiService.login(companyId, password);
    if (result != null) {
      token = result;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    if (token != null) {
      await ApiService.logout(token!);
      token = null;
      notifyListeners();
    }
  }
}
