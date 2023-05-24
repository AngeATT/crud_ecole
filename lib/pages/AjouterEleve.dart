import 'package:flutter/material.dart';
//TODO : ajouter le bouton, afficher les parcours en fonction des parcours dans la bd, gerer l'insertion dans la bd
class AjouterEleve extends StatefulWidget {
  AjouterEleve({Key? key}) : super(key: key);

  @override
  _AjouterEleveState createState() => _AjouterEleveState();
}

class _AjouterEleveState extends State<AjouterEleve> {
  final _formKey = GlobalKey<FormState>();

  String matricule = '';
  String nom = '';
  String prenom = '';
  String classe = '';
  String moyMath = '';
  String moyInfo = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Matricule',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null){
                    if (value.isEmpty) {
                      return 'Veuillez entrer le matricule';
                    }
                  }
                  return null;
                },
                onSaved: (value) {
                  matricule = (value != null) ? value : '';
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return (value != null) && (value.isEmpty) ? 'Veuillez entrer le nom' : null;
                },
                onSaved: (value) {
                  nom = (value != null) ? value : '';
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                    return  (value != null) && (value.isEmpty)  ? 'Veuillez entrer le prénom' : null;
                },
                onSaved: (value) {
                  prenom = (value != null) ? value : '';
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Classe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return  (value != null) && (value.isEmpty)  ? 'Veuillez entrer la classe' : null;
                },
                onSaved: (value) {
                  classe = (value != null) ? value : '';
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Moyenne Math',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return  (value != null) && (value.isEmpty)  ? 'Veuillez entrer la moyenne en Math' : null;
                },
                onSaved: (value) {
                  moyMath = (value != null) ? value : '';
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Moyenne Info',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return  (value != null) && (value.isEmpty)  ? 'Veuillez entrer la moyenne en Info' : null;
                },
                onSaved: (value) {
                  moyInfo = (value != null) ? value : '';
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Utilisez les valeurs récupérées ici (matricule, nom, prenom, classe, moyMath, moyInfo)
                      // par exemple, vous pouvez les afficher dans la console :
                      print('Matricule: $matricule');
                      print('Nom: $nom');
                      print('Prénom: $prenom');
                      print('Classe: $classe');
                      print('Moyenne Math: $moyMath');
                      print('Moyenne Info: $moyInfo');
                    }
                },
                child: Text('Valider'),
              ),
            ],
          ),
        )
    );
  }
}