import 'package:crud_ecole/StreamMessage.dart';
import 'package:crud_ecole/models/ParcoursFormatted.dart';
import 'package:crud_ecole/pages/Etudiant/ModifierEtudiant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:crud_ecole/models/EtudiantFormatted.dart';
import 'package:crud_ecole/globals.dart' as globals;

class EtudiantCard extends Card {
  EtudiantCard({
    super.key,
    required EtudiantFormatted etudiant,
    required BuildContext context,
  }) : super(
          color: Theme.of(context).colorScheme.onPrimary,
          shadowColor: Theme.of(context).primaryColorLight,
          elevation: 5.0,
          child: ListTile(
            title: Text(
              etudiant.matricule,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                                size: 20,
                                Icons.person,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 7,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 295),
                              child: Text(
                                "${etudiant.nom} ${etudiant.prenom}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                                size: 20,
                                Icons.cake,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(etudiant.dateAnniv))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                                size: 20,
                                Icons.school,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 7,
                            ),
                            Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 295),
                                child: Text(etudiant.classe)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                                size: 20,
                                Icons.my_library_books_sharp,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(etudiant.moyMath.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                                size: 20,
                                Icons.computer,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(etudiant.moyInfo.toString()),
                          ],
                        ),
                      ]),
                ),
                Column(
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
                                  child: ModifierEtudiant(
                                    chosenEt: etudiant.getEtudiant(),
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
                              return CupertinoAlertDialog(
                                title: const Text("Confirmer?"),
                                content: Text(
                                    "Voulez-vous vraiment supprimer l'étudiant matriculé ${etudiant.matricule} ? Cette action est irréversible"),
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
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      ParcoursFormatted classe = await globals
                                          .db
                                          .getOneFormattedParcours(
                                              etudiant.classeId);
                                      globals.db
                                          .deleteEtudiant(etudiant.matricule);

                                      String libelle = classe.libelle;

                                      if (classe.effectif == 1) {
                                        globals.streamController.add(
                                            StreamMessage(
                                                from: libelle, to: ''));
                                      } else {
                                        globals.streamController.add(
                                            const StreamMessage(
                                                from: '', to: ''));
                                      }
                                      final fToast = FToast();
                                      // ignore: use_build_context_synchronously
                                      fToast.init(context);
                                      fToast.showToast(
                                        gravity: ToastGravity.TOP,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            // ignore: use_build_context_synchronously
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
                                                "Etudiant supprimé",
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
  void update() {}
}
