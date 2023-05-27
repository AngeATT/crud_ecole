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
            title: Center(child:Text(etudiant.matricule,style: TextStyle(fontSize: 20),)),
            subtitle:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          Icon(
                              size: 20,
                              Icons.person,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 9,
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
                            width: 9,
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
                            width: 10,
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
                            width: 10,
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 60,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete, color: Colors.redAccent.shade700),
                          ),
                        )

                      ],
                    )
                  ],
                )

          ),
        );
}
