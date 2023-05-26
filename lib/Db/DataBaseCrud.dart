import 'package:crud_ecole/models/Etudiant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Parcours.dart';

class DataBaseCrud {
  Database? db;
  static DataBaseCrud _uniqueDB = DataBaseCrud();

  static final String ETUDIANT_TABLE_NAME = "etudiant";
  static final String ETUDIANT_COLUMN_MAT = "matricule";
  static final String ETUDIANT_COLUMN_NOM = "nom";
  static final String ETUDIANT_COLUMN_PRENOM = "prenom";
  static final String ETUDIANT_COLUMN_ANNIV = "dateAnniv";
  static final String ETUDIANT_COLUMN_CLASSE_ID = "classeId";
  static final String ETUDIANT_COLUMN_MATH = "moyMath";
  static final String ETUDIANT_COLUMN_INFO = "moyInfo";

  static final String PARCOURS_TABLE_NAME = "parcours";
  static final String CLASSE_COLUMN_CODE = "id";
  static final String CLASSE_COLUMN_LIBELLE = "libelle";

  final String queryetudiant = "CREATE TABLE $ETUDIANT_TABLE_NAME " +
      "($ETUDIANT_COLUMN_MAT TEXT PRIMARY KEY, " +
      "$ETUDIANT_COLUMN_NOM TEXT NOT NULL, " +
      "$ETUDIANT_COLUMN_PRENOM TEXT NOT NULL, " +
      "$ETUDIANT_COLUMN_ANNIV DATE NOT NULL, " +
      "$ETUDIANT_COLUMN_CLASSE_ID INTEGER, " +
      "$ETUDIANT_COLUMN_MATH REAL NOT NULL, " +
      "$ETUDIANT_COLUMN_INFO REAL NOT NULL, " +
      "FOREIGN KEY ($ETUDIANT_COLUMN_CLASSE_ID) REFERENCES " +
      "$PARCOURS_TABLE_NAME($CLASSE_COLUMN_CODE), " +
      "CONSTRAINT CHK_Notes CHECK ($ETUDIANT_COLUMN_MATH >= 0 AND " +
      "$ETUDIANT_COLUMN_MATH <= 20 AND $ETUDIANT_COLUMN_INFO >= 0 AND " +
      "$ETUDIANT_COLUMN_INFO <= 20), " +
      "CONSTRAINT CHK_Nom CHECK (length($ETUDIANT_COLUMN_NOM) > 0), " +
      "CONSTRAINT CHK_Prenom CHECK (length($ETUDIANT_COLUMN_PRENOM) > 0), " +
      "CONSTRAINT CHK_Mat CHECK (length($ETUDIANT_COLUMN_MAT) > 0))";

  final String queryparcours = "CREATE TABLE $PARCOURS_TABLE_NAME " +
      "($CLASSE_COLUMN_CODE INTEGER PRIMARY KEY AUTOINCREMENT, " +
      "$CLASSE_COLUMN_LIBELLE TEXT NOT NULL UNIQUE " +
      "CHECK (length($CLASSE_COLUMN_LIBELLE) > 0))";

  static DataBaseCrud databaseInstance() {
    return _uniqueDB;
  }

  Future initializedDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'databaseCrud.db'),
      onCreate: (db, version) async {
        await db.execute(queryetudiant);
        await db.execute(queryparcours);
      },
      version: 1,
    );
  }

  Future<void> insertEtudiant(Etudiant etudiant) async {
    if (db == null) {
      initializedDB();
    }
    await db!.insert(ETUDIANT_TABLE_NAME, etudiant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<void> insertParcours(Parcours parcours) async {
    if (db == null) {
      initializedDB();
    }
    await db!.insert(PARCOURS_TABLE_NAME, parcours.toLibelleMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<List<Etudiant>> getEtudiants() async {
    if (db == null) {
      initializedDB();
    }
    final List<Map<String, dynamic>>? maps =
        await db?.query(ETUDIANT_TABLE_NAME);
    if (maps != null) {
      return List.generate(maps.length, (i) {
        return Etudiant(
          matricule: maps[i][ETUDIANT_COLUMN_MAT],
          nom: maps[i][ETUDIANT_COLUMN_NOM],
          prenom: maps[i][ETUDIANT_COLUMN_PRENOM],
          dateAnniv: maps[i][ETUDIANT_COLUMN_ANNIV],
          moyMath: maps[i][ETUDIANT_COLUMN_MATH],
          moyInfo: maps[i][ETUDIANT_COLUMN_INFO],
          classeId: maps[i][ETUDIANT_COLUMN_CLASSE_ID],
        );
      });
    } else {
      return [];
    }
  }

  Future<List<String>> getEtudiantsMat() async {
    if (db == null) {
      initializedDB();
    }
    final List<Map<String, dynamic>>? maps =
        await db?.query(ETUDIANT_TABLE_NAME, columns: [ETUDIANT_COLUMN_MAT]);
    if (maps != null) {
      return List.generate(maps.length, (i) {
        return maps[i][ETUDIANT_COLUMN_MAT];
      });
    } else {
      return [];
    }
  }

  Future<List<Parcours>> getParcoursWithPattern(String s) async{
    if (db == null) {
      initializedDB();
    }
    final List<Map<String, dynamic>>? maps =  await db?.rawQuery(
        "Select * from "+ PARCOURS_TABLE_NAME + " where " +CLASSE_COLUMN_LIBELLE+" LIKE '%"+s+"%';"
    );
    if (maps != null) {
      return List.generate(maps.length, (i) {
        return Parcours(
            id: maps[i]['id'], libelle: maps[i][CLASSE_COLUMN_LIBELLE]);
      });
    } else {
      return [];
    };
  }

  Future<List<Parcours>> getParcours() async {
    if (db == null) {
      initializedDB();
    }
    final List<Map<String, dynamic>>? maps =
        await db?.query(PARCOURS_TABLE_NAME);
    if (maps != null) {
      return List.generate(maps.length, (i) {
        return Parcours(
            id: maps[i]['id'], libelle: maps[i][CLASSE_COLUMN_LIBELLE]);
      });
    } else {
      return [];
    }
  }

  Future<List<String>> getParcoursLibelle() async {
    if (db == null) {
      initializedDB();
    }
    final List<Map<String, dynamic>>? maps =
        await db?.query(PARCOURS_TABLE_NAME, columns: [CLASSE_COLUMN_LIBELLE]);
    if (maps != null) {
      return List.generate(maps.length, (i) {
        return maps[i][CLASSE_COLUMN_LIBELLE];
      });
    } else {
      return [];
    }
  }

  Future<void> updateEtudiant(Etudiant etudiant) async {
    if (db == null) {
      initializedDB();
    }
    await db!.update(ETUDIANT_TABLE_NAME, etudiant.toMap(),
        where: 'matricule = ?', whereArgs: [etudiant.matricule]);
  }

  Future<void> updateParcours(Parcours parcours) async {
    if (db == null) {
      initializedDB();
    }
    await db!.update(PARCOURS_TABLE_NAME, parcours.toMap(),
        where: 'id = ?', whereArgs: [parcours.id]);
  }

  Future<void> deleteEtudiant(Etudiant etudiant) async {
    if (db == null) {
      initializedDB();
    }
    await db!.delete(ETUDIANT_TABLE_NAME,
        where: 'matricule = ?', whereArgs: [etudiant.matricule]);
  }

  Future<void> deleteParcour(Parcours parcours) async {
    if (db == null) {
      initializedDB();
    }
    await db!
        .delete(PARCOURS_TABLE_NAME, where: 'id = ?', whereArgs: [parcours.id]);
  }
}
