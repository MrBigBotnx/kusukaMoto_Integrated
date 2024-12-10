import 'package:flutter/material.dart';
import 'package:kusuka_moto/features/auth/domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase; // Certifique-se de que esta linha está correta.
  
  String email = '';
  String password = '';
  bool isLoading = false;

  LoginViewModel(this.loginUseCase);

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();
    final user = await loginUseCase(email, password);
    isLoading = false;
    notifyListeners();
    return user;
  }

  void setEmail(String value) => email = value;
  void setPassword(String value) => password = value;
}