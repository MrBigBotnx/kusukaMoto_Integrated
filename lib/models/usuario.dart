class Usuario {
  final String id;
  final String nome;
  final String email;
  final String tipoUsuario;
  final String? profileImage; // Adicionei o atributo opcional para imagem de perfil

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipoUsuario,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'tipoUsuario': tipoUsuario,
      'profileImage': profileImage,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map, String documentId) {
    return Usuario(
      id: documentId,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      tipoUsuario: map['tipoUsuario'] ?? 'cliente',
      profileImage: map['profileImage'] ?? '',
    );
  }
}
