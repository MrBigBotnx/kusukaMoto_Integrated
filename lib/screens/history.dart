import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart' show rootBundle;

class HistoricoAgendamento extends StatefulWidget {
  const HistoricoAgendamento({super.key});

  @override
  _HistoricoAgendamentoState createState() => _HistoricoAgendamentoState();
}

class _HistoricoAgendamentoState extends State<HistoricoAgendamento> {
  String _filtroStatus = 'Todos';
  final TextEditingController _buscaController = TextEditingController();
  bool _isAscending = true;
  String _ordenarPor = 'data';

  final List<Map<String, String>> _dadosServicos = [
    {
      'data': '01/11/2024',
      'operacao': 'Lavagem',
      'descricao': 'Completa',
      'valor': '500',
      'status': 'Concluído',
      'estado': 'Pago'
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

  @override
  Widget build(BuildContext context) {
    double total = _calcularTotal();

    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico de Serviços"),
        backgroundColor: Colors.blue.shade900,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/icons/logo_car_wash.jpg', // Certifique-se de adicionar este arquivo no diretório
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filtro por status
            DropdownButton<String>(
              value: _filtroStatus,
              items: ['Todos', 'Concluído', 'Pendente', 'Cancelado']
                  .map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? novoStatus) {
                setState(() {
                  _filtroStatus = novoStatus!;
                });
              },
            ),
            // Barra de busca
            TextField(
              controller: _buscaController,
              decoration: InputDecoration(
                labelText: "Buscar por operação ou descrição",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            // Tabela de dados com rolagem
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      sortColumnIndex: _getColumnIndex(_ordenarPor),
                      sortAscending: _isAscending,
                      columnSpacing: 20,
                      columns: [
                        _criarCabecalhoColuna('Data', 'data'),
                        _criarCabecalhoColuna('Operação', 'operacao'),
                        _criarCabecalhoColuna('Descrição', 'descricao'),
                        _criarCabecalhoColuna('Valor', 'valor'),
                        _criarCabecalhoColuna('Status', 'status'),
                        _criarCabecalhoColuna('Estado', 'estado'),
                      ],
                      rows: _filtrarEDadosOrdenados().map((servico) {
                        return DataRow(cells: [
                          DataCell(Text(servico['data']!)),
                          DataCell(Text(servico['operacao']!)),
                          DataCell(Text(servico['descricao']!)),
                          DataCell(Text('${servico['valor']} MZN')),
                          DataCell(Text(servico['status']!)),
                          DataCell(Text(servico['estado']!)),
                        ]);
                      }).toList(),
                      border: TableBorder.all(
                        color: Color.fromRGBO(7, 2, 69, 1),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '$total MZN',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Botão de impressão PDF
            ElevatedButton(
              onPressed: () {
                gerarRelatorioPDF();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 7, 225, 198),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text("Imprimir PDF"),
            ),
          ],
        ),
      ),
    );
  }

  // Função para gerar o cabeçalho de cada coluna com ordenação
  DataColumn _criarCabecalhoColuna(String titulo, String campo) {
    return DataColumn(
      label: InkWell(
        onTap: () {
          setState(() {
            if (_ordenarPor == campo) {
              _isAscending = !_isAscending;
            } else {
              _ordenarPor = campo;
              _isAscending = true;
            }
          });
        },
        child: Row(
          children: [
            Text(titulo),
            Icon(
              _ordenarPor == campo
                  ? (_isAscending ? Icons.arrow_upward : Icons.arrow_downward)
                  : Icons.unfold_more,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  int _getColumnIndex(String column) {
    switch (column) {
      case 'data':
        return 0;
      case 'operacao':
        return 1;
      case 'descricao':
        return 2;
      case 'valor':
        return 3;
      case 'status':
        return 4;
      case 'estado':
        return 5;
      default:
        return 0;
    }
  }

  List<Map<String, String>> _filtrarEDadosOrdenados() {
    var dadosFiltrados = _filtrarDados();
    dadosFiltrados.sort((a, b) {
      var aValue = a[_ordenarPor]!;
      var bValue = b[_ordenarPor]!;
      int resultado;
      if (_ordenarPor == 'valor') {
        resultado = double.parse(aValue).compareTo(double.parse(bValue));
      } else {
        resultado = aValue.compareTo(bValue);
      }
      return _isAscending ? resultado : -resultado;
    });
    return dadosFiltrados;
  }

  List<Map<String, String>> _filtrarDados() {
    return _dadosServicos.where((servico) {
      bool statusMatch =
          _filtroStatus == 'Todos' || servico['status'] == _filtroStatus;
      bool buscaMatch = servico['operacao']!
              .toLowerCase()
              .contains(_buscaController.text.toLowerCase()) ||
          servico['descricao']!
              .toLowerCase()
              .contains(_buscaController.text.toLowerCase());
      return statusMatch && buscaMatch;
    }).toList();
  }

  double _calcularTotal() {
    return _filtrarDados()
        .fold(0, (sum, servico) => sum + double.parse(servico['valor']!));
  }

  void gerarRelatorioPDF() async {
    final pdf = pw.Document();
    final logoData = await rootBundle.load('assets/icons/logo_car_wash.jpg');
    final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logoImage, width: 100, height: 100),
                  pw.Text(
                    'Relatório de Serviços',
                    style: pw.TextStyle(
                      fontSize: 26,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Nome da Empresa: KusukaMoto',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blueGrey800,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Histórico de Serviços',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.blueGrey700,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                headerStyle: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
                cellStyle: pw.TextStyle(fontSize: 12),
                headerDecoration:
                    pw.BoxDecoration(color: PdfColors.blueGrey600),
                cellPadding: pw.EdgeInsets.all(8),
                data: [
                  [
                    'Data',
                    'Operação',
                    'Descrição',
                    'Valor',
                    'Status',
                    'Estado'
                  ],
                  ..._filtrarEDadosOrdenados().map((servico) => [
                        servico['data'],
                        servico['operacao'],
                        servico['descricao'],
                        '${servico['valor']} MZN',
                        servico['status'],
                        servico['estado'],
                      ]),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: ${_calcularTotal()} MZN',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green800,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Salvando o arquivo PDF
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Relatorio_KusukaMoto.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
