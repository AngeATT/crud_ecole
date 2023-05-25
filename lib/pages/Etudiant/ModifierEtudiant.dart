import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../DAO/eleve_dao.dart';
import '../../models/eleves.dart';
import '../../textinputformatters/CustomMaxValueInputFormatter.dart';
import '../../textinputformatters/DecimalTextInputFormatter.dart';
import '../../textinputformatters/NameTextInputFormatter.dart';

class ModifierEtudiant extends StatefulWidget {
  @override
  _ModifierEtudiantState createState() => _ModifierEtudiantState();
}

class _ModifierEtudiantState extends State<ModifierEtudiant> {
  EleveDAO eleveDAO = EleveDAO.getEleveDao();
  List<String> _items = [
    'Élément 1',
    'Élément 2',
    'Élément 3',
    'Élément 4',
    'Élément 5',
  ]; //TODO : supprimer cette liste et remplacer par un appel à la bd
  //TODO : désactiver le formulaire si la table classe est vide

  String? valueSelectedDropBtn;
  FocusScopeNode focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime selectedDate = DateTime.now();

  bool noError = true;
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
  TextEditingController dateController = new TextEditingController();

  String matricule = '';
  String nom = '';
  String prenom = '';
  String classe = '';
  String anniv = "";
  late double moyMath;
  late double moyInfo;

  void clearChamps() {
    setState(() {
      matriculeController.clear();
      nomController.clear();
      prenomController.clear();
      dateController.value =
          TextEditingValue(text: "Choisir la date d'anniversaire");
      classeController.clear();
      moyMathController.clear();
      moyInfoController.clear();
    });
  }

  Eleve getEleve(){
    double? moyMathVerif = double.tryParse(moyMathController.text);
    double moyMath = (moyMathVerif != null) ? moyMathVerif : 0;
    double moyInfo = double.tryParse(moyInfoController.text)!;
    return Eleve(matricule:
    matriculeController.text,
        nom: nomController.text,
        prenoms: prenomController.text,
        moyMath:moyMath,
        moyInfo: moyInfo ,
        parcours: valueSelectedDropBtn!);
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
                                  'Modifier infos étudiant',
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: matriculeController,
                                textCapitalization: TextCapitalization.characters,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9A-Z]'))
                                ],
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Matricule',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez entrer le matricule';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  matricule = value!;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: nomController,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Zéèïë ]')),
                                  NameTextInputFormatter(),
                                ],
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Nom',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Veuillez entrer le nom'
                                      : null;
                                },
                                onSaved: (value) {
                                  nom = (value != null) ? value : '';
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: prenomController,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Zéèïë ]')),
                                  NameTextInputFormatter(),
                                ],
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
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
                                    keyboardType:  TextInputType.datetime,
                                    controller: dateController,
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
                                hint: Text("Parcour"),
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
                                controller: moyMathController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                  DecimalTextInputFormatter(),
                                  LengthLimitingTextInputFormatter(5),
                                  CustomMaxValueInputFormatter(maxInputValue: 20),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Moyenne Math',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez entrer la moyenne en Math';
                                  } else {
                                    try {
                                      double note = double.parse(value);
                                      if (note < 0 || note > 20) {
                                        return 'Entrez une note comprise entre 0 et 20';
                                      } else {
                                        return null;
                                      }
                                    } catch (e) {
                                      return null;
                                    }
                                  }
                                },
                                onSaved: (value) {
                                  try {
                                    moyMath = double.parse(value!);
                                  } catch (e) {
                                    //nothing to catch
                                  }
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: moyInfoController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                  DecimalTextInputFormatter(),
                                  LengthLimitingTextInputFormatter(5),
                                  CustomMaxValueInputFormatter(maxInputValue: 20),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Moyenne Info',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez entrer la moyenne en Info';
                                  } else {
                                    try {
                                      double note = double.parse(value);
                                      if (note < 0 || note > 20) {
                                        return 'Entrez une note comprise entre 0 et 20';
                                      } else {
                                        return null;
                                      }
                                    } catch (e) {
                                      return null;
                                    }
                                  }
                                },
                                onSaved: (value) {
                                  try {
                                    moyInfo = double.parse(value!);
                                  } catch (e) {
                                    //nothing to catch
                                  }
                                },
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    noError = true;
                                    try{
                                      eleveDAO.insertEleve(getEleve());
                                    }catch(e){
                                      Fluttertoast.showToast(
                                        msg: 'Matricule déjà attribué !',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                      );
                                      noError = false;
                                    }
                                    if (noError){
                                      Fluttertoast.showToast(
                                        msg: 'Eleve enregistré !',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                      );
                                    }
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

