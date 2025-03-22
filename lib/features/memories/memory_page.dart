import 'package:file_picker/file_picker.dart';
import 'package:memories/main.dart';
import '../../models/memory.dart';

class MemoryPage extends UI {
  final Memory memory;
  const MemoryPage({super.key, required this.memory});

  static final isFullscreenRM = RM.inject(() => false);

  bool isFullscreen([bool? _]) {
    if (_ != null) {
      isFullscreenRM.state = _;
    }
    return isFullscreenRM.state;
  }

  @override
  Widget build(BuildContext context) {
    final memoryItem = memory;

    return Scaffold(
      appBar: isFullscreen()
          ? null
          : AppBar(
              title: Text(
                memoryItem.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              elevation: 2,
              backgroundColor: Colors.blueGrey[800],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: image(memoryItem),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: toggleFullscreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget image(Memory memory) {
    return Hero(
      tag: "${memory.id}",
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Image.file(
          File(memory.path),
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => errorDisplay,
        ),
      ),
    ).pad();
  }

  Widget get errorDisplay {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No Image',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 24),
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
  }

  Future<void> imagePicked() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (picked == null) return;
    final path = picked.files.first.path;
    if (path != null) {
      // memoriesRM.put(memory..path = path);
    }
  }

  Widget toggleFullscreen() {
    return IconButton(
      onPressed: () => isFullscreen(!isFullscreen()),
      icon: const Icon(
        Icons.fullscreen,
        size: 30,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(12),
    );
  }
}
