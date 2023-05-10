import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lapkin_mobile/view_model/auth_provider.dart';

import '../screens/main/home_screen.dart';
import '../screens/main/laporan_screen.dart';
import '../themes/app_colors.dart';

class DrawerCustom extends ConsumerWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    final auth = ref.watch(authenticationProvider);
    return Drawer(
      backgroundColor: AppColors.ink05,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(
                'assets/images/app-logo-main.png',
                scale: sizeHeight * 0.01,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'KINERJA PEGAWAI',
                style: TextStyle(
                  color: AppColors.ink04,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.area_chart,
                color: AppColors.ink02,
              ),
              title: const Text(
                'Laporan Aktivitas',
                style: TextStyle(
                  color: AppColors.ink02,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LaporanScreen()),
                );
              },
            ),
            SizedBox(height: sizeHeight * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'BERANDA',
                style: TextStyle(
                  color: AppColors.ink04,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: AppColors.ink02,
              ),
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  color: AppColors.ink02,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
