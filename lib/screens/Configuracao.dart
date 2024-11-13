import 'package:flutter/material.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({super.key});

  @override
  _ConfiguracaoState createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  String _currentLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 224, 199, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 12, 37, 1),
        title: Text(
          _getText('Configurações'),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getText('Preferências'),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 12, 37, 1),
              ),
            ),
            SizedBox(height: 20),
            _buildConfigOption(
              context,
              _getText('Notificações'),
              Icons.notifications,
              () {
                // Ação para notificações
              },
            ),
            _buildConfigOption(
              context,
              _getText('Privacidade'),
              Icons.lock,
              () {
                // Ação para privacidade
              },
            ),
            _buildLanguageOption(),
            _buildConfigOption(
              context,
              _getText('Ajuda e Suporte'),
              Icons.help_outline,
              () {
                _showHelpSupportDialog();
              },
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 12, 37, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  _resetSettings();
                },
                child: Text(
                  _getText('Redefinir Configurações'),
                  style: TextStyle(color: Color.fromRGBO(0, 224, 199, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para exibir o widget de seleção de idioma
  Widget _buildLanguageOption() {
    return InkWell(
      onTap: () {
        _showLanguageDialog();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 10),
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
            Icon(Icons.language, color: Color.fromRGBO(0, 12, 37, 1)),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                '${_getText('Idioma')}: $_currentLanguage',
                style: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 12, 37, 1)),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Exibe o diálogo para selecionar o idioma
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_getText('Selecionar Idioma')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageTile('Português'),
              _buildLanguageTile('Inglês'),
            ],
          ),
        );
      },
    );
  }

  // Opções de seleção de idioma
  Widget _buildLanguageTile(String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        setState(() {
          _currentLanguage = language;
        });
        Navigator.of(context).pop();
      },
    );
  }

  // Método para exibir os textos de acordo com o idioma
  String _getText(String text) {
    Map<String, Map<String, String>> translations = {
      'Configurações': {'en': 'Settings', 'pt': 'Configurações'},
      'Preferências': {'en': 'Preferences', 'pt': 'Preferências'},
      'Notificações': {'en': 'Notifications', 'pt': 'Notificações'},
      'Privacidade': {'en': 'Privacy', 'pt': 'Privacidade'},
      'Idioma': {'en': 'Language', 'pt': 'Idioma'},
      'Ajuda e Suporte': {'en': 'Help & Support', 'pt': 'Ajuda e Suporte'},
      'Redefinir Configurações': {'en': 'Reset Settings', 'pt': 'Redefinir Configurações'},
      'Selecionar Idioma': {'en': 'Select Language', 'pt': 'Selecionar Idioma'},
    };
    return translations[text]?[_currentLanguage == 'Inglês' ? 'en' : 'pt'] ?? text;
  }

  // Widget para criar cada item de configuração
  Widget _buildConfigOption(BuildContext context, String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 10),
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
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 12, 37, 1)),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Função para resetar as configurações
  void _resetSettings() {
    setState(() {
      _currentLanguage = 'Português';
    });
    // Adicione aqui a lógica para redefinir outras configurações do app
  }

  // Função para exibir o diálogo de ajuda e suporte
  void _showHelpSupportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_getText('Ajuda e Suporte')),
          content: Text(
            _getText('Se você tiver alguma dúvida, entre em contato conosco via e-mail:\n\n'
                'tivanepaulo2@gmail.com\nmubidalo@gmail.com\n\n'
                'KusukaMoto é uma empresa especializada em serviços de lavagem de veículos.'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(_getText('Fechar')),
            ),
          ],
        );
      },
    );
  }
}
