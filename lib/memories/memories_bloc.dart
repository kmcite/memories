import 'package:memories/main.dart';
import 'package:memories/memories/memory.dart';

final memoriesRM = Collection(
  'memories',
  fromJson: Memory.fromJson,
  toJson: (entity) => entity.toJson(),
);
