import 'package:memories/business/business.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/features.dart';
import 'package:redux/redux.dart';

class MemoryDetailState {
  Memory? memory;
  bool isFullscreen = false;
}

MemoryDetailState memoryDetails(MemoryDetailState state, dynamic action) {
  switch (action) {
    case OnMemoryUpdated():
      state.memory = action.memory;
      return state;
    case ToggleFullscreen():
      state.isFullscreen = !state.isFullscreen;
      return state;
    case AddImageMediaToMemory():
      final memory = state.memory;
      if (memory != null) {
        memory.media.add(action.image);
        state.memory = memory;
        dispatch(TriggerMemoryAndMediaUpdate(memory, action.image));
      }
      return state;
    default:
      return state;
  }
}

class MemoryDetailsMW extends MiddlewareClass<Business> {
  @override
  call(store, action, next) {
    next(action);
    if (action is TriggerMemoryAndMediaUpdate) {
      memoriesRepository.put(action.memory);
    }
  }
}

class OnMemoryUpdated {
  final Memory memory;
  const OnMemoryUpdated(this.memory);
}

class AddImageMediaToMemory {
  final MemoryMedia image;
  const AddImageMediaToMemory(this.image);
}

class ToggleFullscreen {}

class TriggerMemoryAndMediaUpdate {
  final Memory memory;
  final MemoryMedia media;
  const TriggerMemoryAndMediaUpdate(this.memory, this.media);
}
