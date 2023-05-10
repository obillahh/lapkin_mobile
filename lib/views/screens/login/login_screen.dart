import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lapkin_mobile/views/widgets/login_form_widget.dart';

import '../../themes/app_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset('assets/images/app-logo-main.png'),
        ),
        leadingWidth: sizeWidth * 0.3,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/login-v2.svg',
                width: sizeWidth * 0.5,
              ),
            ),
            SizedBox(height: sizeHeight * 0.03),
            Text(
              'Selamat Datang di LAPKIN',
              style: AppFonts.primaryFont.headlineSmall,
            ),
            SizedBox(height: sizeHeight * 0.01),
            Text(
              'Silahkan Login Untuk Memulai',
              textAlign: TextAlign.start,
              style: AppFonts.primaryFont.titleSmall,
            ),
            const SizedBox(height: 15),
            const FormLogin()
          ],
        ),
      ),
    );
  }
}
