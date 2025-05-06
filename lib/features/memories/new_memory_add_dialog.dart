import 'package:forui/forui.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';

final _memoryRM = RM.inject<Memory?>(() => null);

Memory _memory([Memory? value]) {
  if (value != null) {
    _memoryRM
      ..state = value
      ..notify();
  }
  return _memoryRM.state!;
}

String title([String? val]) {
  if (val != null) _memory(_memory()..title = val);
  return _memory().title;
}

String description([String? val]) {
  if (val != null) _memory(_memory()..description = val);
  return _memory().description;
}

void _cancel() {
  navigator.back();
}

void _saveMemory() {
  memoriesRepository(_memory());
  navigator.back();
}

final tagRM = RM.inject(() => '');

class NewMemoryAddDialog extends UI {
  const NewMemoryAddDialog({super.key});
  @override
  void didMountWidget(BuildContext context) {
    super.didMountWidget(context);
    _memoryRM
      ..state = Memory()
      ..notify();
  }

  @override
  void didUnmountWidget() {
    _memoryRM
      ..state = null
      ..notify();
    super.didUnmountWidget();
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: 'New Memory'.text(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FTextField(
            initialValue: title(),
            onChange: title,
            label: Text('Title'),
          ),
          FTextField(
            initialValue: description(),
            onChange: description,
            label: Text('Description'),
          ),
          FTextField(
            label: 'Mood'.text(),
            onChange: (value) {
              _memory(_memory()..mood = value);
            },
          ),
          SizedBox(height: 8),
          FAlert(
            icon: FButton.icon(
              onPress: () {
                _memory(_memory()..tags.add(MemoryTag()..value = tagRM.state));
                tagRM.refresh();
              },
              child: FIcon(FAssets.icons.plus),
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _memory()
                    .tags
                    .map(
                      (tag) => FBadge(
                        label: Text(tag.value),
                      ).pad(all: 4),
                    )
                    .toList(),
              ),
            ),
            subtitle: FTextField(
              onChange: (value) => tagRM.state = value,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {},
          ),
        ],
      ),
      actions: [
        FButton.icon(
          onPress: () => _cancel(),
          style: FButtonStyle.destructive,
          child: FIcon(FAssets.icons.chevronDown),
        ),
        FButton.icon(
          onPress: () => _saveMemory(),
          style: FButtonStyle.primary,
          child: FIcon(FAssets.icons.checkCheck),
        ),
      ],
      direction: Axis.horizontal,
    );
  }
}
