import 'dart:async';

import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';

final tagsStateProvider = provider(
  (ref) => TagsState(ref(memoryTagsRepositoryProvider)),
);

class TagsState extends Notifier {
  final CrudRepository<MemoryTag> memoryTagsRepository;
  StreamSubscription<List<MemoryTag>>? _subscription;
  TagsState(this.memoryTagsRepository) {
    _subscription = memoryTagsRepository.watch().listen(tags.set);
  }
  late final tags = signal(<MemoryTag>[]);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
