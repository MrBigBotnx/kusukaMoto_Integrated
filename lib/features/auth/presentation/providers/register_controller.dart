import 'package:flutter/material.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterController extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  RegisterController(this.registerUseCase);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscureText = true;

  Future<bool> register() async {
    isLoading = true;
    notifyListeners();

    final success = await registerUseCase(
      name: nameController.text,
      email: emailController.text.trim(),
      contact: contactController.text.trim(),
      password: passwordController.text,
    );

    isLoading = false;
    notifyListeners();
    return success;
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void setName(String value) {
    nameController.text = value;
    notifyListeners();
  }

  void setEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  void setContact(String value) {
    contactController.text = value;
    notifyListeners();
  }

  void setPassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }
}
