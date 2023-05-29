import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/models/Parcours.dart';
import 'package:crud_ecole/pages/Parcours/AjouterParcours.dart';
import 'package:crud_ecole/pages/Parcours/ModifierParcours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:crud_ecole/customwidgets/CustomFloatingActionButton.dart';

class AfficherParcours extends StatefulWidget {
  const AfficherParcours({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  DataBaseCrud db = DataBaseCrud.databaseInstance();
  late List<Parcours> parcours;
  Map<Parcours,int> effectifs = new Map();
  String s = '';

  late Ticker ticker;

  Future<List<Parcours>> getParcours(String s) async {
    parcours =  await db.getParcoursWithPattern(s);
    for (Parcours parcour in parcours){
      int effectif = await getEffectifs(parcour);
      effectifs.putIfAbsent(parcour, ()  => effectif);
    }
    setState(() {});
    return parcours;
  }
  Future<int> getEffectifs(Parcours parcour) async {
     return await db.getEffectifs(parcour);
  }
  int count = 1;

  @override
  void initState() {
    // TODO: implement initState
    getParcours(s);
    super.initState();
  }

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
                            getParcours('');
                            _searchController.clear();
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          s = value;
                        });
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
              ListView(
                padding: const EdgeInsetsDirectional.all(2),
                shrinkWrap: true,
                children: [
                  FutureBuilder<Object>(
                    future: getParcours(s),
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
                                    child: Icon(Icons.school),
                                  ),
                                  title: Text(
                                    'Classe : ${parcours[index].libelle}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    'Effectif enregistré : ${effectifs[parcours[index]]}'
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
                                                  CustomFloatingActionButton.add(context, AjouterParcours(modeModifier: true, idParcour: parcours[index].id));
                                                  //TODO : renvoyer sur la page de modification d'un parcour
                                                }),
                                            IconButton(
                                              onPressed: () {
                                                db.deleteParcours(parcours[index]);
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
