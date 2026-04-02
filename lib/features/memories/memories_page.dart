import 'package:memories/business/locking_mechanism.dart';
import 'package:memories/business/memories.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/features/medias.dart';
import 'package:memories/features/memories/dialogs/add_memory.dart';
import 'package:memories/features/memories/memory_tile.dart';
import 'package:memories/features/settings/settings_page.dart';
import 'package:memories/features/tags.dart';
import 'package:memories/main.dart';
import 'package:memories/features/features.dart';

class MemoriesPage extends UI {
  @override
  void init() {
    dispatch(SubscribeToMemories());
  }

  @override
  Widget build(BuildContext context) {
    final listOfMemories = state.memories.memories;
    return Scaffold(
      appBar: AppBar(
        title: Text('Memories'),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(MediasScreen());
            },
            icon: Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              navigateTo(TagsScreen());
            },
            icon: Icon(Icons.tag),
            // size: HuxButtonSize.small,
          ),
          IconButton(
            onPressed: () {
              navigateTo(SettingsPage());
            },
            icon: Icon(Icons.settings),
            // size: HuxButtonSize.small,
          ),
          IconButton(
            onPressed: () {
              dispatch(LockApplicationAction());
            },
            icon: Icon(
              Icons.lock,
              color: Colors.red,
            ),
            // size: HuxButtonSize.small,
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for memory here.',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listOfMemories.length,
              itemBuilder: (context, index) {
                return MemoryTile(
                  memory: listOfMemories[index],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDialog(AddMemoryDialog());
        },
        child: Icon(Icons.add_box_outlined),
      ),
    );
  }
}
