import 'package:crud_ecole/models/Etudiant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:crud_ecole/globals.dart' as globals;
import 'package:crud_ecole/textinputformatters/DecimalTextInputFormatter.dart';
import 'package:crud_ecole/textinputformatters/NameTextInputFormatter.dart';

class AjouterEtudiant extends StatefulWidget {
  final Function state;
  const AjouterEtudiant({super.key, required this.state});
  @override
  // ignore: library_private_types_in_public_api
  _AjouterEtudiantState createState() => _AjouterEtudiantState();
}

class _AjouterEtudiantState extends State<AjouterEtudiant> {
  final fToast = FToast();

  FocusScopeNode focusScopeNode = FocusScopeNode();
  final FocusNode _dropdownFocusNode = FocusNode();

  TextEditingController moyMathController = TextEditingController();

  DateFormat formatter = DateFormat('dd-MM-yyyy');

  Map<int, String> classes = {};

  List<String> mats = [];

  final _formKey = GlobalKey<FormState>();

  late String matricule;
  late String nom;
  late String prenom;
  DateTime birthdate = DateTime.parse("1700-01-01");
  late int classe;
  late double moyMath;
  late double moyInfo;

  TextEditingController dateController = TextEditingController();

  void fetchMats() async {
    final datas = await globals.db.getEtudiantsMat();
    mats = datas;
  }

  Future<Map<int, String>> fetchClasses() async {
    final datas = await globals.db.getParcours();
    classes = datas.fold<Map<int, String>>({}, (map, classe) {
      map[classe.id] = classe.libelle;
      return map;
    });
    return classes;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse("2000-01-01"),
      firstDate: DateTime.parse("1900-01-01"),
      lastDate: DateTime.now().subtract(
        const Duration(days: 365 * 10),
      ),
    );
    if (picked != null) {
      // ignore: use_build_context_synchronously
      FocusScope.of(context).requestFocus(_dropdownFocusNode);
      if (picked != birthdate) {
        birthdate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      }
    }
  }

  Widget buildToastChild() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).primaryColorLight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check,
              color: Theme.of(context).colorScheme.inverseSurface),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            "Etudiant ajouté",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Assign data within the initState() method
    fetchMats();
    fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          focusScopeNode.unfocus();
        },
        child: FocusScope(
          node: focusScopeNode,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 16.0,
                  end: 16.0,
                  top: 5.0,
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
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              return value!.isEmpty
                                  ? 'Veuillez entrer le prénom'
                                  : null;
                            },
                            onFieldSubmitted: (value) async {
                              focusScopeNode.unfocus();
                              _selectDate(context);
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
                                  contentPadding:
                                      const EdgeInsets.only(left: 10, top: 12),
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
                          const SizedBox(height: 16.0),
                          FutureBuilder<Object>(
                              future: fetchClasses(),
                              builder: (context, snapshot) {
                                return DropdownButtonFormField(
                                  focusNode: _dropdownFocusNode,
                                  enableFeedback: true,
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  menuMaxHeight: 220,
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
                                    classe = value!;
                                  },
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelText: "Classe",
                                      border: UnderlineInputBorder()),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp),
                                  validator: (value) {
                                    return value == null
                                        ? 'Veuillez choisir la classe'
                                        : null;
                                  },
                                );
                              }),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                  if (_formKey.currentState!.validate()) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    _formKey.currentState!.save();
                                    globals.db.insertEtudiant(Etudiant(
                                        matricule: matricule,
                                        nom: nom,
                                        prenom: prenom,
                                        dateAnniv: DateFormat('yyyy-MM-dd')
                                            .format(birthdate),
                                        moyMath: moyMath,
                                        moyInfo: moyInfo,
                                        classeId: classe));
                                    widget.state;
                                    fetchMats();
                                    _formKey.currentState!.reset();

                                    fToast.showToast(
                                      gravity: ToastGravity.TOP,
                                      child: buildToastChild(),
                                      toastDuration: const Duration(seconds: 2),
                                    );
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
        ),
      ),
    );
  }
}
