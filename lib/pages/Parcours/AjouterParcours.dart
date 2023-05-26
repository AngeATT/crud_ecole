import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../textinputformatters/NameTextInputFormatter.dart';

class AjouterParcours extends StatefulWidget {
  @override
  _AjouterParcoursState createState() => _AjouterParcoursState();
}

class _AjouterParcoursState extends State<AjouterParcours> {
  FocusScopeNode focusScopeNode = FocusScopeNode();

  static const List<String> classes = ['Prépa 1'];

  final _formKey = GlobalKey<FormState>();

  late String libelle;

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
                          'Saisir Classe',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9a-zA-Zé ]')),
                            NameTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Libellé classe',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le Libellé';
                            } else if (classes.contains(value.trim())) {
                              return 'Le libellé doit être unique';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            libelle = value!.trim();
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
                                  debugPrint('libelle: $libelle');
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
