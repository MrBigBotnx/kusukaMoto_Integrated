import 'package:flutter/material.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterController extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  RegisterController(this.registerUseCase);

  String email = '';
  String password = '';
  String name = '';
  String contact = '';
  bool isLoading = false;

  void setEmail(String value) => email = value;
  void setPassword(String value) => password = value;
  void setName(String value) => name = value;
  void setContact(String value) => contact = value;

  Future<bool> register() async {
    isLoading = true;
    notifyListeners();

    final success = await registerUseCase(
      email: email,
      password: password,
      name: name,
      contact: contact,
    );

    isLoading = false;
    notifyListeners();
    return success;
  }
}
