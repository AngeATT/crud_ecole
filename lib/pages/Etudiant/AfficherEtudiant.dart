import 'package:flutter/material.dart';

class AfficherEtudiant extends StatefulWidget {
  @override
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant> {
  @override
  int count = 4;
  Widget build(BuildContext context) {
    return Scaffold(
      body: getAfficherParcourView(), // fonction permettant d'afficher la liste de tout les parcours dans le body
    );
  }
  //paramétrage de la fonction

  getAfficherParcourView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.upgrade),
            ),
            title: Text(
              'Matricule :',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              'Nom :',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.delete_forever, color: Colors.grey),
          ),
        );
      },
    );
  }

}
