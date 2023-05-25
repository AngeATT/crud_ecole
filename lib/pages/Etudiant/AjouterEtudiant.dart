import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

  DateFormat formatter = DateFormat('dd-MM-yyyy');

  Map<int, String> classes = {
    1: 'Élément 1',
    2: 'Élément 2',
    3: 'Élément 3',
    4: 'Élément 4',
    5: 'Élément 5'
  };

  final _formKey = GlobalKey<FormState>();

  late String matricule;
  late String nom;
  late String prenom;
  DateTime birthdate = DateTime.parse("2000-01-01");
  late int classe;
  late double moyMath;
  late double moyInfo;

  TextEditingController dateController = TextEditingController();

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
                            return value!.isEmpty
                                ? 'Veuillez entrer le matricule'
                                : null;
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
                        DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        ),
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
                                  // Utilisez les valeurs récupérées ici (matricule, nom, prenom, classe, moyMath, moyInfo)
                                  // par exemple, vous pouvez les afficher dans la console :
                                  debugPrint('Matricule: $matricule');
                                  debugPrint('Nom: $nom');
                                  debugPrint('Prénom: $prenom');
                                  debugPrint('Classe: $classe');
                                  debugPrint('Moyenne Math: $moyMath');
                                  debugPrint('Moyenne Info: $moyInfo');
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
    );
  }
}
