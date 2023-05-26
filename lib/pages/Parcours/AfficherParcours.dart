import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:flutter/material.dart';

class AfficherParcours extends StatefulWidget {
  @override
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> {
  TextEditingController _searchController = TextEditingController();
  DataBaseCrud db = DataBaseCrud.databaseInstance();
  String affiche = 'test afficher Etudiant';
  List<String> eleves = [];
  int count = 1;

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Text(
                'Liste des Classes',
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
                        labelText: 'Libelle Classe',
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
                          'Libelle :',
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Container(
                            height: 50,
                            width: 112,
                            child: ButtonBar(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                          //TODO : renvoyer sur la page de modification d'un parcour
                                        },
                                        color: Colors.limeAccent,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Action à effectuer lors du clic sur le bouton
                                          //TODO : appeler supprimer, demander la confirmation, supprimer, envoyer un toast
                                        },
                                        icon: Icon(
                                            Icons.delete
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
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
  //paramétrage de la fonction

}
