import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kusuka_moto/screens/agendamento.dart'; // Importe a tela AgendamentoMultiple
import 'package:kusuka_moto/services/database_service.dart';
import 'package:kusuka_moto/models/servico.dart';
import '../widgets/custom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Servico> selectedServices = [];
  List<Servico> availableServices = [];
  String userName = "Usuário";
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadServices();
  }

  void _loadUserName() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final user = await DatabaseService().getUser(userId).first;
      setState(() {
        userName = user.nome;
        if (user.profileImage != null) {
          profileImage = base64Decode(user.profileImage!);
        }
      });
    }
  }

  void _loadServices() {
    DatabaseService().getAvailableServices().listen((services) {
      setState(() {
        availableServices = services;
      });
    });
  }

  void toggleServiceSelection(Servico service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service);
      } else {
        selectedServices.add(service);
      }
    });
  }

  void navigateToAgendamento() {
    if (selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione pelo menos um serviço.')),
      );
      return;
    }

    List<String> selectedServiceIds =
        selectedServices.map((s) => s.id).toList();
    List<String> selectedServiceNames =
        selectedServices.map((s) => s.nome).toList();
    Map<String, double> servicePrices = {
      for (var s in selectedServices) s.id: s.preco
    };
    Map<String, String> serviceNames = {
      for (var s in selectedServices) s.id: s.nome
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Agendamento(
          selectedServices: selectedServiceNames,
          selectedServiceIds: selectedServiceIds,
          servicePrices: servicePrices,
          serviceNames: serviceNames,
        ),
      ),
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
            style: TextStyle(
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
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  service.descricao,
                  style: TextStyle(
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
              child: Text(
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 244, 198, 1),
        elevation: 0,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Olá, $userName',
            style: TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset('assets/icons/notification.png'),
                onPressed: () {
                  // Funcao para notificacao
                },
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 20,
                backgroundImage: profileImage != null
                    ? MemoryImage(profileImage!)
                    : AssetImage('assets.icons/usericon.png')
                        as ImageProvider,
              )
            ],
          )
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Os nossos serviços',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Expanded(
                child: availableServices.isNotEmpty
                    ? GridView.builder(
                        itemCount: availableServices.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            isSelected: selectedServices.contains(service),
                            onSelect: () => toggleServiceSelection(service),
                            onInfo: () => showServiceInfo(service),
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
              ElevatedButton(
                onPressed: navigateToAgendamento,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Color.fromRGBO(0, 224, 198, 1),
                ),
                child: Text(
                  'Avançar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final Uint8List? iconData;
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onInfo;

  const ServiceTile({
    super.key,
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.onSelect,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.15;

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(183, 227, 254, 1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color.fromRGBO(183, 227, 254, 1) : Colors.grey,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconData != null
                    ? Image.memory(iconData!, height: iconSize, width: iconSize)
                    : Icon(Icons.image, size: iconSize, color: Colors.grey),
                SizedBox(height: 5),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(7, 2, 69, 1),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 1,
              right: 1,
              child: IconButton(
                icon: Icon(Icons.info, color: Colors.blue),
                onPressed: onInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
