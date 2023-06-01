import 'package:crud_ecole/globals.dart' as globals;
import 'package:crud_ecole/models/Parcours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crud_ecole/textinputformatters/NameTextInputFormatter.dart';

class ModifierParcours extends StatefulWidget {
  final Parcours chosenPar;
  const ModifierParcours({super.key, required this.chosenPar});

  @override
  // ignore: library_private_types_in_public_api
  _ModifierParcoursState createState() => _ModifierParcoursState();
}

class _ModifierParcoursState extends State<ModifierParcours> {
  final fToast = FToast();

  FocusScopeNode focusScopeNode = FocusScopeNode();

  Widget toastChild = const Text('');

  List<String> classes = [];

  final _formKey = GlobalKey<FormState>();

  int id = 0;
  String libelle = '';

  TextEditingController libelleController = TextEditingController();

  Future<List<String>> fetchdatas() async {
    final datas = await globals.db.getParcoursLibelleWithout(id);
    classes.clear();
    for (var classe in datas) {
      classes.add(classe.toUpperCase());
    }
    return classes;
  }

  void fillchamps() {
    id = widget.chosenPar.id;
    libelle = widget.chosenPar.libelle;
    libelleController.value = TextEditingValue(text: libelle);
  }

  @override
  void initState() {
    super.initState();
    // Assign data within the initState() method
    fillchamps();
    fetchdatas();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    toastChild = Container(
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
            "Classe modifiée",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
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
                top: 5.0,
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
                                    return 'Veuillez entrer le libellé';
                                  } else if (classes
                                      .contains(value.trim().toUpperCase())) {
                                    return 'Le libellé doit être unique';
                                  } else if (value.trim().toUpperCase() ==
                                      'TOUT') {
                                    return "Une classe ne peut pas s'appeler tout";
                                  }
                                  {
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
                                  globals.db.updateParcours(
                                      Parcours(id: id, libelle: libelle));
                                  fetchdatas();
                                  globals.streamController.add('');
                                  fToast.showToast(
                                    gravity: ToastGravity.TOP,
                                    child: toastChild,
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
    );
  }
}
