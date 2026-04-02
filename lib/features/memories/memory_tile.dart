import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memories/business/navigation.dart';

import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/memories/memory_page.dart';

extension _RelativeTime on DateTime {
  String get relative {
    final d = DateTime.now().difference(this);
    if (d.inDays >= 1) return '${d.inDays}d';
    if (d.inHours >= 1) return '${d.inHours}h';
    if (d.inMinutes >= 1) return '${d.inMinutes}m';
    return 'now';
  }
}

class MemoryTile extends StatelessWidget {
  const MemoryTile({super.key, required this.memory});

  final Memory memory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final meta = [
      if (memory.mood.isNotEmpty) memory.mood,
      memory.createdAt.relative,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: _Thumbnail(memory: memory),
        onTap: () => navigateTo(
          MemoryPage(memory: memory),
        ),
        title: Text(
          memory.title.isEmpty ? 'Untitled' : memory.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meta,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (memory.description.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                memory.description,
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (memory.tags.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                memory.tags.map((t) => '#${t.value}').join(' '),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        trailing: memory.isPinned
            ? Icon(Icons.push_pin, size: 18, color: theme.colorScheme.primary)
            : null,
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.memory});

  final Memory memory;

  @override
  Widget build(BuildContext context) {
    final imageMedia = memory.media
        .where((m) => m.type == 'image' && m.path.isNotEmpty)
        .firstOrNull;

    if (imageMedia != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imageMedia.path),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(context),
        ),
      );
    }
    return _placeholder(context);
  }

  Widget _placeholder(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Icon(
        Icons.photo_library_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
