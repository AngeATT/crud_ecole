import 'package:flutter/material.dart';

import '../DAO/parcours_dao.dart';
import '../models/parcours.dart';

class AjouterParcour extends StatefulWidget {
  const AjouterParcour({Key? key}) : super(key: key);

  @override
  _AjouterParcourState createState() => _AjouterParcourState();
}

class _AjouterParcourState extends State<AjouterParcour> {
  TextEditingController codeParcourController = TextEditingController();
  TextEditingController libelleParcourController = TextEditingController();
  final parcoursDao = ParcoursDAO(AppDatabase());

  @override
  void dispose() {
    codeParcourController.dispose();
    libelleParcourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Ajouter Parcours',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const Text('code parcours:'),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: codeParcourController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Text('libelle parcours:'),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: libelleParcourController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              final newParcour = Parcour(
                  codeParcours: codeParcourController.text,
                  libelleClasse: libelleParcourController.text);

              await parcoursDao.insertParcour(newParcour);
            },
            child: Text(
              'Valider',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
