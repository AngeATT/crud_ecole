import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/models/Eleve.dart';
import 'package:crud_ecole/models/Parcours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AfficherParcours extends StatefulWidget {
  @override
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  DataBaseCrud db = DataBaseCrud.databaseInstance();
  List<Parcours> parcours = [];

  late Ticker ticker;

  Future<List<Parcours>> getParcours() async {
    Future<List<Parcours>> parcoursRecup = db.getParcours();
    parcours = await parcoursRecup;
    return parcoursRecup;
  }

  int count = 1;

  @override
  void initState() {
    // TODO: implement initState
    ticker = createTicker((elapsed) {
      setState(() {
        getParcours();
      });
    });
    ticker.start();
    getParcours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getParcours();
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
              FutureBuilder<Object>(
                future: getParcours(),
                builder: (context, asyncsnapshot) {
                    // While waiting for the data to load, display a loading indicator
                    return ListView.builder(
                        itemCount: parcours.length, //taille de notre tab
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  child: Icon(Icons.upgrade),
                                ),
                                title: Text(
                                  'Libelle : ${parcours[index].libelle}',
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
                                              onPressed: () {
                                                //TODO : renvoyer sur la page de modification d'un parcour
                                              }),
                                          IconButton(
                                            onPressed: () {
                                              db.deleteParcour(parcours[index]);
                                              // Action à effectuer lors du clic sur le bouton
                                              //TODO : appeler supprimer, demander la confirmation, supprimer, envoyer un toast
                                            },
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          );
                        });
                  }
    ,
              )
            ],
          ),
        ),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        });
  }
//paramétrage de la fonction

}
