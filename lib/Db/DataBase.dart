import 'package:crud_ecole/models/Eleve.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Parcours.dart';

class DataBase{
  static DataBase uniqueDB = DataBase();
  static final String ETUDIANT_TABLE_NAME = "etudiant";
  static final String ETUDIANT_COLUMN_MAT = "matricule";
  static final String ETUDIANT_COLUMN_NOM = "nom";
  static final String ETUDIANT_COLUMN_PRENOM = "prenom";
  static final String ETUDIANT_COLUMN_ANNIV = "dateAnniversaire";
  static final String ETUDIANT_COLUMN_CLASSE_ID = "classeid";
  static final String ETUDIANT_COLUMN_MATH = "math";
  static final String ETUDIANT_COLUMN_INFO = "info";
  static final String PARCOURS_TABLE_NAME = "parcour";
  static final String CLASSE_COLUMN_CODE = "id";
  static final String CLASSE_COLUMN_LIBELLE = "libelle";

  String queryetudiant = "CREATE TABLE " + ETUDIANT_TABLE_NAME +
      " (" + ETUDIANT_COLUMN_MAT + " TEXT PRIMARY KEY, " +
      ETUDIANT_COLUMN_NOM + " TEXT NOT NULL, " +
      ETUDIANT_COLUMN_PRENOM + " TEXT NOT NULL, " +
      ETUDIANT_COLUMN_ANNIV + " TEXT NOT NULL, " +
      ETUDIANT_COLUMN_CLASSE_ID + " INTEGER, " +
      ETUDIANT_COLUMN_MATH + " REAL NOT NULL, " +
      ETUDIANT_COLUMN_INFO + " REAL NOT NULL, " +
      "FOREIGN KEY (" + ETUDIANT_COLUMN_CLASSE_ID + ") REFERENCES " +
      PARCOURS_TABLE_NAME + "(" + CLASSE_COLUMN_CODE + "), " +
      "CONSTRAINT CHK_Notes CHECK (" + ETUDIANT_COLUMN_MATH + " >= 0 AND " +
      ETUDIANT_COLUMN_MATH + " <= 20 AND " + ETUDIANT_COLUMN_INFO + " >= 0 AND " +
      ETUDIANT_COLUMN_INFO + " <= 20), " +
      "CONSTRAINT CHK_Nom CHECK (length(" + ETUDIANT_COLUMN_NOM + ") > 0), " +
      "CONSTRAINT CHK_Prenom CHECK (length(" + ETUDIANT_COLUMN_PRENOM + ") > 0), " +
      "CONSTRAINT CHK_Mat CHECK (length(" + ETUDIANT_COLUMN_MAT + ") > 0))";
  String queryparcours = "CREATE TABLE " + PARCOURS_TABLE_NAME +
      " (" + CLASSE_COLUMN_CODE + " INTEGER PRIMARY KEY, " +
      CLASSE_COLUMN_LIBELLE + " TEXT NOT NULL UNIQUE CHECK (length(" + CLASSE_COLUMN_LIBELLE + ") > 0), " +
      "CHECK (" + CLASSE_COLUMN_CODE + " > 0 ))";

  static DataBase databaseInstance(){
    if (uniqueDB == null ){
      uniqueDB = DataBase();
    }
    return uniqueDB;
  }
  Future<Database> initializedDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'databaseCrud.db'),
      onCreate: (db, version) {
        db.execute(queryetudiant);
        db.execute(queryparcours);
      },
      version: 1,
    );
  }

  Future<void> insertEleve (Eleve eleve) async{
    final db = await initializedDB();
    await db.insert(ETUDIANT_TABLE_NAME, eleve.toMap(), conflictAlgorithm: ConflictAlgorithm.abort);
  }
  Future<void> insertParcour (Eleve eleve) async{
    final db = await initializedDB();
    await db.insert(PARCOURS_TABLE_NAME, eleve.toMap(), conflictAlgorithm: ConflictAlgorithm.abort);
  }
  Future<List<Eleve>> getEleves () async{
    final db = await initializedDB();
    final List<Map<String,dynamic>> maps = await db.query(ETUDIANT_TABLE_NAME);
    return List.generate(maps.length, (i){
       return Eleve(
        matricule: maps[i]['matricule'],
        nom: maps[i]['nom'],
         prenom: maps[i]['prenom'],
         dateAnniv: maps[i]['dateAnniv'],
         moyMath: maps[i]['moyMath'],
         moyInfo: maps[i]['moyInfo'],
         parcour: maps[i]['parcour'],
    );
    });
  }
  Future<List<Eleve>> getParcours () async{
    final db = await initializedDB();
    final List<Map<String,dynamic>> maps = await db.query(ETUDIANT_TABLE_NAME);
    return List.generate(maps.length, (i){
      return Eleve(
        matricule: maps[i]['matricule'],
        nom: maps[i]['nom'],
        prenom: maps[i]['prenom'],
        dateAnniv: maps[i]['dateAnniv'],
        moyMath: maps[i]['moyMath'],
        moyInfo: maps[i]['moyInfo'],
        parcour: maps[i]['parcour'],
        //classeID : maps[i]['classeId']
      );
    });
  }
  Future<List<Parcours>> getParcour () async{
    final db = await initializedDB();
    final List<Map<String,dynamic>> maps = await db.query(PARCOURS_TABLE_NAME);
    return List.generate(maps.length, (i){
      return Parcours(id: maps[i]['id'], libelleParcour: maps[i]['libelleParcour']);
  });
  }

  Future<void> updateEleve(Eleve eleve) async{
    final db = await initializedDB();
    await db.update(ETUDIANT_TABLE_NAME,
      eleve.toMap(),
    where: 'matricule = ?',
    whereArgs: [eleve.matricule]
    );
  }
  Future<void> update(Parcours parcours) async{
    final db = await initializedDB();
    await db.update(PARCOURS_TABLE_NAME,
        parcours.toMap(),
        where: 'id = ?',
        whereArgs: [parcours.id]
    );
  }
  Future<void> deleteEleve(Eleve eleve ) async {
    final db = await initializedDB();
    await db.delete(ETUDIANT_TABLE_NAME,
    where: 'matricule = ?',
    whereArgs: [eleve.matricule]
    );
  }
  Future<void> deleteParcour(Parcours parcours ) async {
    final db = await initializedDB();
    await db.delete(PARCOURS_TABLE_NAME,
        where: 'id = ?',
        whereArgs: [parcours.id]
    );
  }
}