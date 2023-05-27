import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:flutter/material.dart';

import '../models/EtudiantFormatted.dart';

class EtudiantCard extends Card {
  EtudiantCard(
      {super.key,
      required EtudiantFormatted etudiant,
      required DataBaseCrud db,
      required BuildContext context})
      : super(
          color: Theme.of(context).colorScheme.onPrimary,
          shadowColor: Theme.of(context).primaryColorLight,
          elevation: 3.0,
          child: ListTile(
            title: Text(etudiant.matricule),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            trailing: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.redAccent.shade700),
                ),
              ],
            ),
          ),
        );
}
