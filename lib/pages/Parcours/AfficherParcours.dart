import 'package:flutter/material.dart';

class AfficherParcours extends StatefulWidget {
  const AfficherParcours({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'test afficher Parcours',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
