import 'package:flutter/material.dart';

class AfficherEtudiant extends StatefulWidget {
  @override
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'test afficher Etudiant',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
