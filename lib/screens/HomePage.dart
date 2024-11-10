import 'package:flutter/material.dart';
import 'AgendamentoMotor.dart';
import 'AgendamentoDetalhada.dart';
import 'AgendamentoPolimento.dart';
import 'AgendamentoMultiple.dart';
import 'AgendamentoEstofados.dart';
import 'AgendamentoInterna.dart';
import 'AgendamentoExterno.dart';
import 'HistoricoServicos.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedServices = [];

  void toggleServiceSelection(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service);
      } else {
        selectedServices.add(service);
      }
    });
  }

  void showServiceInfo(String service) {
    String description = '';

    switch (service) {
      case 'Lavagem Externa':
        description = '''
        Dê ao seu carro aquele visual impecável! Nossa lavagem externa remove toda a sujeira e poeira, mantendo a pintura protegida e brilhante.
        Vantagens: Aparência renovada e brilho duradouro.
        Benefícios: Aumenta a vida útil da pintura e a resistência contra agentes externos.
        Tempo de espera: Apenas 20 minutos.
      ''';
        break;
      case 'Lavagem Interna':
        description = '''
        Proporcione mais conforto e saúde para seu carro e seus passageiros! A lavagem interna elimina odores e sujeiras, deixando o interior do seu carro como novo.
        Vantagens: Interior limpo, fresco e sem odores.
        Benefícios: Maior conforto e um ambiente mais saudável.
        Tempo de espera: Em média 30 minutos.
      ''';
        break;
      case 'Lavagem Detalhada':
        description = '''
        Vai além da limpeza comum! A lavagem detalhada garante que cada canto do seu carro esteja impecável, com um acabamento profissional.
        Vantagens: Limpeza profunda que restaura o brilho original do seu veículo.
        Benefícios: Aperfeiçoa a estética e preserva a conservação do carro.
        Tempo de espera: Em torno de 45 minutos.
      ''';
        break;
      case 'Polimento e Encerramento':
        description = '''
        Dê um novo brilho ao seu carro! O polimento remove riscos e manchas, deixando a pintura com acabamento de showroom.
        Vantagens: Brilho intenso e proteção superior para a pintura.
        Benefícios: Prolonga a durabilidade da pintura e protege contra danos futuros.
        Tempo de espera: Cerca de 1 hora.
      ''';
        break;
      case 'Limpeza de Estofados e Carpetes':
        description = '''
        Seu carro, mais confortável e saudável! A limpeza de estofados e carpetes remove manchas e odores, proporcionando um ambiente mais agradável.
        Vantagens: Estofados limpos, frescos e renovados.
        Benefícios: Melhor qualidade do ar e conforto para você e sua família.
        Tempo de espera: Aproximadamente 40 minutos.
      ''';
        break;
      case 'Lavagem de Motor':
        description = '''
        Mantenha seu motor funcionando como novo! A lavagem de motor remove sujeiras e graxas, ajudando no desempenho do seu carro.
        Vantagens: Desempenho otimizado e maior eficiência do motor.
        Benefícios: Evita superaquecimento e aumenta a vida útil do motor.
        Tempo de espera: Cerca de 25 minutos.
      ''';
        break;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informações sobre: $service'),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void onAvancarPressed() {
    if (selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione pelo menos um serviço.')),
      );
    } else if (selectedServices.length == 1) {
      // Apenas um serviço selecionado
      String service = selectedServices.first;
      Widget screen;

      switch (service) {
        case 'Lavagem Externa':
          screen = AgendamentoExterno();
          break;
        case 'Lavagem Interna':
          screen = AgendamentoInterna();
          break;
        case 'Lavagem Detalhada':
          screen = AgendamentoDetalhada();
          break;
        case 'Polimento e Encerramento':
          screen = AgendamentoPolimento();
          break;
        case 'Limpeza de Estofados e Carpetes':
          screen = AgendamentoEstofados();
          break;
        case 'Lavagem de Motor':
          screen = AgendamentoMotor();
          break;
        default:
          screen = AgendamentoExterno();
          break;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      // Múltiplos serviços selecionados
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AgendamentoMultiple(selectedServices: selectedServices),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Olá, Usuário',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(0, 224, 198, 1),
        actions: [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: AssetImage('assets/icons/usericon.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Os nossos serviços',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Marque o/os serviço/s pretendido/s',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  ServiceTile(
                    iconPath: 'assets/icons/exterior.png',
                    label: 'Lavagem Externa',
                    isSelected: selectedServices.contains('Lavagem Externa'),
                    onSelect: () => toggleServiceSelection('Lavagem Externa'),
                    onInfo: () => showServiceInfo('Lavagem Externa'),
                  ),
                  ServiceTile(
                    iconPath: 'assets/icons/interna.png',
                    label: 'Lavagem Interna',
                    isSelected: selectedServices.contains('Lavagem Interna'),
                    onSelect: () => toggleServiceSelection('Lavagem Interna'),
                    onInfo: () => showServiceInfo('Lavagem Interna'),
                  ),
                  ServiceTile(
                    iconPath: 'assets/icons/detalhada.png',
                    label: 'Lavagem Detalhada',
                    isSelected: selectedServices.contains('Lavagem Detalhada'),
                    onSelect: () => toggleServiceSelection('Lavagem Detalhada'),
                    onInfo: () => showServiceInfo('Lavagem Detalhada'),
                  ),
                  ServiceTile(
                    iconPath: 'assets/icons/polimento.png',
                    label: 'Polimento e Encerramento',
                    isSelected:
                        selectedServices.contains('Polimento e Encerramento'),
                    onSelect: () =>
                        toggleServiceSelection('Polimento e Encerramento'),
                    onInfo: () => showServiceInfo('Polimento e Encerramento'),
                  ),
                  ServiceTile(
                    iconPath: 'assets/icons/carpete.png',
                    label: 'Limpeza de Estofados e Carpetes',
                    isSelected: selectedServices
                        .contains('Limpeza de Estofados e Carpetes'),
                    onSelect: () => toggleServiceSelection(
                        'Limpeza de Estofados e Carpetes'),
                    onInfo: () =>
                        showServiceInfo('Limpeza de Estofados e Carpetes'),
                  ),
                  ServiceTile(
                    iconPath: 'assets/icons/motor.png',
                    label: 'Lavagem de Motor',
                    isSelected: selectedServices.contains('Lavagem de Motor'),
                    onSelect: () => toggleServiceSelection('Lavagem de Motor'),
                    onInfo: () => showServiceInfo('Lavagem de Motor'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onAvancarPressed,
              child: Text(
                'Avançar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Color.fromRGBO(0, 224, 198, 1),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Histórico'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Carros'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Color.fromRGBO(0, 224, 198, 1),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // Navega para a página HistoricoServicos quando o botão Histórico é clicado
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoricoServicos()),
            );
          }
          // Adicione aqui outras condições se precisar de navegação para outros itens
        },
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onInfo;

  ServiceTile({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onSelect,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(0, 224, 198, 0.3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color.fromRGBO(0, 224, 198, 1) : Colors.grey,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconPath, height: 40, width: 40),
                SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(7, 2, 69, 1)),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onInfo,
                child: Image.asset('assets/icons/infoi.png', height: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
