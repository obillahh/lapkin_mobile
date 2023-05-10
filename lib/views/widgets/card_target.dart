// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lapkin_mobile/views/themes/app_colors.dart';
import 'package:lapkin_mobile/views/themes/app_fonts.dart';

class CardTarget extends ConsumerWidget {
  const CardTarget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.function,
  });

  final String title;
  final String subtitle;
  final Widget trailing;
  final Function()? function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: function,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(
            color: AppColors.ink04,
          ),
        ),
        color: AppColors.ink05,
        elevation: 3,
        shadowColor: AppColors.ink01,
        child: ListTile(
          title: Text(
            title,
            style: AppFonts.primaryFont.titleLarge,
          ),
          subtitle: Text(
            subtitle,
            style: AppFonts.primaryFont.titleSmall,
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
