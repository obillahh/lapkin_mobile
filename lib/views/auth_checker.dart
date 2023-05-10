import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lapkin_mobile/views/screens/error_screen.dart';

import '../view_model/auth_provider.dart';
import 'screens/loading_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/main/home_screen.dart';
//import 'widgets/test_login_form.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
      error: (error, stackTrace) => ErrorScreen(
        e: error,
        trace: stackTrace,
      ),
      loading: () => const LoadingScreen(),
    );
  }
}
