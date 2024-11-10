import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/HelloPage.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KusukaMoto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // A tela inicial será a HelloPage
      routes: {
        '/': (context) => HelloPage(), // HelloPage será a primeira tela
        '/login': (context) =>
            LoginScreen(), // LoginScreen será a tela de login
        // Outras rotas podem ser adicionadas aqui conforme necessário
      },
    );
  }
}
