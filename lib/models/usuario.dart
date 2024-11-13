class Usuario {
  final String id;
  final String nome;
  final String email;
  final String tipoUsuario;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipoUsuario,
  });

  // Método para converter o objeto em um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'tipoUsuario': tipoUsuario,
    };
  }

  // Método para criar uma instância de Usuario a partir de um Map
  factory Usuario.fromMap(Map<String, dynamic> map, String documentId) {
    return Usuario(
      id: documentId,
      nome: map['nome'],
      email: map['email'],
      tipoUsuario: map['tipoUsuario'],
    );
  }
}

class Cliente extends Usuario {
  Cliente({
    required super.id,
    required super.nome,
    required super.email,
  }) : super(tipoUsuario: 'cliente');
}

class Admin extends Usuario {
  Admin({
    required super.id,
    required super.nome,
    required super.email,
  }) : super(tipoUsuario: 'admin');
}