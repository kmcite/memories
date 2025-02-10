import 'package:forui/forui.dart';
import 'package:memories/main.dart';
import 'package:memories/memories/memories_bloc.dart';
import 'package:memories/memories/memory.dart';
import 'package:memories/memories/memory_tile.dart';
import 'package:memories/settings/settings_page.dart';

class HomePage extends UI {
  void didMountWidget(BuildContext context) {
    // super.didMountWidget(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: 'memories'.text(),
        actions: [
          FButton.icon(
            onPress: () => navigator.to(SettingsPage()),
            child: Icon(Icons.settings),
          ).pad(),
        ],
      ),
      body: ListView.builder(
        itemCount: memoriesRM.getAll().length,
        itemBuilder: (context, index) {
          return MemoryTile(
            memory: memoriesRM.getAll().elementAt(index),
          );
        },
      ),
      floatingActionButton: FButton.icon(
        onPress: () => homeBloc.addNewMemoryDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}

HomeBloc get homeBloc => HomeBloc();

class HomeBloc {
  void addNewMemoryDialog() {
    navigator.toDialog(
      NewMemoryAddDialog(),
    );
  }

  final newMemoryRM = RM.inject(
    () => Memory(
      id: 0,
      name: '',
      description: '',
      path: '',
      isHidden: true,
    ),
  );
  Memory get memory => newMemoryRM.state;
  void setMemory(Memory memory) => newMemoryRM
    ..state = memory
    ..notify();

  void setDescription(String value) {
    setMemory(memory.copyWith(description: value));
  }

  void setName(String value) {
    // setMemory(memory..name = value);
  }

  void cancel(Memory m) {
    setMemory(m);
    navigator.back();
  }

  void saveMemory() {
    memoriesRM.put(memory);
    // setMemory(Memory());
    navigator.back();
  }
}

class NewMemoryAddDialog extends UI {
  const NewMemoryAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ShadInput(
          //   initialValue: homeBloc.memory.name,
          //   onChanged: (value) {
          //     homeBloc.setName(value);
          //   },
          //   placeholder: Text('name'),
          // ),
          // ShadInput(
          //   initialValue: homeBloc.memory.description,
          //   onChanged: (value) {
          //     homeBloc.setDescription(value);
          //   },
          //   placeholder: Text('description'),
          // ),
          Row(
            children: [
              // ShadButton.destructive(
              //   onPressed: () {
              //     homeBloc.cancel();
              //   },
              //   icon: Icon(Icons.cancel),
              // ),
              // ShadButton(
              //   onPressed: () {
              //     homeBloc.saveMemory();
              //   },
              //   icon: Icon(Icons.done),
              // ),
            ],
          ),
        ],
      ).pad(),
    );
  }
}
