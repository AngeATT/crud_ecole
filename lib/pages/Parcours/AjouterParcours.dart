import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:crud_ecole/models/Parcours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crud_ecole/textinputformatters/NameTextInputFormatter.dart';

class AjouterParcours extends StatefulWidget {
  final Function state;
  final bool modeModifier;
  final int idParcour;
   AjouterParcours(
      {super.key,required this.modeModifier, required this.idParcour});

  @override
  // ignore: library_private_types_in_public_api
  _AjouterParcoursState createState() => _AjouterParcoursState(modeModifier,idParcour);
}

class _AjouterParcoursState extends State<AjouterParcours> {
  final bool modeModifier;
  final int idParcour;
  late String parcourLibelle;
  final fToast = FToast();

  FocusScopeNode focusScopeNode = FocusScopeNode();

  final DataBaseCrud db = DataBaseCrud.databaseInstance();

  List<String> classes = [];

  static String MODIFIER_CLASSE = 'Modifier Parcours Etudiant';
  static String AJOUTER_CLASSE  = 'Ajouter une classe';

  final _formKey = GlobalKey<FormState>();

  late String libelle;

  TextEditingController libelleController = TextEditingController();

  _AjouterParcoursState(this.modeModifier,this.idParcour);

  Future<List<String>> fetchdatas() async {
    final datas = await db.getParcours();
    classes = await db.getParcoursLibelle();
    if (modeModifier){
      for (Parcours parcours in datas){
        if (idParcour == parcours.id){
          parcourLibelle = parcours.libelle;
          libelleController.value = TextEditingValue(text: parcours.libelle);
        }
      }
    }
    return classes;
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
            "Classe ajoutée",
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
    fetchdatas();
  }

  String titre(){
    return modeModifier ? MODIFIER_CLASSE : AJOUTER_CLASSE;
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
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
                         Text(
                          titre(),
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        FutureBuilder<Object>(
                            future: fetchdatas(),
                            builder: (context, snapshot) {
                              return TextFormField(
                                controller: libelleController,
                                autovalidateMode: modeModifier ?
                                     AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
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
                                  } else if (classes.contains(value.trim().toUpperCase())) {
                                    if (modeModifier){
                                      return value.trim().toUpperCase() == parcourLibelle.trim().toUpperCase() ? "Le libéllé n'a pas changé" : "Libellé déjà utilisé";
                                    }
                                    return "Libellé déjà utilisé";
                                  }else if (value.trim().toUpperCase() ==
                                      'TOUT') {
                                    return "Une classe ne peut pas s'appeler tout";
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _formKey.currentState!.save();
                                  if (modeModifier){
                                    await db.updateParcours(Parcours(id: this.idParcour, libelle: this.libelle));
                                  }else{
                                    await db.insertParcours(
                                        Parcours(id: 0, libelle: libelle));
                                  }
                                  setState(() {
                                    fetchdatas();
                                  });
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
    );
  }
}
