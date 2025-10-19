import 'package:forui/forui.dart';
import 'package:memories/utils/extensions/state.dart';
import 'package:memories/features/memories/edit.dart';
import 'package:memories/features/memories/dialogs/memory_deletion_dialog.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/utils/navigator.dart';

import '../../main.dart';
import '../../domain/models/memory.dart';

extension DateTimeExtensions on DateTime {
  String formatRelative() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inDays >= 1) return '${diff.inDays}d ago';
    if (diff.inHours >= 1) return '${diff.inHours}h ago';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}

// class MemoryTile extends UI {
//   const MemoryTile({super.key, required this.memory});
//   final Memory memory;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 120, // Increased height for better visibility
//       width: 120, // Increased width for better visibility
//       child: Stack(
//         children: [
//           DecoratedBox(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.2),
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: memory.media.isEmpty
//                 ? SizedBox()
//                 : memory.media.first.filePath.isEmpty
//                     ? Image.file(
//                         File(memory.media.first.filePath),
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) => Center(
//                           child: Icon(
//                             Icons.image_not_supported,
//                             size: 50,
//                           ),
//                         ),
//                       ).pad()
//                     : Center(
//                         child: Icon(
//                           Icons.photo_library,
//                           size: 50,
//                         ),
//                       ).pad(),
//           ).pad(),
//           DecoratedBox(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.1),
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 '${memory.mood} | ${DateFormat.yMMMd().format(memory.createdAt)}'
//                     .text(),
//                 FButton.icon(
//                   onPress: () {
//                     navigator.to(
//                       ViewMemoryPage(
//                         memory: memory,
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.image),
//                   // tooltip: 'View Memory',
//                 ),
//                 // if (memory.path.isEmpty)
//                 FButton.icon(
//                   onPress: () => _save(memory),
//                   child: Icon(
//                     Icons.save,
//                   ),
//                 ),
//                 FButton.icon(
//                   onPress: () => _remove(memory.id),
//                   child: const Icon(Icons.delete_rounded),
//                 ),
//               ],
//             ),
//           ).pad(),
//         ],
//       ),
//     );
//   }
// }

class MemoryTile extends StatefulWidget {
  final Memory memory;

  const MemoryTile({
    super.key,
    required this.memory,
  });

  @override
  State<MemoryTile> createState() => _MemoryTileState();
}

class _MemoryTileState extends State<MemoryTile> {
  late MemoriesRepository memoriesRepository = depend();

  void onDelete(int id) => memoriesRepository.remove(id);

  @override
  Widget build(BuildContext context) {
    return FTile(
      prefix: SizedBox(
        width: 40,
        height: 40,
        child: _buildThumbnail(),
      ),
      title: Text(
        widget.memory.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.memory.mood.isNotEmpty)
                Text(widget.memory.mood, style: const TextStyle(fontSize: 16)),
              if (widget.memory.mood.isNotEmpty) const SizedBox(width: 6),
              Text(
                widget.memory.createdAt.formatRelative(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildTagChips(),
          Text(
            widget.memory.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      // onPress: onTap,
      suffix: Row(
        children: [
          widget.memory.isPinned
              ? Icon(Icons.push_pin, size: 20)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        navigator.to(EditMemoryPage(memory: widget.memory));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => memoryDeletionDialog(
                        widget.memory,
                        onDelete,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    if (widget.memory.media.isNotEmpty) {
      final first = widget.memory.media.firstWhere(
        (m) => m.type == 'image',
        orElse: () => widget.memory.media.first,
      );
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(first.path),
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Text(first.path),
        ),
      );
    }
    return const Icon(
      Icons.memory,
      size: 48,
    );
  }

  Widget _buildTagChips() {
    if (widget.memory.tags.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 4,
      runSpacing: -8,
      children: widget.memory.tags.map((tag) {
        return FBadge(
          child: Text('#${tag.value}'),
        );
      }).toList(),
    );
  }
}
