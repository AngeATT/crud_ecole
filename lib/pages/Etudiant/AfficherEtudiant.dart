import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AfficherEtudiant extends StatefulWidget {
  @override
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant> {
  DataBaseCrud db = DataBaseCrud.databaseInstance();
  String affiche = 'test afficher Etudiant';
  List<String> eleves = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          affiche,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            db.getEleves().then(
                    (value) => value.getRange(0, value.length).forEach((element) {eleves.add(element.nom);})
            );
            for (String eleve in eleves){
              affiche += eleve + ' ';
            }
          });
        },
      ),
    );
  }
}
