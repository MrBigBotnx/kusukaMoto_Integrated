class Servico {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final bool disponibilidade;

  Servico({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.disponibilidade
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'disponibilidade': disponibilidade,
    };
  }

  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      preco: map['preco']?.toDouble() ?? 0.0,
      disponibilidade: map['disponibilidade'] ?? true,
    );
  }
}
