import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart'; // Make sure to import AuthService

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});