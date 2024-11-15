import 'package:flutter/material.dart';
import 'package:kusuka_moto/screens/AdminServiceForm.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Todos Agendamentos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.grey, thickness: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildAppointmentCard('LAVAGEM EXTERNA', 'Dai Tivane', '11/09/2024', '14:30'),
          const SizedBox(height: 16),
          buildAppointmentCard('LAVAGEM INTERNA', 'Paulo Wen Xuan', '15/10/2024', '14:50'),
          // Adicione mais cards de agendamentos conforme necessário
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Define o índice inicial na tela de agendamentos
        onTap: (index) {
          if (index == 0) {
            // Navega para a tela do formulário de serviços ao clicar no ícone de 'Home'
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminServiceForm()),
            );
          }
          // Se quiser adicionar mais funções na barra de navegação, pode expandir com outros índices
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  // Função para construir cada card de agendamento
  Widget buildAppointmentCard(String service, String name, String date, String time) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.yellow,
              child: Icon(Icons.person, color: Colors.black, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Serviço: $service',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Nome: $name',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    'Data: $date',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    'Hora: $time',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}