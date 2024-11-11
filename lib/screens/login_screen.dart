import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/login_view_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'CreateAccount.dart'; // Importe a tela de criar conta
import 'HomePage.dart'; // Importe a tela HomePage
import 'RecoverPassword.dart'; // Importe a tela de recuperação de senha

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF070245), // Cor do AppBar
        title: Text('Entrar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: SingleChildScrollView( // Tornando a tela rolável para facilitar em dispositivos pequenos
        child: Container(
          color: Colors.white, // Cor de fundo da tela de login
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
              buildPasswordField('Password', Icons.lock, viewModel.setPassword),
              SizedBox(height: 24),
              CustomButton(
                text: "Log In",
                onPressed: () async {
                  // Lógica básica de login
                  bool success =
                      await _basicLogin(viewModel.email, viewModel.password);
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // Navega para a HomePage após login
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
                  MaterialPageRoute(
                      builder: (context) =>
                          CreateAccount()), // Navegar para a tela de criação de conta
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
                  MaterialPageRoute(
                      builder: (context) =>
                          RecoverPassword()), // Navegar para a tela de recuperação de senha
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

  // Função para validar o login
  Future<bool> _basicLogin(String email, String password) async {
    // Lógica de validação de login (pode ser substituída por uma verificação no banco de dados)
    const validEmail = "test@example.com"; // E-mail de exemplo para validação
    const validPassword = "123456"; // Senha de exemplo para validação

    // Simula uma verificação de login
    if (email == validEmail && password == validPassword) {
      return true; // Retorna verdadeiro se as credenciais estiverem corretas
    } else {
      return false; // Retorna falso caso as credenciais sejam inválidas
    }
  }

  Widget buildPasswordField(
      String label, IconData icon, Function(String) onChanged) {
    bool _obscureText = true; // Estado da visibilidade da senha

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
          obscureText: _obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon,
                color: Color(0xFF070245)), // Ícone associado ao campo
            hintText: 'Digite sua $label', // Placeholder com exemplo
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
                // Alterna a visibilidade da senha
                _obscureText = !_obscureText;
              },
            ),
          ),
        ),
      ],
    );
  }
}
