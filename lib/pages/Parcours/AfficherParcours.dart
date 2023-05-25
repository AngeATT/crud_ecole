import 'package:flutter/material.dart';

class AfficherParcours extends StatefulWidget {
  @override
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'test afficher Parcours',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
