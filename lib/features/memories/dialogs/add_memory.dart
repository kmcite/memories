import 'package:memories/business/navigation.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/features.dart';
import 'package:signals/signals.dart';

import '../../../main.dart';

final title = signal<String>('');
final description = signal<String>('');
final mood = signal<String>('');
final location = signal<String>('');

void setTitle(String value) {
  title.set(value);
}

void setDescription(String value) {
  description.set(value);
}

void setMood(String value) {
  mood.set(value);
}

void setLocation(String value) {
  location.set(value);
}

class AddMemoryDialog extends UI {
  const AddMemoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Memory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              initialValue: title(),
              onChanged: (v) => setTitle(v),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (v) => setDescription(v),
              initialValue: description(),
              maxLines: 3,
            ),
            ListTile(
              title: Text(mood(), style: TextStyle(fontSize: 32)),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['😊', '😢', '🎉', '😡'].map(
                    (_mood) {
                      return IconButton(
                        icon: Text(_mood),
                        isSelected: _mood == mood(),
                        onPressed: () {
                          setMood(_mood);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            TextFormField(
              initialValue: location(),
              onChanged: (value) => setLocation(value),
              decoration: InputDecoration(labelText: 'Location'),
            ),
            Row(
              spacing: 8,
              children: [
                FilledButton(
                  onPressed: () {
                    navigateBack();
                  },
                  child: Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    memoriesRepository.put(
                      Memory()
                        ..title = title()
                        ..description = description()
                        ..mood = mood()
                        ..location = location(),
                    );
                    navigateBack();
                  },
                  child: Text('Add Memory'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
