import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/models/ParcoursFormatted.dart';
import 'package:flutter/material.dart';

class ParcoursCard extends Card {
  ParcoursCard(
      {super.key,
      required ParcoursFormatted parcours,
      required DataBaseCrud db,
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
