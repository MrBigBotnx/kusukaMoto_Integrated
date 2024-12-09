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
      User? user = await datasource.login(email, password);
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
}
