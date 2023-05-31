import 'package:crud_ecole/pages/Etudiant/ModifierEtudiant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/EtudiantFormatted.dart';

class EtudiantCard extends Card {
  EtudiantCard(
      {super.key,
      required EtudiantFormatted etudiant,
      required BuildContext context,
      required final Function state})
      : super(
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
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )),
                                ),
                                SizedBox(
                                  height:
                                      height * 0.8 <= 600 ? height * 0.8 : 600,
                                  child: ModifierEtudiant(
                                    state: state,
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
                      onTap: () {},
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
