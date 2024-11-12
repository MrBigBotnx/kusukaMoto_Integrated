import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import 'database_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());
