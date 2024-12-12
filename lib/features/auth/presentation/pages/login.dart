import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kusuka_moto/features/auth/presentation/providers/login_providers.dart';
import 'package:kusuka_moto/widgets/custom_button.dart';
import 'package:kusuka_moto/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    final obscureText = ref.watch(obscureTextProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        backgroundColor: const Color(0xFF00E0C6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                  color: Color(0xFF2B508C)),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "email",
              icon: Icons.email,
              onChanged: viewModel.setEmail,
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: obscureText,
              onChanged: viewModel.setPassword,
              decoration: InputDecoration(
                hintText: "Introduza a tua senha",
                prefixIcon: const Icon(Icons.lock, color: Color(0xFF070245)),
                suffixIcon: IconButton(
                  onPressed: () =>
                      ref.read(obscureTextProvider.notifier).toggle(),
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF070245)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Log In",
              onPressed: () async {
                final success = await viewModel.login();
                if (success) {
                  // Navigate to other page
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Credenciais inválidas")),
                  );
                }
              },
              isLoading: viewModel.isLoading,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Criar uma conta",
                style: TextStyle(color: Colors.orange),
              ),
            )
          ],
        ),
      ),
    );
  }
}
