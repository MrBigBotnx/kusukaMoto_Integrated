import 'package:flutter/material.dart';
import 'signup.dart'; // Importe o arquivo CreateAccount.dart
import 'login.dart'; // Importe o arquivo login_screen.dart

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1), // Cor de fundo da tela
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone do carro e gota
            Image.asset(
              'assets/icons/logo_car_wash.jpg', // Caminho para o ícone
              height: 150,
            ),
            SizedBox(height: 20),
            // Título "KusukaMoto"
            Text(
              'KusukaMoto',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 224, 199, 1),
              ),
            ),
            SizedBox(height: 10),
            // Texto "Bem-Vindo!"
            Text(
              'Bem-Vindo!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            // Botão "Criar uma conta"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(0, 12, 37, 1), // Cor de fundo do botão
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                // Navegar para a tela de criação de conta
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccount()),
                );
              },
              child: Text(
                'Criar uma conta',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(0, 224, 199, 1),
                ),
              ),
            ),
            SizedBox(height: 15),
            // Botão "Entrar"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(0, 224, 199, 1), // Cor de fundo do botão
                padding: EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                // Navegar para a tela de login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(0, 12, 37, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
