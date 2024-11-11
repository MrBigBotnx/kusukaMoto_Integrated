// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importe o arquivo login_screen.dart para a navegação

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscureText1 =
      true; // Controla se a senha está oculta no campo "Password"
  bool _obscureText2 =
      true; // Controla se a senha está oculta no campo "Confirme a Password"

  @override
  Widget build(BuildContext context) {
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
                    _buildTextField('Nome', Icons.person),
                    SizedBox(height: 10),
                    _buildTextField('Email', Icons.email),
                    SizedBox(height: 10),
                    _buildPasswordField('Password', Icons.lock, _obscureText1,
                        (value) {
                      setState(() {
                        _obscureText1 = value;
                      });
                    }),
                    SizedBox(height: 10),
                    _buildPasswordField(
                        'Confirme a Password', Icons.lock, _obscureText2,
                        (value) {
                      setState(() {
                        _obscureText2 = value;
                      });
                    }),
                    SizedBox(height: 10),
                    _buildTextField('Contacto', Icons.phone),

                    SizedBox(height: 20),

                    // Botão de Criar
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Adicione a lógica de criação de conta aqui
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

  Widget _buildTextField(String label, IconData icon,
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
      Function(bool) onVisibilityChanged) {
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
