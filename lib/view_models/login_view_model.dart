import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kusuka_moto/services/providers.dart';
import '../services/auth_service.dart';

final loginViewModelProvider = ChangeNotifierProvider((ref) {
  // Pass in the AuthService instance from the authServiceProvider
  final authService = ref.read(authServiceProvider);
  return LoginViewModel(authService);
});

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService;

  String email = '';
  String password = '';
  bool isLoading = false;

  LoginViewModel(this._authService);

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();

    final success = await _authService.login(email, password);

    isLoading = false;
    notifyListeners();

    return success;
  }
}
