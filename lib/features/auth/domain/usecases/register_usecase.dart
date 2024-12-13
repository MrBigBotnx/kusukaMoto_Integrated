import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> call({
    required String email,
    password,
    name,
    contact,
  }) async {
    return await repository.register(
      email: email,
      password: password,
      name: name,
      contact: contact,
    );
  }
}
