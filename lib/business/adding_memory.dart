import 'package:memories/business/business.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:redux/redux.dart';

class AddingMemoryState {
  Memory? memoryToBeSaved;
  String title = '';
  String mood = '';
  String description = '';
  String location = '';
  void resetState() {
    memoryToBeSaved = null;
    title = '';
    mood = '';
    description = '';
    location = '';
  }
}

AddingMemoryState addingMemory(AddingMemoryState state, action) {
  if (action is OnMemoryAdded) {
    final memory = Memory(
      title: state.title,
      mood: state.mood,
      description: state.description,
      location: state.location,
    );
    return state..memoryToBeSaved = memory;
  } else if (action is ChangeTitle) {
    return state..title = action.title;
  } else if (action is ChangeMood) {
    return state..mood = action.mood;
  } else if (action is ChangeDescription) {
    return state..description = action.description;
  } else if (action is ChangeLocation) {
    return state..location = action.location;
  }
  return state;
}

class AddingMemoryMW extends MiddlewareClass<Business> {
  @override
  call(store, action, next) {
    next(action);
    if (action is OnMemoryAdded) {
      final memory = Memory(
        title: store.state.addingMemory.title,
        mood: store.state.addingMemory.mood,
        description: store.state.addingMemory.description,
        location: store.state.addingMemory.location,
      );
      memoriesRepository.put(memory);
      store.state.addingMemory.resetState();
    }
  }
}

class AddingMemoryAction {}

class OnMemoryAdded extends AddingMemoryAction {}

class ChangeTitle extends AddingMemoryAction {
  final String title;
  ChangeTitle(this.title);
}

class ChangeDescription extends AddingMemoryAction {
  final String description;
  ChangeDescription(this.description);
}

class ChangeMood extends AddingMemoryAction {
  final String mood;
  ChangeMood(this.mood);
}

class ChangeLocation extends AddingMemoryAction {
  final String location;
  ChangeLocation(this.location);
}
