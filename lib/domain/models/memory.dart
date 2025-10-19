import 'package:objectbox/objectbox.dart';

@Entity()
class Memory {
  @Id()
  int id;

  String title;
  String description;
  DateTime createdAt;
  String mood; // emoji or text
  String location;
  bool isPrivate;
  bool isPinned;

  final media = ToMany<MemoryMedia>();
  final tags = ToMany<MemoryTag>();

  Memory({
    this.id = 0,
    this.title = '',
    this.description = '',
    DateTime? createdAt,
    this.mood = '😡',
    this.location = '',
    this.isPrivate = false,
    this.isPinned = false,
  }) : createdAt = createdAt ?? DateTime.now();
}

@Entity()
class MemoryMedia {
  @Id()
  int id;

  String path;
  String type;
  // 'image', 'video', 'audio'
  String? note;

  MemoryMedia({
    this.id = 0,
    this.path = '',
    this.type = 'image',
    this.note,
  });
}

@Entity()
class MemoryTag {
  @Id()
  int id;

  String value;

  MemoryTag({this.id = 0, this.value = ''});
}
