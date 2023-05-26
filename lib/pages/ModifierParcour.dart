import 'package:flutter/material.dart';

class ModifierParcour extends StatefulWidget {
  const ModifierParcour({super.key});

  @override
  _ModifierParcourState createState() => _ModifierParcourState();
}

class _ModifierParcourState extends State<ModifierParcour> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'modifier parcour',
          style: TextStyle(fontSize: 24.0),
        ),
    );
  }
}