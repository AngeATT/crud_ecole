
import 'package:crud_ecole/models/eleves.dart';
import 'package:flutter/material.dart';
import '../DAO/eleve_dao.dart';

class AfficherEleve extends StatefulWidget {
  @override
  _AfficherEleveState createState() => _AfficherEleveState();
}

class _AfficherEleveState extends State<AfficherEleve> {
  EleveDAO eleveDAO = EleveDAO.getEleveDao();

  String afficherEleves(){
    String result = "";
    eleveDAO.getAllEleves().then(
            (value) =>
            {
              result = value[0].nom
            });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        afficherEleves(),
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}