import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lapkin_mobile/models/model/task_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _laporan;

  Future<List<TaskModel>> getLaporan() async {
    final snapshot = await _firestore.collection('laporan').get();
    return snapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();
  }

  Future<void> addLaporan(TaskModel task) async {
    _laporan = _firestore.collection('laporan');
    try {
      await _laporan
          .add(task.toMap())
          .then((value) => print('Laporan Ditambah'))
          .catchError((error) => print("Laporan Gagal Ditambah $error"));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<int> getCountLaporan() async {
    final snapshot = await _firestore.collection('laporan').get();
    return snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()))
        .toList()
        .length;
  }
}
