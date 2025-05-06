import 'package:forui/forui.dart';
import 'package:memories/_new_.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/features/memories/memory_tile.dart';
// import 'package:memories/features/memories/new_memory_add_dialog.dart';
import 'package:memories/features/startup/locked_page.dart';
import 'package:memories/main.dart';
import 'package:memories/features/settings/settings_page.dart';

void _openSettings() => navigator.to(SettingsPage());
void _openNewMemoryDialog() => navigator.toDialog(AddMemoryDialog());
void _lock() {
  navigator.toReplacement(LockedPage());
}

final _memoriesRM = RM.injectStream(
  () => memoriesRepository.watch(),
  initialState: memoriesRepository(),
);

class MemoriesPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: 'Memories'.text(),
        prefixActions: [
          FHeaderAction(
            onPress: _openNewMemoryDialog,
            icon: FIcon(FAssets.icons.plus),
          ),
          FHeaderAction(
            onPress: _openSettings,
            icon: FIcon(FAssets.icons.settings),
          ),
        ],
        suffixActions: [
          FHeaderAction(
            onPress: _lock,
            icon: FIcon(FAssets.icons.lock),
          ),
        ],
      ),
      content: Column(
        children: [
          FTextField(
            label: Text('Search memories...'),
            hint: 'memory',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _memoriesRM.state.length,
              itemBuilder: (context, index) {
                return MemoryTile(
                  memory: _memoriesRM.state.elementAt(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
