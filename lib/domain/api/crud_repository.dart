import 'package:memories/domain/models/memory.dart';
import 'package:objectbox/objectbox.dart' show Store;

late Store objects;

final memoriesRepository = CrudRepository<Memory>();

final memoryMediasRepository = CrudRepository<MemoryMedia>();

final memoryTagsRepository = CrudRepository<MemoryTag>();

class CrudRepository<T> {
  late final box = objects.box<T>();

  Future<int> put(T any) async => await box.putAsync(any);

  Future<void> remove(int id) async => await box.removeAsync(id);

  List<T> getAll() => box.getAll();
  T? get(int id) => box.get(id);
  Stream<List<T>> watch() {
    return box
        .query()
        .watch(triggerImmediately: true)
        .map((finder) => finder.find());
  }
}
