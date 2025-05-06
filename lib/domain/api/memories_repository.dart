import 'package:memories/main.dart';
import 'package:memories/domain/models/memory.dart';

final memoriesRepository = MemoriesRepository();

class MemoriesRepository extends CRUD<Memory> {
  List<Memory> getMemories({
    int? limit,
    int? offset,
    String? search,
  }) {
    final memories = getAll();
    if (search != null) {
      return memories.where(
        (memory) {
          return memory.title.toLowerCase().contains(
                search.toLowerCase(),
              );
        },
      ).toList();
    }
    if (limit != null && offset != null) {
      return memories.sublist(offset, offset + limit);
    }
    return memories;
  }
}
