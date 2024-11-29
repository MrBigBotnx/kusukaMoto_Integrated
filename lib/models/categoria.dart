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
        return "Limpeza";
      case CategoriaServico.manutencao:
        return "Manutenção";
      case CategoriaServico.estetica:
        return "Estética";
      case CategoriaServico.outros:
        return "Outros";
    }
  }

  String get iconPath {
    switch (this) {
      case CategoriaServico.lavagem:
        return 'assets/icons/car_wash.svg';
      case CategoriaServico.manutencao:
        return 'assets/icons/manutencao.svg';
      case CategoriaServico.estetica:
        return 'assets/icons/estetica.svg';
      case CategoriaServico.outros:
        return 'assets/icons/outros.svg';
    }
  }
}
