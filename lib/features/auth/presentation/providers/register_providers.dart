import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/register_usecase.dart';
import '../providers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImpl(ref.read(firebaseAuthProvider)),
);

final registerUseCaseProvider = Provider(
  (ref) => RegisterController(ref.read(registerUseCaseProvider)),
);

final registerControllerProvider = ChangeNotifierProvider(
  (ref) => RegisterController(ref.read(registerUseCaseProvider)),
);
