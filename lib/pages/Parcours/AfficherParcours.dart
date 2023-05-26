import 'package:crud_ecole/models/EtudiantFormatted.dart';
import 'package:flutter/material.dart';

import '../../Db/DataBaseCrud.dart';
import '../../customwidgets/EtudiantCard.dart';
import '../../models/Etudiant.dart';

class AfficherParcours extends StatefulWidget {
  @override
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> {
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
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16.0,
                top: 16.0,
                end: 16.0,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: ListView.builder(
                      itemCount: 56,
                      itemBuilder: (BuildContext context, int position) {
                        return EtudiantCard(
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
                        );
                      }),
                ),
              ),
            )),
      ),
    );
  }
}
