// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:memories/domain/models/memory.dart';
// import 'package:memories/features/memories/edit.dart';

// class ViewMemoryPage extends StatelessWidget {
//   final Memory memory;

//   ViewMemoryPage({required this.memory});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Memory Details'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EditMemoryPage(memory: memory),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Title: ${memory.title}', style: TextStyle(fontSize: 24)),
//             SizedBox(height: 8),
//             Text('Description: ${memory.description}'),
//             SizedBox(height: 8),
//             Text('Date: ${DateFormat.yMMMd().format(memory.createdAt)}'),
//             SizedBox(height: 8),
//             Text('Mood: ${memory.mood}'),
//             SizedBox(height: 8),
//             Text('Tags: ${memory.tags.map((e) => e.value).join(', ')}'),
//             SizedBox(height: 16),
//             if (memory.media.isNotEmpty)
//               Image.file(File(memory.media.first.path)),
//           ],
//         ),
//       ),
//     );
//   }
// }
