import 'package:moor_flutter/moor_flutter.dart';

part 'eleves.g.dart';

class Eleves extends Table {
  TextColumn get matricule => text()();
  TextColumn get nom => text()();
  TextColumn get prenoms => text()();
  RealColumn get moyMath => real()();
  RealColumn get moyInfo => real()();
  TextColumn get parcours =>
      text().customConstraint('NULL REFERENCES parcours(codeParcours)')();

  @override
  Set<Column> get primaryKey => {matricule};
}

@UseMoor(tables: [Eleves])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'database.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}
