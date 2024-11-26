enum CategoriaServico {
  lavagem, // Categoria para serviços de lavagem
  manutencao, // Categoria para serviços de manutenção
  estetica, // Categoria para serviços de estética
  outros // Categoria para serviços adicionais ou sem classificação específica
}

extension CategoriaServicoExtension on CategoriaServico {
  String get descricao {
    switch (this) {
      case CategoriaServico.lavagem:
        return "Lavagem";
      case CategoriaServico.manutencao:
        return "Manutenção";
      case CategoriaServico.estetica:
        return "Estética";
      case CategoriaServico.outros:
        return "Outros";
    }
  }
}
