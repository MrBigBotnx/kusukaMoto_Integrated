import 'package:flutter/material.dart';

class PerfilEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Editar perfil',
          style: TextStyle(
            color: Color(0xFF070245),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF070245)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      Container(
  margin: EdgeInsets.symmetric(vertical: 20),
  child: CircleAvatar(
    radius: 45,
    backgroundColor: Color(0xFFB7E3FE),
    foregroundImage: AssetImage('assets/icons/profile.png'), // Substitui `backgroundImage`
  ),
),

            SizedBox(height: 20),

            // Name Text Field
            _buildTextField('Nome', Icons.person),
            SizedBox(height: 10),

            // Email Text Field
            _buildTextField('Email', Icons.email),
            SizedBox(height: 10),

            // Phone Number Text Field
            _buildTextField('Número de telefone', Icons.phone),
            SizedBox(height: 20),

            // Options Section
            _buildOptionItem(
              iconPath: 'assets/icons/cars.png',
              title: 'Meus carros',
              onTap: () {
                // Navegar para a tela "Meus carros"
              },
            ),
            _buildOptionItem(
              iconPath: 'assets/icons/password.png',
              title: 'Atualizar password',
              onTap: () {
                _showPasswordUpdateModal(context);
              },
            ),
            Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00E0C7),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  // Ação ao pressionar o botão "Salvar"
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF070245),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Função para exibir a mini-tela de atualização de senha
  void _showPasswordUpdateModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Atualizar senha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF070245),
              ),
            ),
            SizedBox(height: 20),
            PasswordField(label: 'Senha atual', icon: Icons.lock),
            SizedBox(height: 10),
            PasswordField(label: 'Nova senha', icon: Icons.lock),
            SizedBox(height: 10),
            PasswordField(label: 'Confirme nova senha', icon: Icons.lock),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00E0C7),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                // Ação de atualização de senha
                Navigator.pop(context); // Fechar o modal após salvar
              },
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF070245),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir campos de texto com ícones
  Widget _buildTextField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF201C58)),
        labelStyle: TextStyle(color: Color(0xFF070245)),
        filled: true,
        fillColor: Color(0xFFB7E3FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Função para construir itens de opção com ícones personalizados
  Widget _buildOptionItem({required String iconPath, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Image.asset(iconPath, width: 30, height: 30),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF070245),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF00E0C7)),
      onTap: onTap,
    );
  }
}

// Classe para campo de senha com opção de visibilidade
class PasswordField extends StatefulWidget {
  final String label;
  final IconData icon;

  PasswordField({required this.label, required this.icon});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon, color: Color(0xFF201C58)),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        labelStyle: TextStyle(color: Color(0xFF070245)),
        filled: true,
        fillColor: Color(0xFFB7E3FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
