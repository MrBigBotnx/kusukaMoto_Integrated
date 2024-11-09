import 'package:flutter/material.dart';

class HelloPage extends StatelessWidget {
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
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Ação ao clicar no botão "Criar uma conta"
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
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Ação ao clicar no botão "Entrar"
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
