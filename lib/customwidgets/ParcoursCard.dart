import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/globals.dart';
import 'package:crud_ecole/models/ParcoursFormatted.dart';
import 'package:flutter/material.dart';
import 'package:crud_ecole/customwidgets/CustomFloatingActionButton.dart';
import'package:crud_ecole/pages/Parcours/AjouterParcours.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ParcoursCard extends Card {
  ParcoursCard(
      {super.key,
      required ParcoursFormatted parcours,
      required DataBaseCrud db,
      required BuildContext fContext,
      required Function state})
      : super(
          color: Theme.of(fContext).colorScheme.onPrimary,
          shadowColor: Theme.of(fContext).primaryColorLight,
          elevation: 3.0,
          child: ListTile(
            title: Text(
              parcours.libelle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 295),
                      child: Text(
                        "Effectif: ${parcours.effectif}",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    InkWell(
                      highlightColor: const Color.fromARGB(50, 158, 158, 158),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () { CustomFloatingActionButton.add(fContext,AjouterParcours(modeModifier: true, idParcour: parcours.id,state: state,)); },
                      splashColor: Theme.of(fContext).primaryColorLight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.edit,
                            color: Theme.of(fContext).primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      highlightColor: const Color.fromARGB(50, 158, 158, 158),
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        showDialog(
                          context: fContext,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Suppression de la classe'),
                              content: Text("La suppression d'une classe entraîne la suppresion des élèves qui y sont, Confirmer vous la suppression ?"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Confirmer'),
                                  onPressed: () async{
                                    // Perform the confirmation action here
                                    try{
                                      await db.deleteParcoursById(parcours.id);
                                      globals.showToast(fContext,"Parcour supprimé");
                                    }catch(e){
                                      globals.showToast(fContext,"Parcour supprimé");
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      splashColor: const Color.fromARGB(80, 229, 56, 53),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.delete, color: Colors.red.shade600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

}
