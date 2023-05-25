import 'package:flutter/material.dart';

class SupprimerParcours extends StatefulWidget {
  @override
  _SupprimerParcourState createState() => _SupprimerParcourState();
}

class _SupprimerParcourState extends State<SupprimerParcours> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'supprimer parcours',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
