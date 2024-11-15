// ignore_for_file: avoid_print, dead_code
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/providers.dart';
import '../view_models/login_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'CreateAccount.dart';
import 'HomePage.dart';
import 'AdminDashboard.dart';
import 'RecoverPassword.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    final obscureTextProvider = StateProvider((_) => true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF070245),
        title: const Text('Entrar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              const SizedBox(height: 16),
              const Text(
                "Log In!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF142D55),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                icon: Icons.email,
                onChanged: viewModel.setEmail,
              ),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, _) {
                  final obscureText = ref.watch(obscureTextProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF070245),
                        ),
                      ),
                      TextField(
                        obscureText: obscureText,
                        onChanged: viewModel.setPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Color(0xFF070245)),
                          hintText: 'Digite sua senha',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF070245)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF070245)),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF070245)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xFF070245),
                            ),
                            onPressed: () {
                              ref.read(obscureTextProvider.notifier).state = !obscureText;
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Log In",
                onPressed: () async {
                  bool success = await viewModel.login();
                  if (success) {
                    final tipoUsuario = await ref.read(authServiceProvider).getTipoUsuario();
                    if (tipoUsuario == 'admin') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDashboard()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Credenciais inválidas')),
                    );
                  }
                },
                isLoading: viewModel.isLoading,
              ),
              const SizedBox(height: 16),
              const Text("Não tem uma conta?", style: TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateAccount()),
                ),
                child: const Text(
                  "Criar uma conta",
                  style: TextStyle(
                    color: Color(0xFFFF6F61),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecoverPassword()),
                ),
                child: const Text(
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
}
