import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/customwidgets/EtudiantCard.dart';
import 'package:crud_ecole/models/EtudiantFormatted.dart';

import 'package:flutter/material.dart';

class AfficherEtudiant extends StatefulWidget {
  const AfficherEtudiant({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant> {
  FocusScopeNode focusScopeNode = FocusScopeNode();

  final DataBaseCrud db = DataBaseCrud.databaseInstance();

  List<EtudiantFormatted> etudiants = [];

  Future<List<EtudiantFormatted>> fetchEtudiants() async {
    etudiants = await db.getFormagttedEtudiants();
    setState(() {});
    return etudiants;
  }

  @override
  void initState() {
    super.initState();
    // Assign data within the initState() method
    fetchEtudiants();
  }

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
            child: FutureBuilder<Object>(
                future: fetchEtudiants(),
                builder: (context, snapshot) {
                  if (etudiants.isEmpty) {
                    return const Center(
                      child: Text(
                        'Ajoutez des étudiants pour les voir ici',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: etudiants.length,
                        itemBuilder: (BuildContext context, int position) {
                          EdgeInsetsGeometry bottompadding;
                          if (position == etudiants.length - 1) {
                            bottompadding = const EdgeInsets.only(bottom: 100);
                          } else {
                            bottompadding = EdgeInsets.zero;
                          }
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 16.0, top: 16.0, end: 16.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                padding: bottompadding,
                                constraints:
                                    const BoxConstraints(maxWidth: 450),
                                child: EtudiantCard(
                                  etudiant: EtudiantFormatted(
                                      matricule: etudiants[position].matricule,
                                      nom: etudiants[position].nom,
                                      prenom: etudiants[position].prenom,
                                      dateAnniv: "09-11-2000",
                                      moyMath: etudiants[position].moyMath,
                                      moyInfo: etudiants[position].moyInfo,
                                      classe: etudiants[position].classe),
                                  db: db,
                                  context: context,
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ),
      ),
    );
  }
}
