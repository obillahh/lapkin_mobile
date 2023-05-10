import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lapkin_mobile/views/auth_checker.dart';
import 'package:lapkin_mobile/views/screens/error_screen.dart';
import 'package:lapkin_mobile/views/screens/loading_screen.dart';
import 'package:lapkin_mobile/views/themes/app_fonts.dart';

import 'views/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseInitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.secondaryColor,
              displayColor: AppColors.primaryColor,
            ),
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.ink05,
        ),
        primaryTextTheme: AppFonts.primaryFont,
      ),
      home: initialize.when(
          data: (data) {
            return const AuthChecker();
          },
          error: (error, stackTrace) => ErrorScreen(
                e: error,
                trace: stackTrace,
              ),
          loading: () => const LoadingScreen()),
    );
  }
}
