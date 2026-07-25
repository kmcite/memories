import 'package:flutter/material.dart';
import 'package:manager/manager.dart';
import 'package:memories/business/adding_memory.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/features/features.dart';
import 'package:memories/utils/notifier.dart';

class AddMemoryDialog extends UI {
  const AddMemoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final addMemoryState = context(addingMemoryStateProvider);
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
              initialValue: addMemoryState.title(),
              onChanged: addMemoryState.title.set,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: addMemoryState.description.set,
              initialValue: addMemoryState.description(),
              maxLines: 3,
            ),
            ListTile(
              title: Text(
                addMemoryState.mood(),
                style: TextStyle(fontSize: 32),
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['😊', '😢', '🎉', '😡'].map(
                    (_mood) {
                      return IconButton(
                        icon: Text(_mood),
                        isSelected: _mood == addMemoryState.mood(),
                        onPressed: () {
                          addMemoryState.mood.set(_mood);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            TextFormField(
              initialValue: addMemoryState.location(),
              onChanged: addMemoryState.location.set,
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
                    addMemoryState.onMemoryAdded();
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
