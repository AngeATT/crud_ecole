import 'package:flutter/material.dart';

class SupprimerParcour extends StatefulWidget {
  @override
  _SupprimerParcourState createState() => _SupprimerParcourState();
}

class _SupprimerParcourState extends State<SupprimerParcour> {

List<String> _items = [
  'Élément 1',
  'Élément 2',
  'Élément 3',
  'Élément 4',
  'Élément 5',
];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownButton<String>(
        hint: Text('Sélectionnez'),
    items: _items.map((String item) {
    return DropdownMenuItem<String>(
    value: item,
    child: Text(item),
    );
    }).toList(),
    onChanged: (String? value) {
    }));
  }
}