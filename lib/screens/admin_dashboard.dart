import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kusuka_moto/models/servico.dart';
import 'package:kusuka_moto/screens/admin_add_service.dart';
import 'package:kusuka_moto/screens/home.dart';
import 'package:kusuka_moto/screens/service_details.dart';
import 'package:kusuka_moto/services/database_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Servico> availableServices = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void _loadServices() {
    // Carrega os serviços do banco de dados
    DatabaseService().getAvailableServices().listen((services) {
      setState(() {
        availableServices = services;
      });
    });
  }

  void navigateToServiceForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminAddService()),
    );
  }

  void showServiceInfo(Servico service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            service.nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preço: ${service.preco.toStringAsFixed(2)} MT',
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  service.descricao,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Administração de Serviços',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.grey, thickness: 1.0),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Serviços Disponíveis',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: availableServices.isNotEmpty
                    ? GridView.builder(
                        itemCount: availableServices.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final service = availableServices[index];
                          Uint8List? imageData = service.iconBase64 != null
                              ? base64Decode(service.iconBase64!)
                              : null;

                          return ServiceTile(
                            iconData: imageData,
                            label: service.nome,
                            isSelected:
                                false, // Sem funcionalidade de seleção aqui
                            onSelect: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceDetailsPage(serviceId: service.id),
                                ),
                              );
                            },
                            onInfo: () => showServiceInfo(service),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              ElevatedButton(
                onPressed: navigateToServiceForm,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: const Color.fromRGBO(0, 224, 198, 1),
                ),
                child: const Text(
                  'Adicionar serviço',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Define como o índice inicial
        onTap: (index) {
          if (index == 1) {
            // Navegar para outra funcionalidade, se necessário
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agendamentos',
          ),
        ],
      ),
    );
  }
}
