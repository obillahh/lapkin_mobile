// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lapkin_mobile/view_model/auth_provider.dart';
import 'package:lapkin_mobile/views/themes/app_fonts.dart';

enum Status {
  login,
  signUp,
}

Status type = Status.login;

class FormLogin extends ConsumerStatefulWidget {
  static const routename = '/LoginPage';
  const FormLogin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormLoginState();
}

class _FormLoginState extends ConsumerState<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  void loading() {
    if (mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  void _switchType() {
    if (type == Status.signUp) {
      if (mounted) {
        setState(() {
          type = Status.login;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          type = Status.signUp;
        });
      }
    }
  }

  final obscuredProvider = StateProvider<bool>((ref) {
    return true;
  });

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (context, ref, child) {
        final bool isObscured = ref.watch(obscuredProvider);
        final auth = ref.watch(authenticationProvider);
        Future<void> _onPressedFunction() async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          if (type == Status.login) {
            loading();
            await auth
                .signInWithEmailAndPassword(
                    _email.text, _password.text, context)
                .whenComplete(() => auth.authStateChange.listen((event) {
                      if (event == null) {
                        loading();
                        return;
                      }
                    }));
          } else {
            loading();
            await auth
                .signUpWithEmailAndPassword(
                    _email.text, _password.text, context)
                .whenComplete(() => auth.authStateChange.listen((event) {
                      if (event == null) {
                        loading();
                        return;
                      }
                    }));
          }
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: AppFonts.primaryFont.bodyMedium,
              ),
              SizedBox(height: sizeHeight * 0.01),
              SizedBox(
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: AppFonts.primaryFont.bodyMedium,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              if (type == Status.signUp) SizedBox(height: sizeHeight * 0.01),
              SizedBox(height: sizeHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password',
                    style: AppFonts.primaryFont.bodyMedium,
                  ),
                  if (type == Status.login)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Lupa Password?',
                        style: AppFonts.primaryFont.bodyMedium,
                      ),
                    ),
                ],
              ),
              if (type == Status.signUp) SizedBox(height: sizeHeight * 0.01),
              SizedBox(
                child: TextFormField(
                  controller: _password,
                  obscureText: isObscured,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => ref
                          .read(obscuredProvider.notifier)
                          .update((state) => !state),
                      icon: isObscured
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    hintText: 'Password',
                    hintStyle: AppFonts.primaryFont.bodyMedium,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              if (type == Status.signUp) SizedBox(height: sizeHeight * 0.02),
              if (type == Status.signUp)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Password',
                        style: AppFonts.primaryFont.bodyMedium,
                      ),
                      SizedBox(height: sizeHeight * 0.01),
                      TextFormField(
                        obscureText: isObscured,
                        keyboardType: TextInputType.visiblePassword,
                        validator: type == Status.signUp
                            ? (value) {
                                if (value != _password.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              }
                            : null,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => ref
                                .read(obscuredProvider.notifier)
                                .update((state) => !state),
                            icon: isObscured
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: AppFonts.primaryFont.bodyMedium,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: sizeHeight * 0.02),
              ElevatedButton(
                onPressed: _onPressedFunction,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(sizeHeight * 0.06),
                ),
                child: Text(
                  type == Status.login ? 'Login' : 'Sign Up',
                  style: AppFonts.primaryFont.bodyMedium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    type == Status.login
                        ? 'Don\'t have an account?'
                        : 'Already have an account?',
                    style: AppFonts.primaryFont.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      _switchType();
                    },
                    child: Text(
                      type == Status.login ? 'Sign up now' : 'Log in',
                      style: AppFonts.primaryFont.bodyMedium,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
