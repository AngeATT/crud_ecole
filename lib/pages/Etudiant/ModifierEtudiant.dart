import 'package:flutter/material.dart';

class ModifierEtudiant extends StatefulWidget {
  const ModifierEtudiant({super.key});

  @override
  _ModifierEtudiantState createState() => _ModifierEtudiantState();
}

class _ModifierEtudiantState extends State<ModifierEtudiant> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'modifier Etudiant',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
