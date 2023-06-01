import 'package:crud_ecole/StreamMessage.dart';
import 'package:crud_ecole/models/Etudiant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:crud_ecole/globals.dart' as globals;
import 'package:crud_ecole/textinputformatters/DecimalTextInputFormatter.dart';
import 'package:crud_ecole/textinputformatters/NameTextInputFormatter.dart';

class ModifierEtudiant extends StatefulWidget {
  final Etudiant chosenEt;
  const ModifierEtudiant({super.key, required this.chosenEt});
  @override
  // ignore: library_private_types_in_public_api
  _ModifierEtudiantState createState() => _ModifierEtudiantState();
}

class _ModifierEtudiantState extends State<ModifierEtudiant> {
  final fToast = FToast();

  FocusScopeNode focusScopeNode = FocusScopeNode();
  final FocusNode _dropdownFocusNode = FocusNode();

  Widget toastChild = const Text('');

  DateFormat formatter = DateFormat('dd-MM-yyyy');

  Map<int, String> classes = {};

  List<String> mats = [];

  final _formKey = GlobalKey<FormState>();

  String chosenmat = '';
  String matricule = '';
  String nom = '';
  String prenom = '';
  DateTime birthdate = DateTime.parse('1700-01-01');
  int classeId = 0;
  double moyMath = 0;
  double moyInfo = 0;

  TextEditingController matriculeController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController moyMathController = TextEditingController();
  TextEditingController moyInfoController = TextEditingController();

  void fetchMats() async {
    final datas = await globals.db.getEtudiantsMatWithout(matricule);
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
      if (picked != birthdate) {
        birthdate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      }
    }
  }

  void fillchamps() {
    chosenmat = widget.chosenEt.matricule;
    matricule = chosenmat;
    nom = widget.chosenEt.nom;
    prenom = widget.chosenEt.prenom;
    birthdate = DateTime.parse(widget.chosenEt.dateAnniv);
    classeId = widget.chosenEt.classeId;
    moyMath = widget.chosenEt.moyMath;
    moyInfo = widget.chosenEt.moyInfo;

    matriculeController.value = TextEditingValue(text: matricule);
    nomController.value = TextEditingValue(text: nom);
    prenomController.value = TextEditingValue(text: prenom);
    dateController.value = TextEditingValue(text: formatter.format(birthdate));
    moyMathController.value = TextEditingValue(text: moyMath.toString());
    moyInfoController.value = TextEditingValue(text: moyInfo.toString());
  }

  @override
  void dispose() {
    _dropdownFocusNode.dispose();
    focusScopeNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Assign data within the initState() method
    fillchamps();

    fetchMats();
    fetchClasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    toastChild = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).colorScheme.background,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.black87),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Etudiant modifié",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
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
                            controller: matriculeController,
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
                            controller: nomController,
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
                            },
                            onSaved: (value) {
                              prenom = value!.trim();
                            },
                            controller: prenomController,
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
                                    classeId = value!;
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
                                  value: classeId,
                                );
                              }),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            controller: moyMathController,
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
                            controller: moyInfoController,
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
                                    globals.db.updateEtudiant(
                                        Etudiant(
                                            matricule: matricule,
                                            nom: nom,
                                            prenom: prenom,
                                            dateAnniv: DateFormat('yyyy-MM-dd')
                                                .format(birthdate),
                                            moyMath: moyMath,
                                            moyInfo: moyInfo,
                                            classeId: classeId),
                                        chosenmat);
                                    chosenmat = matricule;
                                    fetchMats();

                                    if (classeId == widget.chosenEt.classeId) {
                                      globals.streamController.add(
                                          const StreamMessage(
                                              from: ' nopepar', to: ''));
                                    } else {
                                      globals.streamController.add(
                                          const StreamMessage(
                                              from: '', to: ''));
                                    } //refresh etudiant page
                                    fToast.showToast(
                                      gravity: ToastGravity.TOP,
                                      child: toastChild,
                                      toastDuration: const Duration(seconds: 2),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Valider',
                                  style: TextStyle(color: Colors.white),
                                ),
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
