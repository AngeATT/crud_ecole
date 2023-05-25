import 'package:flutter/material.dart';

class SupprimerParcours extends StatefulWidget {
  @override
  _SupprimerParcoursState createState() => _SupprimerParcoursState();
}

class _SupprimerParcoursState extends State<SupprimerParcours> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'supprimer parcour',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}