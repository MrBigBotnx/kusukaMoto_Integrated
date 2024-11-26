import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kusuka_moto/models/categoria.dart';
import 'package:kusuka_moto/models/servico.dart';
import 'package:kusuka_moto/services/database_service.dart';

class AdminEditServicePage extends StatefulWidget {
  final String serviceId;

  const AdminEditServicePage({Key? key, required this.serviceId})
      : super(key: key);

  @override
  _AdminEditServicePageState createState() => _AdminEditServicePageState();
}

class _AdminEditServicePageState extends State<AdminEditServicePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  CategoriaServico? categoriaSelecionada;
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
        categoriaSelecionada = service.categoria;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Serviço'),
        backgroundColor: const Color(0xFF070245),
      ),
      backgroundColor: const Color(0xFF00E0C6),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconPicker(),
              _buildTextField('Nome do Serviço', Icons.work, nameController),
              const SizedBox(height: 10),
              _buildTextField('Descrição', Icons.description, descriptionController),
              const SizedBox(height: 10),
              _buildTextField(
                'Preço',
                Icons.attach_money,
                priceController,
                isNumeric: true,
              ),
              const SizedBox(height: 10),
              _buildDropdownCategoria(),
              const SizedBox(height: 10),
              _buildAvailabilityCheckbox(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveService,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF070245),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                  ),
                  child: const Text(
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
          const Text(
            'Ícone',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF070245),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF070245)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _selectedIcon == null
                ? const Icon(Icons.image,
                    color: Color(0xFF070245), size: 50)
                : Image.file(_selectedIcon!, fit: BoxFit.cover),
          ),
        ],
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
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF070245),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF070245)),
            hintText: 'Digite o $label',
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF070245)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownCategoria() {
    return DropdownButtonFormField<CategoriaServico>(
      value: categoriaSelecionada,
      decoration: const InputDecoration(
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
          categoriaSelecionada = value;
        });
      },
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
        const Text(
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
          priceController.text.isEmpty ||
          categoriaSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, preencha todos os campos.')),
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
        iconBase64: iconBase64,
        categoria: categoriaSelecionada!,
      );

      await _databaseService.updateService(updatedService);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Serviço atualizado com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o serviço: $e')),
      );
    }
  }
}
