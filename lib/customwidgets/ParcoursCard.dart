import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/models/ParcoursFormatted.dart';
import 'package:crud_ecole/pages/Parcours/ModifierParcours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crud_ecole/globals.dart' as globals;

class ParcoursCard extends Card {
  ParcoursCard(
      {super.key,
      required ParcoursFormatted parcours,
      required BuildContext context,
      required Function showdeletetoast})
      : super(
          color: Theme.of(context).colorScheme.onPrimary,
          shadowColor: Theme.of(context).primaryColorLight,
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
                      onTap: () {
                        double height = MediaQuery.of(context).size.height;
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40.0))),
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 9, bottom: 5),
                                  child: Center(
                                      child: Container(
                                    width: 70,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )),
                                ),
                                SizedBox(
                                  height:
                                      height * 0.8 <= 600 ? height * 0.8 : 600,
                                  child: ModifierParcours(
                                    chosenPar: parcours.getParcours(),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      splashColor: Theme.of(context).primaryColorLight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.edit,
                            color: Theme.of(context).primaryColor),
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
                            context: context,
                            builder: (BuildContext builder) {
                              int nombre = parcours.effectif;
                              String suite = '';
                              if (nombre != 0) {
                                suite = "et supprimera ";
                                if (nombre == 1) {
                                  suite += "son étudiant(e)";
                                } else {
                                  suite += "ses $nombre étudiants";
                                }
                                suite += " par la même occasion";
                              }
                              return CupertinoAlertDialog(
                                title: const Text("Confirmer?"),
                                content: Text(
                                    "Voulez-vous vraiment supprimer la classe ${parcours.libelle} ? Cette action est irréversible $suite"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "Non",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  CupertinoDialogAction(
                                    child: Text(
                                      "Oui",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      globals.db.deleteParcours(parcours);
                                      String libelle = parcours.libelle;
                                      if (parcours.effectif != 0) {
                                        globals.streamController.add(libelle);
                                      } else {
                                        globals.streamController.add('');
                                      }
                                      showdeletetoast();
                                    },
                                  ),
                                ],
                              );
                            });
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
