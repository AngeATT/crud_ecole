import 'package:moor_flutter/moor_flutter.dart';

import '../models/eleves.dart';

part 'eleve_dao.g.dart';

@UseDao(tables: [Eleves])
class EleveDAO extends DatabaseAccessor<AppDatabase> with _$EleveDAOMixin {
  final AppDatabase db;

  EleveDAO(this.db) : super(db);

  Future<List<Eleve>> getAllEleves() => select(eleves).get();

  Future insertEleve(Eleve eleve) => into(eleves).insert(eleve);

  Future updateEleve(Eleve eleve) => update(eleves).replace(eleve);

  Future deleteEleve(Eleve eleve) => update(eleves).replace(eleve);
}
