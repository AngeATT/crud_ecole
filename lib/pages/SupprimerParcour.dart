import 'package:flutter/material.dart';

class SupprimerParcour extends StatefulWidget {
  const SupprimerParcour({super.key});

  @override
  _SupprimerParcourState createState() => _SupprimerParcourState();
}

class _SupprimerParcourState extends State<SupprimerParcour> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'supprimer parcour',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}