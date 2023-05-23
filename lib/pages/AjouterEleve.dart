import 'package:flutter/material.dart';
//TODO : ajouter le bouton, afficher les parcours en fonction des parcours dans la bd, gerer l'insertion dans la bd
class AjouterEleve extends StatefulWidget {
  AjouterEleve({Key? key}) : super(key: key);

  @override
  _AjouterEleveState createState() => _AjouterEleveState();
}

class _AjouterEleveState extends State<AjouterEleve> {
  FocusScopeNode focusScopeNode = FocusScopeNode();
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
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          focusScopeNode.unfocus();
        },
        child : Center(
              child: FocusScope(
                node : focusScopeNode,
                child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Saisir infos étudiant',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text('Matricule:'),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: matriculeController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text('Nom:'),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: nomController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text('Prénom:'),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: prenomController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text('Classe:'),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: classeController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text('Moy Math:'),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: moyMathController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text('Moy Info:'),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: moyInfoController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ) )
    )

      ;
  }
}
