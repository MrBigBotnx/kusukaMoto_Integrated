import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kusuka_moto/services/database_service.dart';
import 'home.dart';
import 'edit_user_profile.dart';
import 'settings.dart';
import 'hello.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  String userName = "Usuário";
  String userEmail = "";
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final user = await DatabaseService().getUser(userId).first;
      setState(() {
        userName = user.nome;
        userEmail = user.email;
        if (user.profileImage != null) {
          profileImage = base64Decode(user.profileImage!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromRGBO(0, 224, 199, 1), // Cor de fundo personalizada
      appBar: AppBar(
        backgroundColor:
            Color.fromRGBO(0, 12, 37, 1), // AppBar com cor personalizada
        elevation: 0,
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          // Imagem do perfil
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.yellow,
            backgroundImage:
                AssetImage('assets/icons/usericon.png'), // Ícone do usuário
          ),
          SizedBox(height: 20),
          // Nome do usuário e e-mail
          Text(
            userName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 12, 37, 1),
            ),
          ),
          Text(
            userEmail,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(0, 12, 37, 1),
            ),
          ),
          SizedBox(height: 30),
          // Opções de perfil com estilo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildProfileOption(
                  context,
                  icon: Icons.edit,
                  text: 'Editar Perfil',
                  onTap: () {
                    // Navega para a tela de edição de perfil
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditUserProfile()),
                    );
                  },
                ),
                SizedBox(height: 10),
                _buildProfileOption(
                  context,
                  icon: Icons.settings,
                  text: 'Configurações',
                  onTap: () {
                    // Navega para a tela de configurações
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Configuracao()),
                    );
                  },
                ),
                SizedBox(height: 10),
                _buildProfileOption(
                  context,
                  icon: Icons.exit_to_app,
                  text: 'Sair',
                  onTap: () {
                    // Caixa de diálogo de confirmação para sair
                    _showLogoutConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(0, 12, 37, 1),
        selectedItemColor: Color.fromRGBO(0, 224, 199, 1),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Já está na página de Perfil, então não faz nada
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Configuracao()),
            );
          }
        },
      ),
    );
  }

  // Função para exibir uma opção de perfil
  Widget _buildProfileOption(BuildContext context,
      {required IconData icon, required String text, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color.fromRGBO(0, 12, 37, 1)),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(0, 12, 37, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Caixa de diálogo de confirmação para sair
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar saída'),
          content: Text('Tem certeza que deseja sair?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sair'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HelloPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
