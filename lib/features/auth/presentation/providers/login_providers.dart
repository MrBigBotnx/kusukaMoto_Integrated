import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository_impl.dart';
import '../data/auth_datasource.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/viewmodels/login_view_model.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final authDataSourceProvider