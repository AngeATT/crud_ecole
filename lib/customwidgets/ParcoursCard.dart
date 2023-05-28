import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:flutter/material.dart';
import '../models/Parcours.dart';

class ParcoursCard extends Card {
  ParcoursCard(
      {super.key,
      required Parcours parcours,
      required DataBaseCrud db,
      required BuildContext context})
      : super(
          color: Theme.of(context).colorScheme.onPrimary,
          shadowColor: Theme.of(context).primaryColorLight,
          elevation: 3.0,
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
                            Text("${etudiant.nom} ${etudiant.prenom}"),
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
                            Text(etudiant.dateAnniv),
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
                            Text(etudiant.classe),
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
                      onTap: () {},
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
}
