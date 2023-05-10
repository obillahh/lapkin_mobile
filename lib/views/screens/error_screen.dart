// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  final Object e;
  final StackTrace? trace;
  const ErrorScreen({
    super.key,
    required this.e,
    this.trace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(e);
    print(trace);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(e.toString()),
          Text(trace.toString()),
        ],
      ),
    );
  }
}
