import 'package:flutter/material.dart';
import '../services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/login_view_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final viewModel = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logocar.png',
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
            CustomTextField(
              label: 'Password',
              icon: Icons.password,
              onChanged: viewModel.setPassword,
              obscureText: true,
            ),
            SizedBox(height: 24),
            CustomButton(
              text: "Log In",
              onPressed: () async {
                bool success = await viewModel.login();
                if (success) {
                  Navigator.pushNamed(context, '/home');
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
              onTap: () => Navigator.pushNamed(context, '/create_account'),
              child: Text(
                "Criar uma conta",
                style: TextStyle(
                  color: Color(0xFFFF6F61),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
