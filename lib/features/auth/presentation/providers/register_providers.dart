import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kusuka_moto/features/auth/data/datasources/auth_datasource.dart';
import 'package:kusuka_moto/features/auth/domain/usecases/register_usecase.dart';
import 'package:kusuka_moto/features/auth/presentation/providers/login_providers.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../providers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final authDataSourceProvider = Provider(
  (ref) => AuthDataSource(
    ref.read(firebaseAuthProvider),
    ref.read(firestoreProvider),
  ),
);

final authRepositoryProvider = Provider<AuthRepositoryImpl>(
  (ref) => AuthRepositoryImpl(
    datasource: ref.read(authDataSourceProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firebaseFirestoreProvider),
  ),
);

final registerUseCaseProvider = Provider(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider)),
);

final registerControllerProvider = ChangeNotifierProvider(
  (ref) => RegisterController(ref.read(registerUseCaseProvider)),
);
