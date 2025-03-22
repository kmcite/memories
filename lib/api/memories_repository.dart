import 'package:memories/main.dart';
import 'package:memories/models/memory.dart';

class MemoriesRepository with CRUD<Memory> {}

final memoriesRepository = MemoriesRepository();
