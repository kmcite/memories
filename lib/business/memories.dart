import 'dart:async';

import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';

final memoriesStateProvider = provider(
  (ref) => MemoriesState(ref(memoriesRepositoryProvider)),
);

class MemoriesState extends Notifier {
  final CrudRepository<Memory> memoriesRepository;
  MemoriesState(this.memoriesRepository) {
    memoriesRepository.watch().listen(memories.set);
  }
  late final memories = signal(<Memory>[]);

  FutureOr<void> deleteMemory(int id) async {
    await memoriesRepository.remove(id);
  }
}
