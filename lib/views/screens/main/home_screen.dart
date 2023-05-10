import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapkin_mobile/view_model/laporan_provider.dart';

import '../../../view_model/auth_provider.dart';
import '../../themes/app_colors.dart';
import '../../widgets/card_target.dart';
import '../../widgets/drawer.dart';
import 'kinerja_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final data = ref.watch(firebaseAuthProvider);
    final auth = ref.watch(authenticationProvider);
    final database = ref.watch(databaseProvider);

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
                              Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(height: sizeHeight * 0.01),
            CardTarget(
              title: '0',
              subtitle: 'Target Kinerja Sudah Diverifikasi',
              trailing: const Icon(
                Icons.add_task_rounded,
                color: Colors.greenAccent,
              ),
              function: () {},
            ),
            SizedBox(height: sizeHeight * 0.01),
            CardTarget(
              title: '0',
              subtitle: 'Target Kinerja Sudah Divalidasi',
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
              ),
              function: () {},
            ),
            SizedBox(height: sizeHeight * 0.01),
            CardTarget(
              title: '0',
              subtitle: 'Target Kinerja Belum Diverifikasi',
              trailing: const Icon(
                Icons.warning_rounded,
                color: Colors.orangeAccent,
              ),
              function: () {},
            ),
            SizedBox(height: sizeHeight * 0.01),
            CardTarget(
              title: '0',
              subtitle: 'Target Kinerja Belum Divalidasi',
              trailing: const Icon(
                Icons.error_rounded,
                color: Colors.orangeAccent,
              ),
              function: () {},
            ),
            SizedBox(height: sizeHeight * 0.01),
            CardTarget(
              title: '0',
              subtitle: 'Target Kinerja Verifikasi Ditolak',
              trailing: const Icon(
                Icons.cancel,
                color: Colors.redAccent,
              ),
              function: () {},
            ),
            SizedBox(height: sizeHeight * 0.01),
            CardTarget(
              title: '0',
              subtitle: 'Target Kinerja Validasi Ditolak',
              trailing: const Icon(
                Icons.clear_rounded,
                color: Colors.redAccent,
              ),
              function: () {},
            ),
            SizedBox(height: sizeHeight * 0.01),
            FutureBuilder<int>(
              future: database.getCountLaporan(),
              builder: (context, snapshot) {
                return CardTarget(
                  title: '${snapshot.data}',
                  subtitle: 'Semua Target Kinerja',
                  trailing: const Icon(
                    Icons.task,
                    color: AppColors.primaryColor,
                  ),
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KinerjaScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
