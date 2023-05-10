import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lapkin_mobile/views/screens/login/login_screen.dart';

void main() {
  testWidgets('Login Screen UI test', (tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // Build MyPage widget
    await tester.pumpWidget(const ProviderScope(
      child: MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: LoginScreen(),
          )),
    ));

    // Verify the UI widgets
    expect(find.text('Selamat Datang di LAPKIN'), findsOneWidget);
    expect(find.text('Silahkan Login Untuk Memulai'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
