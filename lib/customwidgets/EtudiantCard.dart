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
            color: Theme.of(context).colorScheme.onSecondary,
            elevation: 2.0,
            child: ListTile(
              title: Text(etudiant.matricule),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(size: 20, Icons.person),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("${etudiant.nom} ${etudiant.prenom}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(size: 20, Icons.cake),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(etudiant.dateAnniv),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(size: 20, Icons.school),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(etudiant.classe),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(size: 20, Icons.numbers),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(etudiant.moyMath.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(size: 20, Icons.computer),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(etudiant.moyInfo.toString()),
                      ],
                    ),
                  ]),
            ));
}
