import 'package:file_picker/file_picker.dart';
import 'package:forui/forui.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/domain/models/memory.dart';

import 'main.dart';

class AddMemoryDialog extends StatefulWidget {
  const AddMemoryDialog({super.key});

  @override
  State<AddMemoryDialog> createState() => _AddMemoryDialogState();
}

class _AddMemoryDialogState extends State<AddMemoryDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();

  final List<MemoryTag> _tags = [];
  final List<MemoryMedia> _media = [];

  String _mood = '';
  String _location = '';
  bool _isPrivate = false;
  bool _isPinned = false;

  void _pickMedia() async {
    final picker = await FilePicker.platform.pickFiles();
    if (picker == null) return;

    final files = picker.files;

    for (final file in files) {
      final media = MemoryMedia(
        path: file.path!,
        type: file.extension ?? 'unknown',
      );
      setState(
        () => _media.add(media),
      );
    }
  }

  void _addTag(String value) {
    if (value.trim().isEmpty) return;
    setState(() {
      _tags.add(MemoryTag(value: value.trim()));
      _tagController.clear();
    });
  }

  void _save() {
    final memory = Memory(
      title: _titleController.text,
      description: _descriptionController.text,
      mood: _mood,
      location: _location,
      isPrivate: _isPrivate,
      isPinned: _isPinned,
    )
      ..media.addAll(_media)
      ..tags.addAll(_tags);

    memoriesRepository.put(memory);
    navigator.back();
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: const Text('Add New Memory'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FTextField(
              controller: _titleController,
              label: 'Title'.text(),
            ),
            FTextField(
              controller: _descriptionController,
              label: 'Description'.text(),
              maxLines: 3,
            ),
            FAlert(
              icon: FAvatar.raw(
                child: _mood.text(),
              ),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['😊', '😢', '🎉', '😡'].map(
                    (mood) {
                      return FTappable(
                        onPress: () {
                          setState(
                            () {
                              _mood = mood;
                            },
                          );
                        },
                        child: FBadge(
                          label: mood.text(),
                          style: _mood == mood
                              ? FBadgeStyle.primary
                              : FBadgeStyle.secondary,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            FTextField(
              label: Text('Location'),
              onChange: (val) => _location = val,
            ),
            SizedBox(height: 8),
            FSwitch(
              label: Text('Private'),
              value: _isPrivate,
              onChange: (v) => setState(() => _isPrivate = v),
            ),
            FSwitch(
              label: Text('Pinned'),
              value: _isPinned,
              onChange: (v) => setState(() => _isPinned = v),
            ),
            Row(
              children: [
                Expanded(
                  child: FTextField(
                    controller: _tagController,
                  ),
                ),
                FButton.icon(
                  child: const Icon(Icons.add),
                  onPress: () => _addTag(_tagController.text),
                ).pad(all: 4),
              ],
            ),
            Wrap(
              spacing: 4,
              children: _tags.map(
                (tag) {
                  return FBadge(
                    label: Text('#${tag.value}'),
                  ).pad(all: 4);
                },
              ).toList(),
            ),
            if (_media.isNotEmpty)
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _media.map(
                    (m) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.file(
                          File(m.path),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
          ],
        ),
      ),
      direction: Axis.vertical,
      actions: [
        FButton(
          onPress: _pickMedia,
          prefix: const Icon(Icons.photo_library),
          label: const Text('Pick Media'),
        ),
        FButton(
          onPress: () => Navigator.pop(context),
          label: const Text('Cancel'),
          style: FButtonStyle.destructive,
        ),
        FButton(
          onPress: _save,
          label: const Text('Save'),
        ),
      ],
    );
  }
}
