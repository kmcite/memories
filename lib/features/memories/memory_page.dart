import 'package:file_picker/file_picker.dart';
import 'package:memories/business/memory_detail.dart';
import 'package:memories/business/navigation.dart';
import 'package:memories/features/memories/dialogs/memory_deletion.dart';
import 'package:memories/main.dart';
import 'package:memories/features/features.dart';
import '../../domain/models/memory.dart';

class MemoryPage extends UI {
  final Memory memory;
  const MemoryPage({super.key, required this.memory});

  bool isFullscreen([bool? value]) {
    if (value != null) {}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final memoryItem = memory;

    return Scaffold(
      appBar: state.memoryDetail.isFullscreen
          ? null
          : AppBar(
              title: Text(
                memoryItem.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              elevation: 2,
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    navigateToDialog(MemoryDeletionDialog(memory));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_rounded),
                  onPressed: () {},
                ),
                SizedBox(width: 8),
              ],
            ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            image(memoryItem),
            Positioned(
              bottom: 24,
              right: 24,
              child: IconButton.filledTonal(
                onPressed: () {
                  // toggleFullscreen();
                },
                icon: const Icon(
                  Icons.fullscreen,
                  size: 30,
                ),
                padding: EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget image(Memory memory) {
    final media = memory.media;
    if (media.isEmpty)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            Text('No images or media here in this memory'),
            ElevatedButton.icon(
              onPressed: imagePicked,
              icon: Icon(Icons.add_photo_alternate),
              label: const Text('Add Image'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    return Hero(
      tag: "${memory.id}",
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Column(
          children: [
            for (var i in media)
              Image.file(
                File(i.path),
                fit: BoxFit.contain,
                errorBuilder: (_, error, ___) {
                  return Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 64, color: Colors.grey),
                      Text('$error'),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> imagePicked() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (picked == null) return;
    final path = picked.files.first.path;
    if (path != null) {
      MemoryMedia media = MemoryMedia(
        path: path,
        note: 'added from details/memorydetail page',
      );
      dispatch(AddImageMediaToMemory(media));
    }
  }
}
