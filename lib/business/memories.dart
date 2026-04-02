import 'dart:async';

import 'package:memories/business/business.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:redux/redux.dart';

class MemoriesState {
  List<Memory> memories = const [];
}

MemoriesState memories(MemoriesState state, action) {
  switch (action) {
    case LoadMemories():
      state..memories = action.memories;
      break;
    default:
  }
  return state;
}

class MemoriesMW extends MiddlewareClass<Business> {
  StreamSubscription<List<Memory>>? _subscription;
  @override
  call(store, action, next) {
    next(action);

    switch (action) {
      case UnsubscribeFromMemories():
        _subscription?.cancel();
        _subscription = null;
        break;
      case SubscribeToMemories():
        _subscription ??= memoriesRepository.watch().listen((memories) {
          store.dispatch(LoadMemories(memories));
        });
        break;
      case DeleteMemoryAction():
        memoriesRepository.remove(action.memoryId);
        break;
      default:
        break;
    }
  }
}

class MemoriesAction {}

class SubscribeToMemories extends MemoriesAction {}

class UnsubscribeFromMemories extends MemoriesAction {}

class LoadMemories extends MemoriesAction {
  final List<Memory> memories;
  LoadMemories(this.memories);
}

class DeleteMemoryAction extends MemoriesAction {
  final int memoryId;
  DeleteMemoryAction(this.memoryId);
}
