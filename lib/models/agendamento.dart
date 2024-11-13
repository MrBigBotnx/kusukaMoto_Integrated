class Agendamento {
  final String id;
  final String clienteId;
  final String servicoId;
  final DateTime data;

  Agendamento({
    required this.id, 
    required this.clienteId,
    required this.servicoId, 
    required this.data
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': clienteId,
      'servicoId': servicoId,
      'data': data.toIso8601String(),
    };
  }

  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      id: map['id'] ?? '',
      clienteId: map['clienteId'] ?? '',
      servicoId: map['servicoId'] ?? '',
      data: DateTime.parse(map['data']),
    );
  }
}
