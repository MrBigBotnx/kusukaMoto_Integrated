import 'package:kusuka_moto/models/categoria.dart';

class Servico {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final bool disponibilidade;
  final String? iconBase64;
  final CategoriaServico categoria;

  Servico({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.disponibilidade,
    required this.iconBase64,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'disponibilidade': disponibilidade,
      'iconBase64': iconBase64,
      'categoria': categoria.toString().split('.').last, // Salva como string
    };
  }

  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      preco: map['preco']?.toDouble() ?? 0.0,
      disponibilidade: map['disponibilidade'] ?? true,
      iconBase64: map['iconBase64'],

      categoria: CategoriaServico.values.firstWhere(
          (e) => e.toString().split('.').last == map['categoria'],
          orElse: () => CategoriaServico.outros),
    );
  }
}
