import 'package:kusuka_moto/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Usuario?> login(String email, String password);
  Future<String?> getUserType();
}
