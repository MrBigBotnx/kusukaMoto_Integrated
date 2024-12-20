import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kusuka_moto/models/categoria.dart';
import 'dart:io';
import 'package:kusuka_moto/models/servico.dart';
import 'package:kusuka_moto/services/database_service.dart';
import 'package:uuid/uuid.dart';

class AdminAddService extends StatefulWidget {
  const AdminAddService({super.key});

  @override
  _AdminAddService createState() => _AdminAddService();
}

class _AdminAddService extends State<AdminAddService> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool availability = true;
  File? _selectedIcon;
  CategoriaServico categoriaSelecionada = CategoriaServico.lavagem;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00E0C6),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'Administração de Serviços',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                    // Campo para selecionar o ícone
                    _buildIconPicker(),
                    SizedBox(height: 10),
                    // Campo para o nome do serviço
                    _buildTextField('Nome do Serviço', Icons.work, nameController),
                    SizedBox(height: 10),
                    // Campo para descrição do serviço
                    _buildTextField('Descrição', Icons.description, descriptionController),
                    SizedBox(height: 10),
                    // Campo para o preço do serviço
                    _buildTextField('Preço', Icons.attach_money, priceController, isNumeric: true),
                    SizedBox(height: 10),
                    // Checkbox para disponibilidade
                    _buildAvailabilityCheckbox(),
                    SizedBox(height: 20),
                    // Dropdown para categoria
              DropdownButtonFormField<CategoriaServico>(
                value: categoriaSelecionada,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                items: CategoriaServico.values.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria.descricao),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    categoriaSelecionada = value!;
                  });
                },
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: _saveService,
                child: Text('SALVAR'),
              ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Salvar o serviço no backend ou base de dados
                          _saveService();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF070245),
                          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        ),
                        child: Text(
                          'SALVAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  Widget _buildIconPicker() {
    return GestureDetector(
      onTap: () async {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _selectedIcon = File(pickedFile.path);
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ícone',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF070245),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF070245)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _selectedIcon == null
                ? Icon(Icons.image, color: Color(0xFF070245), size: 50)
                : Image.file(_selectedIcon!, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isNumeric = false}) {
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
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Color(0xFF070245)),
            hintText: 'Digite $label',
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

  Widget _buildAvailabilityCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: availability,
          onChanged: (value) {
            setState(() {
              availability = value!;
            });
          },
        ),
        Text(
          'Disponível',
          style: TextStyle(fontSize: 16, color: Color(0xFF070245)),
        ),
      ],
    );
  }

void _saveService() async {
    try {
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          priceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, preencha todos os campos.')),
        );
        return;
      }

      String? iconBase64;
      if (_selectedIcon != null) {
        final bytes = await _selectedIcon!.readAsBytes();
        iconBase64 = base64Encode(bytes);
      }

      final servico = Servico(
        id: Uuid().v4(),
        nome: nameController.text,
        descricao: descriptionController.text,
        preco: double.parse(priceController.text),
        disponibilidade: availability,
        iconBase64: iconBase64,
        categoria: categoriaSelecionada,
      );

      await DatabaseService().addService(servico);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Serviço salvo com sucesso!')),
      );

      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      setState(() {
        _selectedIcon = null;
        availability = true;
        categoriaSelecionada = CategoriaServico.lavagem;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o serviço: $e')),
      );
    }
  }

}
