import 'package:forui/forui.dart';
import 'package:hux/hux.dart';
import 'package:memories/features/memories/dialogs/new_memory_v2.dart';
import 'package:memories/utils/extensions/state.dart';
import 'package:memories/domain/api/settings_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/memories/memory_tile.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/main.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/utils/navigator.dart';

import '../settings/settings_page.dart';

class MemoriesPage extends StatefulWidget {
  @override
  State<MemoriesPage> createState() => _MemoriesPageState();
}

class _MemoriesPageState extends State<MemoriesPage> {
  late MemoriesRepository memoriesRepository = depend();
  late SettingsRepository settingsRepository = depend();

  List<Memory> get memories => memoriesRepository.getAll();

  void onSettingsOpened() {
    navigator.to(SettingsPage());
  }

  void onNewMemoryDialogOpened() => navigator.toDialog(AddMemoryDialog());
  void onLocked() {
    settingsRepository.lock();
    navigator.toAndRemoveUntil(LockedPage());
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Memories'),
        // centerTitle: false,
        suffixes: [
          FHeaderAction(
            onPress: onNewMemoryDialogOpened,
            icon: Icon(FeatherIcons.briefcase),
            // size: HuxButtonSize.small,
          ),
          FHeaderAction(
            onPress: onSettingsOpened,
            icon: Icon(FeatherIcons.settings),
            // size: HuxButtonSize.small,
          ),
          FHeaderAction(
            onPress: onLocked,
            icon: Icon(FeatherIcons.lock),
            // size: HuxButtonSize.small,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTextField(
              hint: 'Search for memory here.',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: memories.length,
              itemBuilder: (context, index) {
                return MemoryTile(
                  memory: memories[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
