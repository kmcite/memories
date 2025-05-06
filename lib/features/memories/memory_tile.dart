import 'package:forui/forui.dart';
import 'package:memories/domain/api/memories_repository.dart';
import 'package:memories/features/memories/edit.dart';

import '../../main.dart';
import '../../domain/models/memory.dart';

String formatRelativeDate(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays >= 1) return '${diff.inDays}d ago';
  if (diff.inHours >= 1) return '${diff.inHours}h ago';
  if (diff.inMinutes >= 1) return '${diff.inMinutes}m ago';
  return 'Just now';
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

class MemoryTile extends StatelessWidget {
  final Memory memory;

  const MemoryTile({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    void _confirmDelete(Memory memory) async {
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) => FDialog(
          title: const Text('Delete Memory?'),
          body: const Text('This action cannot be undone.'),
          actions: [
            FButton(
                onPress: () => Navigator.pop(context, false),
                label: const Text('Cancel')),
            FButton(
                onPress: () => Navigator.pop(context, true),
                label: const Text('Delete')),
          ],
        ),
      );
      if (shouldDelete == true) {
        memoriesRepository.remove(memory.id);
      }
    }

    return FTile(
      prefixIcon: _buildThumbnail(),
      title: Text(
        memory.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              if (memory.mood.isNotEmpty)
                Text(memory.mood, style: const TextStyle(fontSize: 16)),
              if (memory.mood.isNotEmpty) const SizedBox(width: 6),
              Text(
                formatRelativeDate(memory.createdAt),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildTagChips(),
          if (memory.description.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              _shortenText(memory.description),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
      // onPress: onTap,
      suffixIcon: Row(
        children: [
          memory.isPinned
              ? Icon(Icons.push_pin, size: 20)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          navigator.to(EditMemoryPage(memory: memory)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _confirmDelete(memory),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    if (memory.media.isNotEmpty) {
      final first = memory.media.firstWhere(
        (m) => m.type == 'image',
        orElse: () => memory.media.first,
      );
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(first.path),
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
      );
    }
    return const Icon(Icons.memory, size: 48, color: Colors.grey);
  }

  Widget _buildTagChips() {
    if (memory.tags.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 4,
      runSpacing: -8,
      children: memory.tags.map((tag) {
        return Chip(
          label: Text('#${tag.value}'),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }

  String _shortenText(String text, {int maxLength = 100}) {
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}...';
  }
}
