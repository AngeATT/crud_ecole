import 'package:flutter/material.dart';

class SupprimerEleve extends StatefulWidget {
  const SupprimerEleve({super.key});

  @override
  _SupprimerEleveState createState() => _SupprimerEleveState();
}

class _SupprimerEleveState extends State<SupprimerEleve> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'supprimer eleve',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}