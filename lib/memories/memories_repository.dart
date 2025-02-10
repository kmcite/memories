import 'package:memories/main.dart';
import 'package:memories/memories/memory.dart';

class MemoriesRepository with CRUD<Memory> {}

final memoriesRepository = MemoriesRepository();
