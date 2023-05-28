import 'package:flutter/material.dart';

class ModifierParcours extends StatefulWidget {
  const ModifierParcours({super.key});

  @override
  _ModifierParcourState createState() => _ModifierParcourState();
}

class _ModifierParcourState extends State<ModifierParcours> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'modifier parcours',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
