import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapkin_mobile/views/widgets/card_kinerja.dart';

import '../../../view_model/auth_provider.dart';
import '../../../view_model/laporan_provider.dart';
import '../../themes/app_colors.dart';
import '../../widgets/drawer.dart';
import '../error_screen.dart';
import '../loading_screen.dart';
import 'detail_screen.dart';

class KinerjaScreen extends ConsumerWidget {
  const KinerjaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(firebaseAuthProvider);
    final auth = ref.watch(authenticationProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.currentUser!.displayName ?? 'Anon',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          data.currentUser!.email ?? 'You\'re Logged in',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              color: AppColors.ink05,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              auth.signOut();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: const Size.fromHeight(40),
                            ),
                            child: const Text('Log out'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
      drawer: const DrawerCustom(),
      body: Consumer(
        builder: (context, ref, child) {
          final database = ref.watch(laporanListProvider);
          return database.when(
            data: (laporanList) => ListView.builder(
              itemCount: laporanList.length,
              itemBuilder: (context, index) {
                final laporan = laporanList[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  child: CardKinerja(
                    image: laporan.image,
                    aktivitas: laporan.title,
                    keterangan: laporan.description,
                    tanggal: laporan.date,
                    jamAwal: laporan.startTime,
                    jamAkhir: laporan.finishTime,
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            image: laporan.image,
                            title: laporan.title,
                            date: laporan.date,
                            startTime: laporan.startTime,
                            finishTime: laporan.finishTime,
                            description: laporan.description,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            error: (error, stackTrace) => ErrorScreen(
              e: error,
              trace: stackTrace,
            ),
            loading: () => const LoadingScreen(),
          );
        },
      ),
    );
  }
}
