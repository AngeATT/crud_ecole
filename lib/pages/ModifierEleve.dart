import 'package:flutter/material.dart';

class ModifierEleve extends StatefulWidget {
  const ModifierEleve({super.key});

  @override
  _ModifierEleveState createState() => _ModifierEleveState();
}

class _ModifierEleveState extends State<ModifierEleve> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'modifier eleve',
          style: TextStyle(fontSize: 24.0),
        ),
    );
  }
}