import 'package:crud_ecole/Db/DataBaseCrud.dart';

import '../../models/EtudiantFormatted.dart';
import 'package:flutter/material.dart';
import '../../customwidgets/EtudiantCard.dart';

class AfficherEtudiant extends StatefulWidget {
  const AfficherEtudiant({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant> {
  FocusScopeNode focusScopeNode = FocusScopeNode();

  final DataBaseCrud mydb = DataBaseCrud.databaseInstance();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          focusScopeNode.unfocus();
        },
        child: FocusScope(
          node: focusScopeNode,
          child: Container(
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: 56,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 16.0, top: 16.0, end: 16.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 450),
                        child: EtudiantCard(
                          etudiant: EtudiantFormatted(
                              matricule: "matricule",
                              nom: "nom",
                              prenom: "prenom",
                              dateAnniv: "09-11-2000",
                              moyMath: 12,
                              moyInfo: 20,
                              classe: "classe"),
                          db: mydb,
                          context: context,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
