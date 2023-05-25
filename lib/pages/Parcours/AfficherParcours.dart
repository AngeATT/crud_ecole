import 'package:flutter/material.dart';

class AfficherParcours extends StatefulWidget {
  @override
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getAfficherParcourView(), // fonction permettant d'afficher la liste de tout les parcours dans le body
    );
  }
  //paramétrage de la fonction

  getAfficherParcourView() {
    return
      ListView.builder(
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
              'Code Classe :',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              'Libellé Classe :',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.delete_forever, color: Colors.grey),
          ),
        );
      },
    );
  }

}
