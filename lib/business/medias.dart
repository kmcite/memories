import 'dart:async';

import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';

final mediasStateProvider = provider(
  (ref) => MediasState(ref(memoryMediasRepositoryProvider)),
);

class MediasState extends Notifier {
  late final medias = signal([]);
  late final queue = signal([]);
  late final failures = signal(0);
  StreamSubscription? _subscription;
  final CrudRepository<MemoryMedia> mediasRepository;
  MediasState(this.mediasRepository) {
    _subscription = mediasRepository.watch().listen(
      medias.set, // medias loaded
    ); // subscribed to medias
  }
  FutureOr<void> addMemoryMediaInApplication(MemoryMedia memoryMedia) async {
    final id = await mediasRepository.put(memoryMedia);
    final media = mediasRepository.get(id);
    if (media != null) {
      queueChanges(media);
    } else {
      failedToAddMedia();
    }
  }

  void queueChanges(MemoryMedia media) {
    queue.set(List.of(queue())..add(media));
  }

  void failedToAddMedia() {
    failures.value++;
  }

  @override
  void dispose() {
    _subscription?.cancel(); // unsubscribe from medias
    super.dispose();
  }
}
