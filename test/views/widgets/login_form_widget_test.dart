import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lapkin_mobile/views/widgets/login_form_widget.dart';

void main() {
  testWidgets('login form widget test', (tester) async {
    await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: FormLogin(),
        )));
    expect(find.byType(TextFormField), findsNWidgets(2));   
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
