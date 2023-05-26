import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AfficherEtudiant extends StatefulWidget {
  @override
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant> {
  TextEditingController _searchController = TextEditingController();
  DataBaseCrud db = DataBaseCrud.databaseInstance();
  String affiche = 'test afficher Etudiant';
  List<String> eleves = [];

  @override
  int count = 1;

  Widget build(BuildContext context) {
    return GestureDetector(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Text(
              'Liste des étudiants',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const SizedBox(height: 16.0),
                Container(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Nom Etudiant',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      // Effectuez une action lorsque le texte de recherche change
                      // par exemple, filtrez une liste ou effectuez une recherche dans une base de données
                      print(value);
                    },
                  ),
                  width: 350,
                )
              ],
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
                itemCount: count,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(Icons.upgrade),
                      ),
                      title: Text(
                        'Matricule :',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        'Nom :',
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(Icons.delete_forever, color: Colors.grey),
                    ),
                  );
                })
          ],
        ),
      ),
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      }
    );
  }
}
