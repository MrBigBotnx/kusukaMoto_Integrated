import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kusuka_moto/models/categoria.dart';
import 'package:kusuka_moto/screens/agendamento.dart'; // Importe a tela AgendamentoMultiple
import 'package:kusuka_moto/screens/edit_car.dart';
import 'package:kusuka_moto/screens/history.dart';
import 'package:kusuka_moto/screens/user_profile.dart';
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
  List<Servico> allServices = [];
  List<Servico> displayedServices = [];
  CategoriaServico? selectedCategory;

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
        allServices = services;
        displayedServices = services; // Inicialmente exibe todos os serviços
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

  void _filterServicesByCategory(CategoriaServico? category) {
    setState(() {
      if (category == selectedCategory) {
        // Exibir todos os serviços se a categoria for desmarcada
        selectedCategory = null;
        displayedServices = allServices;
      } else {
        // Exibir apenas os serviços da categoria selecionada
        selectedCategory = category;
        displayedServices =
            allServices.where((s) => s.categoria == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Olá, $userName',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .pop(); // Navegar de volta para a tela anterior
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 83, 64),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/icons/arrowback.png',
              height: 20,
              width: 20,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 21, 83, 64),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              'assets/icons/notification.png',
              height: 35,
              width: 35,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/usericon.png',
              height: 37,
              width: 37,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _seachField(),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Categorias',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      _categorySection(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Os nossos serviços',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Expanded(
                child: displayedServices.isNotEmpty
                    ? GridView.builder(
                        itemCount: displayedServices.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final service = displayedServices[index];
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
              SizedBox(
                height: 10,
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
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            switch (index) {
              case 1: // Histórico
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoricoAgendamento()),
                ).then(
                  (_) {
                    setState(() => _currentIndex =
                        0); // Retorna o índice para Home ao voltar
                  },
                );
                break;
              case 2: // Carros
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditCar()),
                ).then(
                  (_) {
                    setState(() => _currentIndex =
                        0); // Retorna o índice para Home ao voltar
                  },
                );
                break;
              case 3: // Perfil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                ).then(
                  (_) {
                    setState(() => _currentIndex =
                        0); // Retorna o índice para Home ao voltar
                  },
                );
                break;
            }
          }
        },
      ),
    );
  }

  SizedBox _categorySection() {
    double iconSize = MediaQuery.of(context).size.width * 0.15;
    
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: CategoriaServico.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = CategoriaServico.values[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => _filterServicesByCategory(category),
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue[200]
                    : Colors.blue[100]?.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(color: Colors.blue, width: 2)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    category.iconPath,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category.descricao,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _seachField() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0),
          ]),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Pesquisa',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/icons/search.svg'),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(
                        color: Colors.black,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 1.0,
                          top: 8.0,
                          right: 15.0,
                          bottom: 8.0,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/filter.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
            ),
          ),
        )
      ],
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
