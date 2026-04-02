// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:memories/business/editing_memory.dart';
// import 'package:memories/business/navigation.dart';
// import 'package:memories/domain/models/memory.dart';
// import 'package:memories/main.dart';

// class EditMemoryPage extends StatefulWidget {
//   final Memory memory;

//   EditMemoryPage({required this.memory});

//   @override
//   _EditMemoryPageState createState() => _EditMemoryPageState();
// }

// class _EditMemoryPageState extends State<EditMemoryPage> {
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//   // ignore: unused_field
//   String _mood = '';
//   List<String> _tags = [];
//   File? _imageFile;

//   @override
//   void initState() {
//     super.initState();
//     _titleController.text = widget.memory.title;
//     _descController.text = widget.memory.description;
//     _mood = widget.memory.mood;
//     _tags = widget.memory.tags.map((e) => e.value).toList();
//     if (widget.memory.media.isNotEmpty) {
//       _imageFile = File(widget.memory.media.first.path);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             title: Text('Edit Memory'),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   context.read<Navigation>().add(NavigateBack());
//                 },
//                 icon: Icon(Icons.close),
//               ),
//               IconButton(
//                 onPressed: () {
//                   context.read<EditMemoryReducer>().save();
//                   context.read<Navigation>().add(NavigateBack());
//                 },
//                 icon: Icon(Icons.save),
//               ),
//               SizedBox(width: 8),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     initialValue: context
//                         .watch<EditMemoryReducer>()
//                         .state
//                         .title,
//                     onChanged: context.read<EditMemoryReducer>().title,
//                     decoration: InputDecoration(labelText: 'Title'),
//                   ),
//                   TextFormField(
//                     initialValue: context
//                         .watch<EditMemoryReducer>()
//                         .state
//                         .description,
//                     onChanged: context.read<EditMemoryReducer>().description,
//                     decoration: InputDecoration(labelText: 'Description'),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Mood'),
//                     initialValue: context.watch<EditMemoryReducer>().state.mood,
//                     onChanged: context.read<EditMemoryReducer>().mood,
//                   ),
//                   Wrap(
//                     children: _tags
//                         .map((tag) => Chip(label: Text(tag)))
//                         .toList(),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(labelText: 'Add Tags'),
//                     onSubmitted: (value) {
//                       context.read<EditMemoryReducer>().tags(
//                         [
//                           ...context.read<EditMemoryReducer>().state.tags,
//                           value,
//                         ],
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.add_a_photo),
//                     onPressed: () {
//                       context.read<EditMemoryReducer>().pick();
//                     },
//                   ),
//                   if (_imageFile != null) Image.file(File(_imageFile!.path)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
