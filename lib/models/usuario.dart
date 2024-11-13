class Usuario {
  final String id;
  final String nome;
  final String email;
  final String tipoUsuario; // Pode ser 'cliente' ou 'admin'

  Usuario({required this.id, required this.nome, required this.email, required this.tipoUsuario});
}

class Cliente extends Usuario {
  Cliente({required super.id, required super.nome, required super.email})
      : super(tipoUsuario: 'cliente');
}

class Admin extends Usuario {
  Admin({required super.id, required super.nome, required super.email})
      : super(tipoUsuario: 'admin');
}
