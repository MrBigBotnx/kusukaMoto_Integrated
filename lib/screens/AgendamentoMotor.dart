import 'package:flutter/material.dart';

class AgendamentoMotor extends StatefulWidget {
  const AgendamentoMotor({super.key});

  @override
  _AgendamentoMotorState createState() => _AgendamentoMotorState();
}

class _AgendamentoMotorState extends State<AgendamentoMotor> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedCarBrand;

  final List<String> carBrands = [
    'Toyota',
    'Volkswagen',
    'Ford',
    'Chevrolet',
    'Honda',
    'BMW',
    'Mercedes-Benz',
    'Audi',
    'Nissan',
    'Hyundai',
    'Kia',
    'Porsche',
    'Tesla',
    'Subaru',
    'Land Rover',
    'Jeep',
    'Fiat',
    'Renault',
    'Lexus',
    'Buick',
    'Dodge',
    'Mitsubishi',
    'Volvo',
    'Mazda',
    'Peugeot',
    'Chrysler',
    'Lincoln',
    'Cadillac',
    'Acura',
    'Infiniti',
    'Citroën'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento Motor', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preço total: 200MT',
              style: TextStyle(fontSize: 20, color: Colors.teal),
            ),
            SizedBox(height: 16),
            Text(
              'LAVAGEM DO MOTOR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Descrição\n\n'
                'Limpeza completa do motor para remover sujeira, óleo e detritos. Mantém o motor em bom estado e melhora o desempenho.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            buildSelectionButton(
              context,
              icon: Icons.calendar_today,
              label: 'Escolha uma data',
              value: selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'Selecione uma data',
              onTap: () => _selectDate(context),
            ),
            buildSelectionButton(
              context,
              icon: Icons.access_time,
              label: 'Escolha uma hora',
              value: selectedTime != null
                  ? '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                  : 'Selecione uma hora',
              onTap: () => _selectTime(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Selecione a marca do carro',
                style: TextStyle(fontSize: 18, color: Colors.teal),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: carBrands.length,
                itemBuilder: (context, index) {
                  final brand = carBrands[index];
                  final isSelected = selectedCarBrand == brand;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCarBrand = brand;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          brand,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _handleAgendamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Agendar', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required String value,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 0),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _handleAgendamento() {
    if (selectedDate != null &&
        selectedTime != null &&
        selectedCarBrand != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Agendamento Confirmado'),
          content: Text(
            'Data: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}\n'
            'Hora: ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}\n'
            'Marca do Carro: $selectedCarBrand',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content:
              Text('Por favor, preencha todos os campos antes de agendar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
