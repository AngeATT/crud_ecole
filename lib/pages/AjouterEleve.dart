import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//TODO : ajouter le bouton, afficher les parcours en fonction des parcours dans la bd, gerer l'insertion dans la bd
class AjouterEleve extends StatefulWidget {
  AjouterEleve({Key? key}) : super(key: key);

  @override
  _AjouterEleveState createState() => _AjouterEleveState();
}

class _AjouterEleveState extends State<AjouterEleve> {
  List<String> _items = [
    'Élément 1',
    'Élément 2',
    'Élément 3',
    'Élément 4',
    'Élément 5',
  ]; //TODO : supprimer cette liste et remplacer par un appel à la bd
    //TODO : désactiver le formulaire si la table classe est vide

  String? valueSelectedDropBtn;
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  FocusScopeNode focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      });
  }

  TextEditingController matriculeController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  TextEditingController moyMathController = TextEditingController();
  TextEditingController moyInfoController = TextEditingController();

  String matricule = '';
  String nom = '';
  String prenom = '';
  String classe = '';
  String moyMath = '';
  String anniv = "";
  String moyInfo = '';

  void clearChamps() {
    setState(() {
      matriculeController.clear();
      nomController.clear();
      prenomController.clear();
      dateController.value =
          TextEditingValue(text: "Chosir la date d'anniversaire");
      classeController.clear();
      moyMathController.clear();
      moyInfoController.clear();
      valueSelectedDropBtn = "choississez la classe";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              focusScopeNode.unfocus();
            },
            child: FocusScope(
                node: focusScopeNode,
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Text(
                                  'Saisir infos étudiant',
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: matriculeController,
                                decoration: InputDecoration(
                                  labelText: 'Matricule',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value != null) {
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
                                controller: nomController,
                                decoration: InputDecoration(
                                  labelText: 'Nom',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  return (value != null) && (value.isEmpty)
                                      ? 'Veuillez entrer le nom'
                                      : null;
                                },
                                onSaved: (value) {
                                  nom = (value != null) ? value : '';
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: prenomController,
                                decoration: InputDecoration(
                                  labelText: 'Prénom',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  return (value != null) && (value.isEmpty)
                                      ? 'Veuillez entrer le prénom'
                                      : null;
                                },
                                onSaved: (value) {
                                  prenom = (value != null) ? value : '';
                                },
                              ),
                              SizedBox(height: 16.0),
                              GestureDetector(
                                onTap: () => _selectDate(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:
                                          "Choisir la date d'anniversaire",
                                      prefixIcon: Icon(
                                        Icons.date_range,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              DropdownButtonFormField(
                                  value: valueSelectedDropBtn,
                                  items: _items.map(
                                          (e) => DropdownMenuItem(child: Text(e),value: e)
                                  ).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      valueSelectedDropBtn = value;
                                    });
                                  },
                                decoration: InputDecoration(
                                  labelText: "parcour",
                                  border: UnderlineInputBorder()
                                ),
                              icon: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: Colors.lightBlueAccent,
                              ),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: classeController,
                                decoration: InputDecoration(
                                  labelText: 'Classe',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  return (value != null) && (value.isEmpty)
                                      ? 'Veuillez entrer la classe'
                                      : null;
                                },
                                onSaved: (value) {
                                  classe = (value != null) ? value : '';
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: moyMathController,
                                decoration: InputDecoration(
                                  labelText: 'Moyenne Math',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  return (value != null) && (value.isEmpty)
                                      ? 'Veuillez entrer la moyenne en Math'
                                      : null;
                                },
                                onSaved: (value) {
                                  moyMath = (value != null) ? value : '';
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: moyInfoController,
                                decoration: InputDecoration(
                                  labelText: 'Moyenne Info',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  return (value != null) && (value.isEmpty)
                                      ? 'Veuillez entrer la moyenne en Info'
                                      : null;
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
                                    //TODO : enregistrer l'éléve et clear les champs si il a été enregistré
                                    //TODO : vérifier les moyennes, vérifier les regex des noms prenoms etc, vérifier la forme des matricules
                                  }
                                },
                                child: Text('Valider'),
                              ),
                              SizedBox(height: 16.0),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    clearChamps();
                                  },
                                  child: const Icon(Icons.close),
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ))));
  }
}
