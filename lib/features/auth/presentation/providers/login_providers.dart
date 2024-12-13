import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kusuka_moto/features/auth/data/datasources/auth_datasource.dart';
import 'package:kusuka_moto/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kusuka_moto/features/auth/domain/usecases/login_usecase.dart';
import 'package:kusuka_moto/features/auth/presentation/providers/login_controller.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authDataSourceProvider =
    Provider((ref) => AuthDataSource(ref.read(firebaseAuthProvider)));

final authRepositoryProvider =
    Provider((ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)));

final loginUseCaseProvider =
    Provider((ref) => LoginUseCase(ref.read(authRepositoryProvider)));

final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginViewModel(loginUseCase);
});

final obscureTextProvider = StateNotifierProvider<ObscureTextNotifier, bool>(
  (ref) => ObscureTextNotifier(),
);

class ObscureTextNotifier extends StateNotifier<bool> {
  ObscureTextNotifier() : super(true);

  void toggle() => state = !state;
}
