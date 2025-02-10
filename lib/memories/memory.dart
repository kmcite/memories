import 'package:drift/drift.dart';
part 'memory.g.dart';

@DataClassName('Memory')
class Memories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(Constant(""))();
  TextColumn get description => text().withDefault(Constant(""))();
  TextColumn get path => text().withDefault(Constant(""))();
  BoolColumn get isHidden => boolean().withDefault(Constant(false))();
}

@DriftDatabase(tables: [Memories])
class Database extends _$Database {
  Database() : super(_open());
  static QueryExecutor _open() {
    return _open();
  }

  @override
  int get schemaVersion => 1;
}
