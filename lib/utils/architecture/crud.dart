import 'package:memories/utils/architecture/repositories.dart';
import 'package:objectbox/objectbox.dart';

mixin CRUD<T> on Repository<T> {
  late final Store store = serve<Store>();
  late final box = store.box<T>();

  T? get(int id) => box.get(id);

  void put(T any) {
    box.putAsync(any).then(notifyListeners);
  }

  List<T> getAll({
    int? limit,
    int? offset,
  }) {
    final items = box.getAll();
    if (limit != null && offset != null) {
      return items.sublist(offset, offset + limit);
    }
    return items;
  }

  void remove(int id) {
    box.removeAsync(id).then(notifyListeners);
  }
}
