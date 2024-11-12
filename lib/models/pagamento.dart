class Pagamento {
  final String id;
  final String agendamentoId;
  final double valor;
  final DateTime dataPagamento;
  final String status;

  Pagamento({
    required this.id, 
    required this.agendamentoId, 
    required this.valor, 
    required this.dataPagamento, 
    required this.status
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'agendamentoId': agendamentoId,
      'valor': valor,
      'dataPagamento': dataPagamento.toIso8601String(),
      'status': status,
    };
  }

  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
      id: map['id'] ?? '',
      agendamentoId: map['agendamentoId'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      dataPagamento: DateTime.parse(map['dataPagamento']),
      status: map['status'] ?? 'pendente',
    );
  }
}
