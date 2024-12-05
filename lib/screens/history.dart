import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kusuka_moto/screens/edit_car.dart';
import 'package:kusuka_moto/screens/home.dart';
import 'package:kusuka_moto/screens/user_profile.dart';
import 'package:kusuka_moto/widgets/custom_navigation_bar.dart'; // For date formatting

class HistoricoAgendamento extends StatefulWidget {
  const HistoricoAgendamento({super.key});

  @override
  _HistoricoAgendamentoState createState() => _HistoricoAgendamentoState();
}

class _HistoricoAgendamentoState extends State<HistoricoAgendamento> {
  String _filtroStatus = 'Todos';
  final TextEditingController _buscaController = TextEditingController();
  // String _ordenarPor = 'data';
  // bool _isAscending = true;
  int _currentIndex = 1;
  // Simulated data - replace with your actual data fetching method
  final List<Map<String, String>> _servicos = [
    {
      'data': '2024-01-15',
      'operacao': 'Lavagem Completa',
      'descricao': 'Lavagem externa e interna',
      'valor': '1500',
      'status': 'Concluído',
      'estado': 'Finalizado'
    },
    {
      'data': '02/11/2024',
      'operacao': 'Polimento',
      'descricao': 'Interno',
      'valor': '300',
      'status': 'Pendente',
      'estado': 'Não Pago'
    },
    {
      'data': '03/11/2024',
      'operacao': 'Enceramento',
      'descricao': 'Externo',
      'valor': '200',
      'status': 'Concluído',
      'estado': 'Pago'
    },
    {
      'data': '04/11/2024',
      'operacao': 'Lavagem',
      'descricao': 'Interna',
      'valor': '150',
      'status': 'Cancelado',
      'estado': 'Não Pago'
    },
    {
      'data': '05/11/2024',
      'operacao': 'Polimento',
      'descricao': 'Completo',
      'valor': '350',
      'status': 'Concluído',
      'estado': 'Pago'
    },
    {
      'data': '06/11/2024',
      'operacao': 'Lavagem',
      'descricao': 'Motor',
      'valor': '400',
      'status': 'Pendente',
      'estado': 'Não Pago'
    },
    {
      'data': '07/11/2024',
      'operacao': 'Polimento',
      'descricao': 'Externo',
      'valor': '250',
      'status': 'Concluído',
      'estado': 'Pago'
    },
    {
      'data': '08/11/2024',
      'operacao': 'Enceramento',
      'descricao': 'Completo',
      'valor': '300',
      'status': 'Cancelado',
      'estado': 'Não Pago'
    },
    {
      'data': '09/11/2024',
      'operacao': 'Lavagem',
      'descricao': 'Completa',
      'valor': '500',
      'status': 'Concluído',
      'estado': 'Pago'
    },
    {
      'data': '10/11/2024',
      'operacao': 'Enceramento',
      'descricao': 'Interno',
      'valor': '250',
      'status': 'Pendente',
      'estado': 'Não Pago'
    },
  ];

  // Method to calculate total
  double _calcularTotal() {
    return _servicos.fold(
        0, (total, servico) => total + double.parse(servico['valor'] ?? '0'));
  }

  // Method to filter and sort data
  List<Map<String, String>> _filtrarEDadosOrdenados() {
    return _servicos.where((servico) {
      final buscaTexto = _buscaController.text.toLowerCase();
      final statusMatch =
          _filtroStatus == 'Todos' || servico['status'] == _filtroStatus;
      final textMatch = buscaTexto.isEmpty ||
          servico['operacao']!.toLowerCase().contains(buscaTexto) ||
          servico['descricao']!.toLowerCase().contains(buscaTexto);

      return statusMatch && textMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white,
              title: Text(
                'Histórico de serviços',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),

            // Search and Filter Section
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  children: [
                    // Search Field
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color(0xff1D1617).withOpacity(0.11),
                            blurRadius: 40,
                            spreadRadius: 0.0),
                      ]),
                      child: TextField(
                        controller: _buscaController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Buscar serviços',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset('assets/icons/search.svg'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        ),
                        onChanged: (valor) {
                          setState(() {});
                        },
                      ),
                    ),

                    SizedBox(height: 15),

                    // Status Filter Dropdown
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton<String>(
                        value: _filtroStatus,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: ['Todos', 'Concluído', 'Pendente', 'Cancelado']
                            .map((String status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? novoStatus) {
                          setState(() {
                            _filtroStatus = novoStatus!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Services List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: _filtrarEDadosOrdenados().isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Nenhum serviço encontrado',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final servico = _filtrarEDadosOrdenados()[index];
                          return _buildServiceCard(servico);
                        },
                        childCount: _filtrarEDadosOrdenados().length,
                      ),
                    ),
            ),

            // Total and PDF Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Total Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 224, 198, 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_calcularTotal()} MZN',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(0, 224, 198, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // PDF Button
                    ElevatedButton(
                      onPressed: () {
                        // PDF generation logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 224, 198, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Imprimir PDF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            switch (index) {
              case 0: // Home
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
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

  // Service Card Widget
  Widget _buildServiceCard(Map<String, String> servico) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servico['operacao']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(7, 2, 69, 1),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    servico['descricao']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        servico['data']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${servico['valor']} MZN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 224, 198, 1),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(servico['status']!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    servico['status']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Concluído':
        return Colors.green;
      case 'Pendente':
        return Colors.orange;
      case 'Cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Back Button

  // App Bar Actions
}

  // void gerarRelatorioPDF() async {
  //   final pdf = pw.Document();
  //   final logoData = await rootBundle.load('assets/icons/logo_car_wash.jpg');
  //   final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Image(logoImage, width: 100, height: 100),
  //                 pw.Text(
  //                   'Relatório de Serviços',
  //                   style: pw.TextStyle(
  //                     fontSize: 26,
  //                     fontWeight: pw.FontWeight.bold,
  //                     color: PdfColors.blue900,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             pw.SizedBox(height: 20),
  //             pw.Text(
  //               'Nome da Empresa: KusukaMoto',
  //               style: pw.TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: pw.FontWeight.bold,
  //                 color: PdfColors.blueGrey800,
  //               ),
  //             ),
  //             pw.SizedBox(height: 10),
  //             pw.Text(
  //               'Histórico de Serviços',
  //               style: pw.TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: pw.FontWeight.normal,
  //                 color: PdfColors.blueGrey700,
  //               ),
  //             ),
  //             pw.SizedBox(height: 20),
  //             pw.Table.fromTextArray(
  //               context: context,
  //               headerStyle: pw.TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: pw.FontWeight.bold,
  //                 color: PdfColors.white,
  //               ),
  //               cellStyle: pw.TextStyle(fontSize: 12),
  //               headerDecoration:
  //                   pw.BoxDecoration(color: PdfColors.blueGrey600),
  //               cellPadding: pw.EdgeInsets.all(8),
  //               data: [
  //                 [
  //                   'Data',
  //                   'Operação',
  //                   'Descrição',
  //                   'Valor',
  //                   'Status',
  //                   'Estado'
  //                 ],
  //                 ..._filtrarEDadosOrdenados().map((servico) => [
  //                       servico['data'],
  //                       servico['operacao'],
  //                       servico['descricao'],
  //                       '${servico['valor']} MZN',
  //                       servico['status'],
  //                       servico['estado'],
  //                     ]),
  //               ],
  //             ),
  //             pw.SizedBox(height: 20),
  //             pw.Align(
  //               alignment: pw.Alignment.centerRight,
  //               child: pw.Text(
  //                 'Total: ${_calcularTotal()} MZN',
  //                 style: pw.TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: pw.FontWeight.bold,
  //                   color: PdfColors.green800,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   // Salvando o arquivo PDF
  //   final output = await getTemporaryDirectory();
  //   final file = File("${output.path}/Relatorio_KusukaMoto.pdf");
  //   await file.writeAsBytes(await pdf.save());
  // }
