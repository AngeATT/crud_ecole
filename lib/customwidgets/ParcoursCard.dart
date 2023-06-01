import 'package:crud_ecole/StreamMessage.dart';
import 'package:crud_ecole/models/ParcoursFormatted.dart';
import 'package:crud_ecole/pages/Parcours/ModifierParcours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crud_ecole/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';

class ParcoursCard extends Card {
  ParcoursCard(
      {super.key,
      required ParcoursFormatted parcours,
      required BuildContext context})
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
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
                                        globals.streamController.add(
                                            StreamMessage(
                                                from: libelle, to: ''));
                                      } else {
                                        globals.streamController.add(
                                            const StreamMessage(
                                                from: '', to: ''));
                                      }

                                      final fToast = FToast();
                                      fToast.init(context);
                                      fToast.showToast(
                                        gravity: ToastGravity.TOP,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.check,
                                                  color: Colors.black87),
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                "Classe supprimée",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        toastDuration:
                                            const Duration(seconds: 2),
                                      );
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
