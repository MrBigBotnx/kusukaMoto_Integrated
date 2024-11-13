class Agendamento {
  Agendamento({
    required this.id, 
    required this.clienteId,
    required this.servicoId, 
    required this.data
  });

  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      id: map['id'] ?? '',
      clienteId: map['clienteId'] ?? '',
      servicoId: map['servicoId'] ?? '',
      data: DateTime.parse(map['data']),
    );
  }

  final String clienteId;
  final DateTime data;
  final String id;
  final String servicoId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': clienteId,
      'servicoId': servicoId,
      'data': data.toIso8601String(),
    };
  }
}
