import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lapkin_mobile/models/model/task_model.dart';

import '../models/controllers/data.dart';

final databaseProvider = Provider<Database>((ref) => Database());

final laporanListProvider = FutureProvider<List<TaskModel>>((ref) async {
  final database = ref.watch(databaseProvider);
  return await database.getLaporan();
});
