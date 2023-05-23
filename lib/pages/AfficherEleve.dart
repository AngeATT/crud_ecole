import 'package:flutter/material.dart';

class AfficherEleve extends StatefulWidget {
  @override
  _AfficherEleveState createState() => _AfficherEleveState();
}

class _AfficherEleveState extends State<AfficherEleve> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'test afficher eleve',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}