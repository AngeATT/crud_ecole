import 'package:flutter/material.dart';
//TODO : ajouter le bouton, afficher les parcours en fonction des parcours dans la bd, gerer l'insertion dans la bd
class AjouterEleve extends StatefulWidget {
  const AjouterEleve({Key? key}) : super(key: key);

  @override
  _AjouterEleveState createState() => _AjouterEleveState();
}

class _AjouterEleveState extends State<AjouterEleve> {
  TextEditingController matriculeController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  TextEditingController moyMathController = TextEditingController();
  TextEditingController moyInfoController = TextEditingController();

  @override
  void dispose() {
    matriculeController.dispose();
    nomController.dispose();
    prenomController.dispose();
    classeController.dispose();
    moyMathController.dispose();
    moyInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Saisir infos étudiant',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text('Matricule:'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: matriculeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Nom:'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: nomController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Prénom:'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: prenomController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Classe:'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: classeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Moy Math:'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: moyMathController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Moy Info:'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: moyInfoController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
    );
  }
}
