import 'package:file_picker/file_picker.dart';
import 'package:forui/forui.dart';

import '../../main.dart';
import '../../models/memory.dart';

class MemoryTileBloc {
  static void saver(Memory memory) {
    if (memory.path.isEmpty) {
      FilePicker.platform.pickFiles().then(
        (result) {
          if (result?.files.first.path != null) {
            // memoriesRM.put(
            //   memory.copyWith(path: result!.files.first.path!),
            // );
          }
        },
      );
    }
  }
}

class MemoryTile extends UI {
  const MemoryTile({super.key, required this.memory});
  final Memory memory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Increased height for better visibility
      width: 120, // Increased width for better visibility
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: memory.path.isNotEmpty
                ? Image.file(
                    File(memory.path),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                      ),
                    ),
                  ).pad()
                : Center(
                    child: Icon(
                      Icons.photo_library,
                      size: 50,
                    ),
                  ).pad(),
          ).pad(),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FButton.icon(
                  onPress: () {
                    navigator.to(
                      MemoryPage(
                        memory: memory,
                      ),
                    );
                  },
                  child: const Icon(Icons.image),
                  // tooltip: 'View Memory',
                ),
                if (memory.path.isEmpty)
                  FButton.icon(
                    onPress: () => MemoryTileBloc.saver(memory),
                    child: Icon(
                      Icons.add_photo_alternate,
                    ),
                  ),
                FButton.icon(
                  onPress: () {
                    // memoriesRM.delete(memory.id);
                  },
                  child: const Icon(Icons.delete_rounded),
                ),
              ],
            ),
          ).pad(),
        ],
      ),
    );
  }
}
