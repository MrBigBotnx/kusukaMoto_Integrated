import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kusuka_moto/features/auth/presentation/providers/login_providers.dart';

// Agora loginViewModelProvider é único e referenciado do lugar correto.

// Use providers.loginViewModelProvider para evitar ambiguidades.


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    final obscureText = ref.watch(obscureTextProvider);

    return Scaffold();
  }
}
