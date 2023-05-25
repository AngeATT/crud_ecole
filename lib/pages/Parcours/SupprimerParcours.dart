import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../textinputformatters/DecimalTextInputFormatter.dart';
import '../../textinputformatters/NameTextInputFormatter.dart';

class SupprimerParcours extends StatefulWidget {
  @override
  _SupprimerParcourState createState() => _SupprimerParcourState();
}

class _SupprimerParcourState extends State<SupprimerParcours> {
  FocusScopeNode focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  late String code_classe;
  late String libelle_Classe;
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
                          'Saisir Parcours Etudiant',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                            DecimalTextInputFormatter(),
                            LengthLimitingTextInputFormatter(1),
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Code Classe',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le Code';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            code_classe = value!;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Zéèïë ]')),
                            NameTextInputFormatter(),
                            LengthLimitingTextInputFormatter(5),
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Libellé Classe',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le Libellé';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            libelle_Classe = value!;
                          },
                        ),
                        const SizedBox(height: 16.0),

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
                                  debugPrint('Code Classe: $code_classe');
                                  debugPrint('Code Classe: $libelle_Classe');
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
