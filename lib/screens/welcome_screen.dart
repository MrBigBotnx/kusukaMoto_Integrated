import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  // Adicionando o parâmetro 'key' no construtor do widget
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // Cor de fundo (branco)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone da imagem
            const Image(
              image: AssetImage(
                  'assets/icons/logo_car_wash.jpg'), // Substitua pelo nome da imagem que você usou
              height: 120,
            ),
            const SizedBox(height: 20),

            // Título "KusukaMoto"
            const Text(
              'KusukaMoto',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(
                    1, 13, 37, 1), // Cor do texto (usando rgb(1, 13, 37))
              ),
            ),
            const SizedBox(height: 10),

            // Texto "Bem-Vindo!"
            const Text(
              'Bem-Vindo!',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(
                    1, 141, 159, 1), // Cor do texto (usando rgb(1, 141, 159))
              ),
            ),
            const SizedBox(height: 40),

            // Botão "Iniciar"
            ElevatedButton(
              onPressed: () {
                // Ação para o botão, como navegação para outra tela
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromRGBO(1, 13, 37, 1), // Cor de fundo do botão
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Iniciar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
