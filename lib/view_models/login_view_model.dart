import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../services/providers.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService;
  String email = '';
  String password = '';
  bool isLoading = false;

  LoginViewModel(this._authService);

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();
    final user = await _authService.loginIn(email, password);
    isLoading = false;
    notifyListeners();
    return user != null;
  }

  void setEmail(String value) => email = value;
  void setPassword(String value) => password = value;
}

final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
  return LoginViewModel(ref.read(authServiceProvider));
});
