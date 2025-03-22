import 'package:forui/forui.dart';
import 'package:memories/api/memories_repository.dart';
import 'package:memories/features/memories/memory_tile.dart';
import 'package:memories/main.dart';
import 'package:memories/models/memory.dart';
import 'package:memories/features/settings/settings_page.dart';

mixin HomeBloc {
  CollectionModifier<Memory> get memories => memoriesRepository;
  Modifier<Memory> get memory => memoriesRepository.item;

  void addNewMemoryDialog() {
    memory(Memory());
    navigator.toDialog(
      NewMemoryAddDialog(),
    );
  }
}

class HomePage extends UI with HomeBloc {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: 'Memories'.text(),
        actions: [
          FButton.icon(
            onPress: () => navigator.to(SettingsPage()),
            child: FIcon(FAssets.icons.settings),
          ).pad(),
        ],
      ),
      content: ListView.builder(
        itemCount: memories().length,
        itemBuilder: (context, index) {
          return MemoryTile(
            memory: memories().elementAt(index),
          );
        },
      ),
      footer: FButton(
        onPress: () {
          addNewMemoryDialog();
        },
        label: FIcon(FAssets.icons.plus),
      ).pad(),
    );
  }
}

mixin NewMemoryAddBloc {
  CollectionModifier<Memory> get memories => memoriesRepository;
  Modifier<Memory> get memory => memoriesRepository.item;

  String name([String? val]) {
    if (val != null) memory(memory()..name = val);
    return memory().name;
  }

  String description([String? val]) {
    if (val != null) memory(memory()..description = val);
    return memory().description;
  }

  void cancel() {
    navigator.back();
  }

  void saveMemory() {
    memories(memory());
    navigator.back();
  }
}

class NewMemoryAddDialog extends UI with NewMemoryAddBloc {
  const NewMemoryAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: 'New Memory'.text(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FTextField(
            initialValue: name(),
            onChange: name,
            label: Text('name'),
          ),
          FTextField(
            initialValue: description(),
            onChange: description,
            label: Text('description'),
          ),
        ],
      ).pad(),
      actions: [
        FButton.icon(
          onPress: () => cancel(),
          child: FIcon(FAssets.icons.chevronDown),
        ),
        FButton.icon(
          onPress: () => saveMemory(),
          child: FIcon(FAssets.icons.checkCheck),
        ),
      ],
      direction: Axis.horizontal,
    );
  }
}
