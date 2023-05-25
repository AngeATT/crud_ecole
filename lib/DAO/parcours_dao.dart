import 'package:moor_flutter/moor_flutter.dart';

import '../models/parcours.dart';

part 'parcours_dao.g.dart';

@UseDao(tables: [Parcours])
class ParcoursDAO extends DatabaseAccessor<AppDatabase>
    with _$ParcoursDAOMixin {
  final AppDatabase db;

  ParcoursDAO(this.db) : super(db);

  Future<List<Parcour>> getAllParcours() => select(parcours).get();

  Future insertParcour(Parcour parcour) => into(parcours).insert(parcour);

  Future updateParcour(Parcour parcour) => update(parcours).replace(parcour);

  Future deleteParcour(Parcour parcour) => delete(parcours).delete(parcour);
}
