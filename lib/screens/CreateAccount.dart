// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kusuka_moto/screens/HomePage.dart';
import 'package:kusuka_moto/services/providers.dart';
import 'login_screen.dart'; // Importe o arquivo login_screen.dart para a navegação

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  bool _obscureText1 =
      true; // Controla se a senha está oculta no campo "Password"
  bool _obscureText2 =
      true; // Controla se a senha está oculta no campo "Confirme a Password"

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController contatoController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      backgroundColor: Color(0xFF00E0C6), // Cor de fundo verde
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo "KusukaMoto"
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'KusukaMoto',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 20), // Espaço entre logo e formulário

              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título "Crie a sua conta"
                    Text(
                      'Crie a sua conta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF070245),
                      ),
                    ),

                    SizedBox(height: 20), // Espaço entre título e campos

                    // Campos de entrada de texto com ícones
                    _buildTextField('Nome', Icons.person, nomeController),
                    SizedBox(height: 10),
                    _buildTextField('Email', Icons.email, emailController),
                    SizedBox(height: 10),
                    _buildPasswordField('Password', Icons.lock, _obscureText1,
                        passwordController, (value) {
                      setState(() {
                        _obscureText1 = value;
                      });
                    }),
                    SizedBox(height: 10),
                    _buildPasswordField('Confirme a Password', Icons.lock,
                        _obscureText2, passwordController, (value) {
                      setState(() {
                        _obscureText2 = value;
                      });
                    }),
                    SizedBox(height: 10),
                    _buildTextField('Contacto', Icons.phone, contatoController),

                    SizedBox(height: 20),

                    // Botão de Criar
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final user = await authService.registerUser(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            nomeController.text.trim(),
                            contatoController.text.trim(),
                          );

                          if (!mounted)
                            return; // Check if still mounted immediately after await
                          _navegarAposRegistro(user);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF070245), // Cor do botão
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                        ),
                        child: Text(
                          'CRIAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    // Link para entrar
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Já tem uma conta? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navegar para a tela de login
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
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

  void _navegarAposRegistro(dynamic user) {
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao criar conta")),
      );
    }
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool obscureText = false}) {
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
            prefixIcon: Icon(icon,
                color: Color(0xFF070245)), // Ícone associado ao campo
            hintText: 'Digite seu $label', // Placeholder com exemplo
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, IconData icon, bool obscureText,
      TextEditingController controller, Function(bool) onVisibilityChanged) {
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
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0xFF070245),
              ),
              onPressed: () {
                onVisibilityChanged(!obscureText);
              },
            ),
          ),
        ),
      ],
    );
  }
}
