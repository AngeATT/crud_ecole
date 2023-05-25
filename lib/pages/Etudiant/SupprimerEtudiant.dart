import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../textinputformatters/CustomMaxValueInputFormatter.dart';
import '../../textinputformatters/DecimalTextInputFormatter.dart';
import '../../textinputformatters/NameTextInputFormatter.dart';

class SupprimerEtudiant extends StatefulWidget {
  @override
  _SupprimerEtudiantState createState() => _SupprimerEtudiantState();
}

class _SupprimerEtudiantState extends State<SupprimerEtudiant> {
  FocusScopeNode focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  late String matricule;
  late String nom;
  late String prenom;
  late String classe;
  late double moyMath;
  late double moyInfo;
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
                          'Modifier infos étudiant',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
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
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
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
                        const SizedBox(height: 16.0),
                        TextFormField(
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
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
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
