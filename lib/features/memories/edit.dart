import 'package:memories/domain/models/memory.dart';
import 'package:memories/main.dart';
import 'package:memories/utils/navigator.dart';

class EditMemoryPage extends StatefulWidget {
  final Memory memory;

  EditMemoryPage({required this.memory});

  @override
  _EditMemoryPageState createState() => _EditMemoryPageState();
}

class _EditMemoryPageState extends State<EditMemoryPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  // ignore: unused_field
  String _mood = '';
  List<String> _tags = [];
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.memory.title;
    _descController.text = widget.memory.description;
    _mood = widget.memory.mood;
    _tags = widget.memory.tags.map((e) => e.value).toList();
    if (widget.memory.media.isNotEmpty) {
      _imageFile = File(widget.memory.media.first.path);
    }
  }

  void _pickImage() async {
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // setState(() {
    //   _imageFile = pickedFile;
    // });
  }

  void _saveMemory() {
    // var updatedMemory = widget.memory.copyWith(
    //   title: _titleController.text,
    //   description: _descController.text,
    //   mood: _mood,
    // );

    // widget.memoryRepo.put(updatedMemory);
    navigator.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Memory'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mood'),
              onChanged: (value) {
                setState(() => _mood = value);
              },
            ),
            Wrap(
              children: _tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Add Tags'),
              onSubmitted: (value) {
                setState(() {
                  _tags.add(value);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: _pickImage,
            ),
            if (_imageFile != null) Image.file(File(_imageFile!.path)),
            Spacer(),
            ElevatedButton(
              onPressed: _saveMemory,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
