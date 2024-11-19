import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kusuka_moto/models/servico.dart';
import 'package:kusuka_moto/services/database_service.dart';

class AdminEditServicePage extends StatefulWidget {
  final String serviceId;

  const AdminEditServicePage({Key? key, required this.serviceId, required Servico servico})
      : super(key: key);

  @override
  _AdminEditServicePageState createState() => _AdminEditServicePageState();
}

class _AdminEditServicePageState extends State<AdminEditServicePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool availability = true;
  File? _selectedIcon;
  final DatabaseService _databaseService = DatabaseService();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  Future<void> _loadServiceData() async {
    final service = await _databaseService.getServiceById(widget.serviceId);
    if (service != null) {
      setState(() {
        nameController.text = service.nome;
        descriptionController.text = service.descricao;
        priceController.text = service.preco.toString();
        availability = service.disponibilidade;
        _selectedIcon = service.iconBase64 as File?;
      });
    }
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

  void _saveService() async {
    try {
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          priceController.text.isEmpty || _selectedIcon == null) {
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

      final updatedService = Servico(
        id: widget.serviceId,
        nome: nameController.text,
        descricao: descriptionController.text,
        preco: double.parse(priceController.text),
        disponibilidade: availability,
        iconBase64:  iconBase64,
      );

      await _databaseService.updateService(updatedService);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Serviço atualizado com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o serviço: $e')),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Serviço'),
        backgroundColor: Color(0xFF070245),
      ),
      backgroundColor: Color(0xFF00E0C6),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Nome do Serviço', Icons.work, nameController),
              SizedBox(height: 10),
              _buildMarkdownEditor(),
              SizedBox(height: 10),
              _buildTextField(
                'Preço',
                Icons.attach_money,
                priceController,
                isNumeric: true,
              ),
              SizedBox(height: 10),
              _buildAvailabilityCheckbox(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveService,
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
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isNumeric = false}) {
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
            hintText: 'Digite o $label',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarkdownEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição (Markdown)',
          style: TextStyle(fontSize: 16, color: Color(0xFF070245)),
        ),
        SizedBox(height: 5),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF070245)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: descriptionController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Digite a descrição (suporta Markdown)',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        MarkdownBody(
          data: descriptionController.text,
          styleSheet: MarkdownStyleSheet(
            p: TextStyle(fontSize: 14),
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
}
