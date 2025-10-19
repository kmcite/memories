import 'package:forui/forui.dart';
import 'package:memories/main.dart';
import 'package:memories/utils/navigator.dart';

import '../../../domain/models/memory.dart';

void memoryDeletionDialog(
  Memory memory,
  void Function(int memoryId) onDelete,
) async {
  final delete = await navigator.toDialog<bool>(
    FDialog(
      title: const Text('Delete Memory?'),
      direction: Axis.horizontal,
      body: Text('This action cannot be undone.'),
      actions: [
        FButton(
          onPress: () => navigator.back(false),
          child: const Text('Cancel'),
        ),
        FButton(
          onPress: () => navigator.back(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (delete == true) {
    onDelete(memory.id);
  }
}
