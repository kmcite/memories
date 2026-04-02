import 'dart:async';

import 'package:memories/business/business.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/features.dart';
import 'package:redux/redux.dart';

class Medias {
  List<MemoryMedia> medias = [];
  List<MemoryMedia> queue = [];
  int failures = 0;
}

Medias medias(Medias state, action) {
  return switch (action) {
    MediasLoaded() => state..medias = action.medias,
    SubscribedToMedias() => state,
    UnsubscribedFromMedias() => state,
    AddMemoryMediaInApplication() => state,
    QueuedChanges() => state..queue = (List.of(state.queue)..add(action.media)),
    FailedToAddMedia() => state..failures = state.failures + 1,
    _ => state,
  };
}

class MediasMW extends MiddlewareClass<Business> {
  StreamSubscription? _subscription;
  @override
  call(store, action, next) async {
    next(action);
    switch (action) {
      case SubscribedToMedias():
        _subscription = memoryMediasRepository.watch().listen((medias) {
          dispatch(MediasLoaded(medias));
        });
      case UnsubscribedFromMedias():
        _subscription?.cancel();
        _subscription = null;
      case AddMemoryMediaInApplication():
        final id = await memoryMediasRepository.put(action.media);
        final media = memoryMediasRepository.get(id);
        if (media != null) {
          dispatch(QueuedChanges(media));
        } else {
          dispatch(FailedToAddMedia());
        }
    }
  }
}

class MediasLoaded {
  final List<MemoryMedia> medias;
  const MediasLoaded(this.medias);
}

class SubscribedToMedias {}

class UnsubscribedFromMedias {}

class AddMemoryMediaInApplication {
  final MemoryMedia media;
  const AddMemoryMediaInApplication(this.media);
}

class QueuedChanges {
  final MemoryMedia media;
  const QueuedChanges(this.media);
}

class FailedToAddMedia {}
