import 'package:file_picker/file_picker.dart';
import 'package:forui/forui.dart';
import 'package:memories/utils/extensions/state.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/utils/navigator.dart';

class AddNewMemoryDialog extends StatefulWidget {
  const AddNewMemoryDialog({super.key});

  @override
  State<AddNewMemoryDialog> createState() => _AddNewMemoryDialogState();
}

class _AddNewMemoryDialogState extends State<AddNewMemoryDialog> {
  late MemoriesRepository memoriesRepository = depend();

  Memory memory = Memory();
  String tag = '';
  void onTagChanged(String value) {
    this.tag = value;
    listener();
  }

  void onTagAdded(MemoryTag tag) {
    memory.tags.add(tag);
    this.tag = '';
    listener();
  }

  void onTagRemoved(MemoryTag tag) {
    memory.tags.remove(tag);
    listener();
  }

  void onMemoryChanged(Memory memory) {
    this.memory = memory;
    listener();
  }

  void onTitleChanged(String value) {
    onMemoryChanged(memory..title = value);
  }

  void onDescriptionChanged(String value) {
    onMemoryChanged(memory..description = value);
  }

  void onMoodChanged(String value) {
    onMemoryChanged(memory..mood = value);
  }

  void onMediaAdd() async {
    final picked = await FilePicker.platform.pickFiles();
    if (picked == null) {
      return;
    }
    if (picked.files.isEmpty) {
      return;
    }
    final file = picked.files.first;
    if (file.path == null) return;
    final media = MemoryMedia(
      path: file.path!,
      note: file.toString(),
    );
    memory.media.add(media);
  }

  void onCancelled() {
    navigator.back();
  }

  void onSaved() {
    memoriesRepository.put(memory);
    navigator.back();
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('New Memory'),
      body: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          FTextField(
            initialText: memory.title,
            onChange: onTitleChanged,
            label: Text('Title'),
          ),
          FTextField(
            initialText: memory.description,
            onChange: onDescriptionChanged,
            label: Text('Description'),
          ),
          FTextField(
            label: Text('Mood'),
            initialText: memory.mood,
            onChange: onMoodChanged,
          ),
          Column(
            spacing: 8,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: memory.tags.map(
                    (tag) {
                      return FTappable(
                        child: FBadge(
                          child: Text(tag.value),
                        ),
                        onPress: () => onTagRemoved(tag),
                      );
                    },
                  ).toList(),
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  FButton.icon(
                    onPress: () {
                      onTagAdded(MemoryTag()..value = tag);
                    },
                    child: Icon(FIcons.plus),
                  ),
                  Expanded(
                    child: FTextField(
                      onChange: (value) {
                        tag = value;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          FButton.icon(
            child: Icon(Icons.add_a_photo),
            onPress: onMediaAdd,
          ),
        ],
      ),
      actions: [
        FButton.icon(
          onPress: onCancelled,
          style: FButtonStyle.destructive(),
          child: Icon(FIcons.chevronDown),
        ),
        FButton.icon(
          onPress: onSaved,
          style: FButtonStyle.primary(),
          child: Icon(FIcons.checkCheck),
        ),
      ],
      direction: Axis.horizontal,
    );
  }
}
