import 'package:firebase_auth/firebase_auth.dart';

import '../datasources/auth_datasource.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Usuario?> login(String email, String password) async {
    try {
      User? user = (await datasource.login(email, password)) as User?;
      if (user != null) {
        return Usuario(
          id: user.uid,
          name: user.displayName ?? "User",
          email: user.email!,
          userType: "Customer",
          profileImage: user.photoURL,
        );
      }
      return null;
    } catch (e) {
      print("Erro no login: $e");
      return null;
    }
  }

  @override
  Future<String?> getUserType() async {
    return "cliente";
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String contact,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user?.uid).set({
        'nome': name,
        'email': email,
        'contato': contact,
        'tipoUsuario': 'cliente', // Definir como cliente padrão
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
