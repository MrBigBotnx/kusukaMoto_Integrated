// ignore_for_file: avoid_print, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/providers.dart';
import '../view_models/login_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'CreateAccount.dart';
import 'HomePage.dart';
import 'RecoverPassword.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF070245),
        title: Text('Entrar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/kusuka.png',
                height: 250,
              ),
              SizedBox(height: 16),
              Text(
                "Log In!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF142D55),
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                icon: Icons.email,
                onChanged: viewModel.setEmail,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  bool _obscureText = true;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF070245),
                        ),
                      ),
                      TextField(
                        obscureText: _obscureText,
                        onChanged: viewModel.setPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF070245)),
                          hintText: 'Digite sua senha',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF070245)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF070245)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF070245)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Color(0xFF070245),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 24),
              CustomButton(
                text: "Log In",
                onPressed: () async {
                  bool success = await _firebaseLogin(authService, viewModel.email, viewModel.password, context);
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Credenciais inválidas')),
                    );
                  }
                },
                isLoading: viewModel.isLoading,
              ),
              SizedBox(height: 16),
              Text("Não tem uma conta?", style: TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccount()),
                ),
                child: Text(
                  "Criar uma conta",
                  style: TextStyle(
                    color: Color(0xFFFF6F61),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecoverPassword()),
                ),
                child: Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                    color: Color(0xFF070245),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _firebaseLogin(AuthService authService, String email, String password, BuildContext context) async {
    try {
      final user = await authService.loginIn(email, password);
      return user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
