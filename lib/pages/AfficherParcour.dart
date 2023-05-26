import 'package:flutter/material.dart';

class AfficherParcour extends StatefulWidget {
  const AfficherParcour({super.key});

  @override
  _AfficherParcourState createState() => _AfficherParcourState();
}

class _AfficherParcourState extends State<AfficherParcour> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'test affciher parcour',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}