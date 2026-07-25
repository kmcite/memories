import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';

final memoryDetailStateProvider = provider(
  (ref) => MemoryDetailState(
    ref(memoriesRepositoryProvider),
    ref(memoryMediasRepositoryProvider),
  ),
);

class MemoryDetailState extends Notifier {
  late final memory = signal<Memory?>(null);
  late final isFullscreen = signal(false);

  final CrudRepository<Memory> _memoriesReposiory;
  final CrudRepository<MemoryMedia> _memoryMediasReposiory;
  MemoryDetailState(
    this._memoriesReposiory,
    this._memoryMediasReposiory,
  );

  onMemoryUpdated(Memory memory) {
    this.memory.set(memory);
  }

  toggleFullscreen() {
    isFullscreen((v) => !v);
  }

  addImageMediaToMemory(MemoryMedia media) async {
    final _memory = memory();
    if (_memory != null) {
      _memory.media.add(media);
      memory.set(_memory);
      await _memoriesReposiory.put(_memory);
      await _memoryMediasReposiory.put(media);
    }
  }
}
