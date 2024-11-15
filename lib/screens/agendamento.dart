import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendamentoMultiple extends StatefulWidget {
  final List<String> selectedServices;
  final List<String> selectedServiceIds;
  final Map<String, double> servicePrices;
  final Map<String, String> serviceNames;

  AgendamentoMultiple({
    Key? key,
    required this.selectedServices,
    required this.selectedServiceIds,
    required this.servicePrices,
    required this.serviceNames,
  }) : super(key: key);

  @override
  _AgendamentoMultipleState createState() => _AgendamentoMultipleState();
}

class _AgendamentoMultipleState extends State<AgendamentoMultiple> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedCarBrand;

  // Lista de marcas de carros
  final List<String> carBrands = [
    'Toyota',
    'Honda',
    'Ford',
    'BMW',
    'Mercedes-Benz',
    'Volkswagen',
    'Chevrolet',
    'Nissan',
    'Hyundai',
  ];

  // Função para selecionar a hora
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  // Função para remover um serviço
  void _removeService(String serviceId) {
    setState(() {
      widget.selectedServiceIds.remove(serviceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcula o valor total dos serviços selecionados
    double totalValue = widget.selectedServiceIds.fold(0.0, (sum, id) {
      return sum + (widget.servicePrices[id] ?? 0.0);
    });

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Agendamento', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromRGBO(0, 224, 198, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/icons/kusuka.png',
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Serviços Selecionados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(5, 4, 72, 1),
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: widget.selectedServiceIds.map((id) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Color.fromRGBO(7, 2, 69, 1), width: 2),
                    color: Color.fromRGBO(0, 224, 198, 1),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      widget.serviceNames[id] ?? 'Serviço',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(5, 4, 72, 1),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${widget.servicePrices[id]?.toStringAsFixed(2)} MZN',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(7, 2, 69, 1),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          color: Colors.red,
                          onPressed: () => _removeService(id),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              'Valor Total: MZN ${totalValue.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(5, 4, 72, 1),
              ),
            ),
            SizedBox(height: 16),
            // Seção de seleção de marca do carro
            Text(
              'Escolha a Marca do Carro',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(5, 4, 72, 1),
              ),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedCarBrand,
              hint: Text(
                'Selecione a marca do carro',
                style:
                    TextStyle(fontSize: 14, color: Color.fromRGBO(5, 4, 72, 1)),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCarBrand = newValue;
                });
              },
              items: carBrands.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(5, 4, 72, 1)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Seção de seleção de data
            Text(
              'Escolha a Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(5, 4, 72, 1),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color.fromRGBO(0, 224, 198, 1)),
                ),
                child: Text(
                  selectedDate == null
                      ? 'Selecione uma data'
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(5, 4, 72, 1)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate != null &&
                      selectedTime != null &&
                      selectedCarBrand != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Agendamento Confirmado!'),
                        backgroundColor: Color.fromRGBO(0, 224, 198, 1),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Por favor, selecione a data, hora e marca do carro!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 224, 198, 1),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Confirmar Agendamento',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
