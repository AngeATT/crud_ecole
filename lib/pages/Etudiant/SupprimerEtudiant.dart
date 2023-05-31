import 'package:flutter/material.dart';

class SupprimerEtudiant extends StatefulWidget {
  const SupprimerEtudiant({super.key});

  @override
  _SupprimerEtudiantState createState() => _SupprimerEtudiantState();
}

class _SupprimerEtudiantState extends State<SupprimerEtudiant> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'supprimer Etudiant',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
