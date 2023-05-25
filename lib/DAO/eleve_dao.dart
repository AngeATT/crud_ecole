import 'package:moor_flutter/moor_flutter.dart';

import '../models/eleves.dart';

part 'eleve_dao.g.dart';

@UseDao(tables: [Eleves])
class EleveDAO extends DatabaseAccessor<AppDatabase> with _$EleveDAOMixin {
  final AppDatabase db;

   static EleveDAO eleveDAO = EleveDAO(AppDatabase());

  EleveDAO(this.db) : super(db);

  Future<List<Eleve>> getAllEleves() => select(eleves).get();

  Future insertEleve(Eleve eleve) => into(eleves).insert(eleve);

  Future updateEleve(Eleve eleve) => update(eleves).replace(eleve);

  Future deleteEleve(Eleve eleve) => update(eleves).replace(eleve);

  static EleveDAO getEleveDao(){
     if (eleveDAO == null){
       eleveDAO = EleveDAO(AppDatabase());
     }
      return eleveDAO;
  }
}
