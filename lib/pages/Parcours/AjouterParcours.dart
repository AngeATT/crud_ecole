import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/models/Parcours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../textinputformatters/NameTextInputFormatter.dart';

class AjouterParcours extends StatefulWidget {
  const AjouterParcours({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AjouterParcoursState createState() => _AjouterParcoursState();
}

class _AjouterParcoursState extends State<AjouterParcours> {
  FocusScopeNode focusScopeNode = FocusScopeNode();

  final DataBaseCrud db = DataBaseCrud.databaseInstance();

  late List<String> classes;

  final _formKey = GlobalKey<FormState>();

  late String libelle;

  TextEditingController libelleController = TextEditingController();

  Future<List<String>> fetchdatas() async {
    final datas = await db.getParcoursLibelle();
    classes = datas;
    return classes;
  }

  @override
  void initState() {
    super.initState();
    // Assign data within the initState() method
    fetchdatas();
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        FutureBuilder<Object>(
                            future: fetchdatas(),
                            builder: (context, snapshot) {
                              return TextFormField(
                                controller: libelleController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                              );
                            }),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _formKey.currentState!.save();
                                  db.insertParcours(
                                      Parcours(id: 0, libelle: libelle));
                                  setState(() {
                                    fetchdatas();
                                  });
                                  _formKey.currentState!.reset();
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
