import 'package:moor_flutter/moor_flutter.dart';

part 'parcours.g.dart';

class Parcours extends Table {
  TextColumn get codeParcours => text()();
  TextColumn get libelleClasse => text()();

  @override
  Set<Column> get primaryKey => {codeParcours};
}

@UseMoor(tables: [Parcours])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'mydatabase.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}
