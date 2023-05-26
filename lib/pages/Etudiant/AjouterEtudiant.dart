import 'package:crud_ecole/models/Etudiant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../Db/DataBaseCrud.dart';

import '../../textinputformatters/DecimalTextInputFormatter.dart';
import '../../textinputformatters/NameTextInputFormatter.dart';

class AjouterEtudiant extends StatefulWidget {
  const AjouterEtudiant({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AjouterEtudiantState createState() => _AjouterEtudiantState();
}

class _AjouterEtudiantState extends State<AjouterEtudiant> {
  FocusScopeNode focusScopeNode = FocusScopeNode();

  final DataBaseCrud db = DataBaseCrud.databaseInstance();
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  late Map<int, String> classes = {};

  late List<String> mats = [];

  Etudiant getEleve() {
    return Etudiant(
        matricule: matricule,
        nom: nom,
        prenom: prenom,
        dateAnniv: birthdate.toString(),
        moyMath: moyMath,
        moyInfo: moyInfo,
        classeId: classe);
  }

  final _formKey = GlobalKey<FormState>();

  late String matricule;
  late String nom;
  late String prenom;
  DateTime birthdate = DateTime.parse("2000-01-01");
  late int classe;
  late double moyMath;
  late double moyInfo;

  TextEditingController matriculeController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  TextEditingController moyMathController = TextEditingController();
  TextEditingController moyInfoController = TextEditingController();
  TextEditingController dateController = new TextEditingController();

  TextEditingController matriculeCOntroller = TextEditingController();

  void fetchmats() async {
    final datas = await db.getEtudiantsMat();
    mats = datas;
  }

  Future<Map<int, String>> fetchclasses() async {
    final datas = await db.getParcours();
    classes = datas.fold<Map<int, String>>({}, (map, classe) {
      map[classe.id] = classe.libelle;
      return map;
    });
    return classes;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthdate,
      firstDate: DateTime.parse("1900-01-01"),
      lastDate: DateTime.now().subtract(
        const Duration(days: 365 * 10),
      ),
    );
    if (picked != birthdate && picked != null) {
      setState(() {
        birthdate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      });
    }
  }

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

  @override
  void initState() {
    super.initState();
    // Assign data within the initState() method
    fetchmats();
    fetchclasses();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusScopeNode.unfocus();
      },
      child: FocusScope(
        node: focusScopeNode,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16.0,
                top: 16.0,
                end: 16.0,
                bottom: 20.0,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Saisir infos étudiant',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            } else if (mats.contains(value)) {
                              return 'Matricule déjà attribué';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            matricule = value!;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            nom = value!.trim();
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Zéèïë ]')),
                            NameTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Prénom',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Veuillez entrer le prénom'
                                : null;
                          },
                          onSaved: (value) {
                            prenom = value!.trim();
                          },
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? 'Renseignez la date de naissance'
                                  : null,
                              controller: dateController,
                              decoration: InputDecoration(
                                hintText: "Date de naissance",
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Icon(
                                    Icons.date_range,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        FutureBuilder<Object>(
                            future: fetchclasses(),
                            builder: (context, snapshot) {
                              return DropdownButtonFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                items: classes.entries
                                    .map((MapEntry<int, String> entry) {
                                  return DropdownMenuItem<int>(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    classe = value!;
                                  });
                                },
                                decoration: const InputDecoration(
                                    labelText: "Classe",
                                    border: UnderlineInputBorder()),
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validator: (value) {
                                  return value == null
                                      ? 'Veuillez choisir la classe'
                                      : null;
                                },
                              );
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                            DecimalTextInputFormatter(),
                            LengthLimitingTextInputFormatter(5),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Moyenne Math',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la moyenne en Math';
                            } else if (value.contains('.')) {
                              if (value.indexOf('.') < value.length - 3) {
                                return 'Maximum 2 chiffres après la virgule';
                              } else if (value.indexOf('.') ==
                                  value.length - 1) {
                                return 'Note non valide';
                              }
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
                            return null;
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                            DecimalTextInputFormatter(),
                            LengthLimitingTextInputFormatter(5),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Moyenne Info',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la moyenne en Info';
                            } else if (value.contains('.')) {
                              if (value.indexOf('.') < value.length - 3) {
                                return 'Maximum 2 chiffres après la virgule';
                              } else if (value.indexOf('.') ==
                                  value.length - 1) {
                                return 'Note non valide';
                              }
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
                            return null;
                          },
                          onSaved: (value) {
                            try {
                              moyInfo = double.parse(value!);
                            } catch (e) {
                              //nothing to catch
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  db.insertEtudiant(Etudiant(
                                      matricule: matricule,
                                      nom: nom,
                                      prenom: prenom,
                                      dateAnniv: DateFormat('yyyy-MM-dd')
                                          .format(birthdate),
                                      moyMath: moyMath,
                                      moyInfo: moyInfo,
                                      classeId: classe));
    setState(() {
    fetchmats();
    });
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text('Etudiant ajoutée')));
                                }
                                // Utilisez les valeurs récupérées ici (matricule, nom, prenom, classe, moyMath, moyInfo)
                                // par exemple, vous pouvez les afficher dans la console :
                              }
                            },
                            child: const Text('Valider'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          clearChamps();
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void makeToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
    );
  }
}
