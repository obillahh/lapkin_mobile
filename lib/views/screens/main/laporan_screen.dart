import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lapkin_mobile/view_model/laporan_provider.dart';
import 'package:lapkin_mobile/views/themes/app_fonts.dart';

import '../../../models/model/task_model.dart';
import '../../../view_model/auth_provider.dart';
import '../../themes/app_colors.dart';
import '../../widgets/drawer.dart';
import 'home_screen.dart';

class LaporanScreen extends ConsumerStatefulWidget {
  const LaporanScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends ConsumerState<LaporanScreen> {
  final formKey = GlobalKey<FormState>();
  var controlAktivitas = TextEditingController();
  var controlTanggal = TextEditingController();
  var controlJamAwal = TextEditingController();
  var controlJamAkhir = TextEditingController();
  final tanggalSekarang = DateTime.now();
  final jamAwal = TimeOfDay.now();
  final jamAkhir = TimeOfDay.now();
  var controlKeterangan = TextEditingController();
  DateTime aturTanggal = DateTime.now();
  TimeOfDay aturJamAwal = TimeOfDay.now();

  File? controlImage;
  File? controlFile;

  String imageUrl = '';
  String fileUrl = '';

  @override
  void dispose() {
    controlAktivitas.dispose();
    controlTanggal.dispose();
    controlJamAwal.dispose();
    controlJamAkhir.dispose();
    controlKeterangan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          final database = ref.watch(databaseProvider);
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Laporan Hari ini',
                    style: AppFonts.primaryFont.headlineMedium,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'isi Aktivitas anda';
                            } else {
                              return null;
                            }
                          },
                          controller: controlAktivitas,
                          decoration: InputDecoration(
                            labelText: 'Aktivitas',
                            labelStyle: AppFonts.primaryFont.bodyMedium,
                            hintStyle: AppFonts.primaryFont.bodyMedium,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: 180,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'isi Tanggal Aktivitas anda';
                              } else {
                                return null;
                              }
                            },
                            controller: controlTanggal,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final pilihTanggal = await showDatePicker(
                                    context: context,
                                    initialDate: tanggalSekarang,
                                    firstDate: DateTime(2023),
                                    lastDate:
                                        DateTime(tanggalSekarang.year + 1),
                                  );
                                  setState(
                                    () {
                                      if (pilihTanggal != null) {
                                        aturTanggal = pilihTanggal;
                                        controlTanggal.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pilihTanggal);
                                      }
                                    },
                                  );
                                },
                                icon: const Icon(Icons.date_range),
                              ),
                              labelText: 'Tanggal',
                              labelStyle: AppFonts.primaryFont.bodyMedium,
                              hintText: 'dd/MM/yyyy',
                              hintStyle: AppFonts.primaryFont.bodyMedium,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Jam Berapa Dimulai';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: controlJamAwal,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      final pilihWaktu = await showTimePicker(
                                        context: context,
                                        initialTime: jamAwal,
                                      );
                                      setState(
                                        () {
                                          if (pilihWaktu != null) {
                                            DateTime aturJamAwal =
                                                DateFormat.jm().parse(pilihWaktu
                                                    .format(context)
                                                    .toString());
                                            controlJamAwal.text =
                                                DateFormat('HH:mm')
                                                    .format(aturJamAwal);
                                          }
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.more_time),
                                  ),
                                  labelText: 'Mulai',
                                  labelStyle: AppFonts.primaryFont.bodyMedium,
                                  hintText: 'dd/MM/yyyy',
                                  hintStyle: AppFonts.primaryFont.bodyMedium,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Jam Berapa Berakhir';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: controlJamAkhir,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      final pilihWaktu = await showTimePicker(
                                        context: context,
                                        initialTime: jamAkhir,
                                      );
                                      setState(
                                        () {
                                          if (pilihWaktu != null) {
                                            DateTime aturJamAkhir =
                                                DateFormat.jm().parse(pilihWaktu
                                                    .format(context)
                                                    .toString());
                                            controlJamAkhir.text =
                                                DateFormat('HH:mm')
                                                    .format(aturJamAkhir);
                                          }
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.more_time),
                                  ),
                                  labelText: 'Berakhir',
                                  labelStyle: AppFonts.primaryFont.bodyMedium,
                                  hintText: 'dd/MM/yyyy',
                                  hintStyle: AppFonts.primaryFont.bodyMedium,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'isi Keterangan Aktivitas Anda';
                            } else {
                              return null;
                            }
                          },
                          maxLines: 10,
                          minLines: 5,
                          controller: controlKeterangan,
                          decoration: InputDecoration(
                            labelText: 'Keterangan',
                            labelStyle: AppFonts.primaryFont.bodyMedium,
                            hintStyle: AppFonts.primaryFont.bodyMedium,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final result = await FilePicker.platform
                                    .pickFiles(type: FileType.image);
                                if (result == null) return;
                                final image = result.files.first;
                                Image.file(File(image.path.toString()));
                                final path = result.files.single.path!;
                                setState(() {
                                  controlImage = File(path);
                                });
                                String uniqueFileName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImage =
                                    referenceRoot.child('laporan');
                                Reference referenceImageUpload =
                                    referenceDirImage.child(uniqueFileName);

                                try {
                                  await referenceImageUpload
                                      .putFile(File(path));
                                  imageUrl = await referenceImageUpload
                                      .getDownloadURL();
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: controlImage == null
                                  ? Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: const [
                                          Expanded(
                                            child: Center(
                                              child: Icon(
                                                Icons.photo,
                                                color: AppColors.ink05,
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: AppColors.primaryColor,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Pick Image',
                                                style: TextStyle(
                                                  color: AppColors.ink05,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Image.file(
                                      controlImage!,
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result = await FilePicker.platform
                                    .pickFiles(type: FileType.any);
                                if (result == null) return;
                                final file = result.files.first;
                                Image.file(File(file.path.toString()));
                                final path = result.files.single.path!;
                                setState(() {
                                  controlFile = File(path);
                                });
                                String uniqueFileName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImage =
                                    referenceRoot.child('laporan');
                                Reference referenceImageUpload =
                                    referenceDirImage.child(uniqueFileName);

                                try {
                                  await referenceImageUpload
                                      .putFile(File(path));
                                  fileUrl = await referenceImageUpload
                                      .getDownloadURL();
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: controlFile == null
                                  ? Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: const [
                                          Expanded(
                                            child: Center(
                                              child: Icon(
                                                Icons.file_copy,
                                                color: AppColors.ink05,
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: AppColors.secondaryColor,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Pick File',
                                                style: TextStyle(
                                                  color: AppColors.ink05,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Image.file(
                                      controlFile!,
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final task = TaskModel(
              title: controlAktivitas.text,
              date: controlTanggal.text,
              startTime: controlJamAwal.text,
              finishTime: controlJamAkhir.text,
              description: controlKeterangan.text,
              image: imageUrl,
              file: fileUrl,
            );
            database.addLaporan(task);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Berhasil'),
                  content: const SizedBox(
                    child: Text('Laporan Berhasil Ditambahkan'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }

          print(imageUrl);
          print(fileUrl);
        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.check),
      ),
    );
  }
}
