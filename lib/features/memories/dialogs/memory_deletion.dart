import 'package:memories/business/memories.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/main.dart';
import 'package:memories/features/features.dart';
import 'package:memories/domain/models/memory.dart';

class MemoryDeletionDialog extends UI {
  final Memory memory;
  const MemoryDeletionDialog(this.memory, {super.key});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Delete Memory?'),
      contentPadding: .all(16),
      children: [
        Text('This action cannot be undone.'),
        SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            navigateBack();
          },
          child: const Text('Cancel'),
        ),
        SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            dispatchAll([
              DeleteMemoryAction(memory.id),
            ]);
            navigateBack();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
