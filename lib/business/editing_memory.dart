import 'package:image_picker/image_picker.dart';
import 'package:memories/main.dart';

final editMemoryStateProvider = provider((ref) => EditMemoryState());

class EditMemoryState extends Notifier {
  late final title = signal('');
  late final description = signal('');
  late final mood = signal('');
  late final tags = signal(<String>[]);
  late final id = signal(0);
  late final image = signal<XFile?>(null);
}
