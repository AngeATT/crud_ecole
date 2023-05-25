
import 'package:crud_ecole/models/eleves.dart';
import 'package:flutter/material.dart';

class AjouterParcours extends StatefulWidget {
  @override
  _AfficherEleveState createState() => _AfficherEleveState();
}

class _AfficherEleveState extends State<AjouterParcours> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ajouter parcour',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}