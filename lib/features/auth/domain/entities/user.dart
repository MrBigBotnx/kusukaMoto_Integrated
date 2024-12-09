class Usuario {
  final String id;
  final String name;
  final String email;
  final String userType;
  final String? profileImage; // Adicionei o atributo opcional para imagem de perfil

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': email,
      'tipoUsuario': userType,
      'profileImage': profileImage,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map, String documentId) {
    return Usuario(
      id: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userType: map['userType'] ?? 'costumer',
      profileImage: map['profileImage'] ?? '',
    );
  }
}
