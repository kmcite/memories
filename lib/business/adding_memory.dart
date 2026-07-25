import 'package:manager/manager.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/utils/notifier.dart';

final addingMemoryStateProvider = provider(
  (ref) => AddingMemoryState(ref(memoriesRepositoryProvider)),
);

class AddingMemoryState extends Notifier {
  final CrudRepository<Memory> memoriesRepository;
  AddingMemoryState(this.memoriesRepository);
  late final title = signal('');
  late final mood = signal('');
  late final description = signal('');
  late final location = signal('');
  void resetState() {
    title.set('');
    mood.set('');
    description.set('');
    location.set('');
  }

  void onMemoryAdded() {
    final memory = Memory(
      title: title(),
      mood: mood(),
      description: description(),
      location: location(),
    );

    memoriesRepository.put(memory);
    resetState();
    notifyListeners();
  }
}
