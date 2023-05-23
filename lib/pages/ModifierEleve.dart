import 'package:flutter/material.dart';

class ModifierEleve extends StatefulWidget {
  @override
  _ModifierEleveState createState() => _ModifierEleveState();
}

class _ModifierEleveState extends State<ModifierEleve> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'modifier eleve',
          style: TextStyle(fontSize: 24.0),
        ),
    );
  }
}