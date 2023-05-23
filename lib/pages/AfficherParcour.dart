import 'package:flutter/material.dart';

class AfficherParcour extends StatefulWidget {
  @override
  _AfficherParcourState createState() => _AfficherParcourState();
}

class _AfficherParcourState extends State<AfficherParcour> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'test affciher parcour',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}