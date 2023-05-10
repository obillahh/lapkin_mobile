// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapkin_mobile/views/themes/app_colors.dart';
import 'package:lapkin_mobile/views/themes/app_fonts.dart';

class CardKinerja extends ConsumerWidget {
  const CardKinerja({
    super.key,
    required this.image,
    required this.aktivitas,
    required this.keterangan,
    required this.tanggal,
    required this.jamAwal,
    required this.jamAkhir,
    required this.function,
  });

  final String image;
  final String aktivitas;
  final String keterangan;
  final String tanggal;
  final String jamAwal;
  final String jamAkhir;
  final Function() function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: function,
      child: Card(
        color: AppColors.ink05,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(
            color: AppColors.ink04,
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.ink01,
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          height: 200,
          child: AspectRatio(
            aspectRatio: 4,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 12 / 18,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aktivitas,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.15,
                          color: AppColors.primaryColor,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        keterangan,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tanggal,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          backgroundColor: AppColors.primaryColor,
                          color: AppColors.ink05,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dari : ',
                                style: AppFonts.primaryFont.bodyMedium,
                              ),
                              Text(
                                jamAwal,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  backgroundColor: Colors.greenAccent,
                                  color: AppColors.ink05,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '-',
                            style: GoogleFonts.montserrat(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sampai : ',
                                style: AppFonts.primaryFont.bodyMedium,
                              ),
                              Text(
                                jamAkhir,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  backgroundColor: Colors.redAccent,
                                  color: AppColors.ink05,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
