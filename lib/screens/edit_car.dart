import 'package:flutter/material.dart';

class EditCar extends StatelessWidget {
  const EditCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 12, 37, 1), // Cor de fundo
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 12, 37, 1), // Cor da AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 224, 199, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Edite seus carros"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300, // Placeholder para a imagem do carro
                      radius: 24,
                    ),
                    title: Text("Mc Laren"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pessoal"),
                        Text("Modelo: 2017", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 24,
                    ),
                    title: Text("Mc Laren"),
                    subtitle: Text("Pessoal"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _abrirPainelCadastro(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(0, 224, 199, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: Text("Adicionar novo carro"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirPainelCadastro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Cadastrar Novo Carro",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Implementar função para selecionar imagem do carro
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome do carro",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Tipo",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Modelo",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implementar a função para salvar o carro
                  Navigator.of(context).pop(); // Fechar o painel após salvar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 224, 199, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: Text("Salvar"),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
