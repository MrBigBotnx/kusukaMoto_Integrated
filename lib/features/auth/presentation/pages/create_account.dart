import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/register_providers.dart';

class CreateAccountScreen extends ConsumerWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(registerControllerProvider);
    final isLoading = controller.isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFF00E0C6),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  'KusukaMoto',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Form
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Crie a sua conta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF070245),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      'Nome',
                      Icons.person,
                      controller.nameController.text,
                      (value) => controller.setName(value),
                    ),
                    _buildTextField(
                      'Email',
                      Icons.email,
                      controller.emailController.text,
                      (value) => controller.setEmail(value),
                    ),
                    _buildTextField(
                      'Contacto',
                      Icons.phone,
                      controller.contactController.text,
                      (value) => controller.setContact(value),
                    ),
                    _buildPasswordField(
                      'Senha',
                      Icons.lock,
                      controller.passwordController,
                      ref,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                final success = await controller.register();
                                if (success) {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Erro ao criar conta')),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF070245),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'CRIAR',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    IconData icon,
    TextEditingController controller,
    WidgetRef ref,
  ) {
    final obscureText = ref.watch(registerControllerProvider).obscureText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF070245),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Color(0xFF070245)),
            hintText: 'Digite sua $label',
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
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0xFF070245),
              ),
              onPressed: () {
                ref
                    .read(registerControllerProvider.notifier)
                    .togglePasswordVisibility();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    String value,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF070245),
          ),
        ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF070245)),
            hintText: 'Digite seu $label',
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
          ),
        ),
      ],
    );
  }
}
