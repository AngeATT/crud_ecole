import 'dart:async';
import 'package:crud_ecole/models/EtudiantFormatted.dart';
import 'package:crud_ecole/pages/Etudiant/AjouterEtudiant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crud_ecole/globals.dart' as globals;
import 'package:crud_ecole/customwidgets/EtudiantCard.dart';

class AfficherEtudiant extends StatefulWidget {
  const AfficherEtudiant({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AfficherEtudiantState createState() => _AfficherEtudiantState();
}

class _AfficherEtudiantState extends State<AfficherEtudiant>
    with SingleTickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  FocusScopeNode focusScopeNode = FocusScopeNode();

  late AnimationController _animationController;
  double squareScale = 1;

  String searched = '';
  String chosenclass = 'Tout';

  List<EtudiantFormatted> etudiants = [];
  List<EtudiantFormatted> searchedetudiants = [];
  List<String> classes = [];

  Future<List<EtudiantFormatted>> fetchdatas() async {
    etudiants = await globals.db.getFormattedEtudiants();
    if (searched.isEmpty && chosenclass == 'Tout') {
      searchedetudiants = etudiants;
    } else {
      searchedetudiants = await globals.db
          .getFormattedEtudiantsWithPattern(searched, chosenclass);
    }
    setState(() {});
    return searchedetudiants;
  }

  Future<List<String>> fetchclasses() async {
    classes = await globals.db.getNotEmptyParcoursLibelle();
    classes.insert(0, 'Tout');
    return classes;
  }

  @override
  void initState() {
    // Assign data within the initState() method
    fetchdatas();
    fetchclasses();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.9,
      upperBound: 1,
      value: 1,
    );

    _animationController.addListener(() {
      setState(() {
        squareScale = _animationController.value;
      });
    });

    _animationController.drive(CurveTween(curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void add() {
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 9, bottom: 5),
              child: Center(
                  child: Container(
                width: 70,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
            ),
            SizedBox(
              height: height * 0.8 <= 600 ? height * 0.8 : 600,
              child: AjouterEtudiant(
                state: state,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _animationController.reverse();
          },
          onTapDown: (dp) {
            _animationController.reverse();
          },
          onTapUp: (dp) {
            Timer(const Duration(milliseconds: 150), () {
              _animationController.fling();
            });
          },
          onTapCancel: () {
            _animationController.fling();
          },
          child: Transform.scale(
            scale: squareScale,
            child: FloatingActionButton(
              onPressed: add,
              child: const Icon(Icons.add),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            focusScopeNode.unfocus();
          },
          child: FocusScope(
            node: focusScopeNode,
            child: Container(
              alignment: Alignment.center,
              child: FutureBuilder<Object>(
                  future: fetchdatas(),
                  builder: (context, snapshot) {
                    if (etudiants.isEmpty) {
                      return const Center(
                        child: Text(
                          'Ajoutez des étudiants pour les voir ici',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 16.0,
                                  top: 16.0,
                                  end: 16.0,
                                  bottom: 16),
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 450),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          shadowColor: Theme.of(context)
                                              .primaryColorLight,
                                          elevation: 5,
                                          child: TextField(
                                            onChanged: (value) {
                                              searched = value;
                                            },
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9A-Z]'))
                                            ],
                                            decoration: InputDecoration(
                                                hintText: 'Matricule',
                                                border: InputBorder.none,
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColorLight)),
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )),
                                          ),
                                        ),
                                      ),
                                      FutureBuilder<Object>(
                                          future: fetchclasses(),
                                          builder: (context, snapshot) {
                                            return Expanded(
                                              child: Card(
                                                elevation: 5,
                                                shadowColor: Theme.of(context)
                                                    .primaryColorLight,
                                                child: DropdownButtonFormField(
                                                  value: chosenclass,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  iconEnabledColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  items: classes
                                                      .map((String item) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(item),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    chosenclass = value!;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Builder(builder: (context) {
                            if (searchedetudiants.isEmpty) {
                              return const Expanded(
                                child: Center(
                                  child: Text(
                                    'Aucune correspondance',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              );
                            }
                            return Expanded(
                              child: ListView.builder(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  itemCount: searchedetudiants.length,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    EdgeInsetsGeometry bottompadding;
                                    if (position ==
                                        searchedetudiants.length - 1) {
                                      bottompadding =
                                          const EdgeInsets.only(bottom: 100);
                                    } else {
                                      bottompadding = EdgeInsets.zero;
                                    }
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16.0, top: 16.0, end: 16.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: bottompadding,
                                          constraints: const BoxConstraints(
                                              maxWidth: 450),
                                          child: EtudiantCard(
                                            etudiant: EtudiantFormatted(
                                              matricule:
                                                  searchedetudiants[position]
                                                      .matricule,
                                              nom: searchedetudiants[position]
                                                  .nom,
                                              prenom:
                                                  searchedetudiants[position]
                                                      .prenom,
                                              dateAnniv:
                                                  searchedetudiants[position]
                                                      .dateAnniv,
                                              moyMath:
                                                  searchedetudiants[position]
                                                      .moyMath,
                                              moyInfo:
                                                  searchedetudiants[position]
                                                      .moyInfo,
                                              classe:
                                                  searchedetudiants[position]
                                                      .classe,
                                              classeId:
                                                  searchedetudiants[position]
                                                      .classeId,
                                            ),
                                            state: state,
                                            context: context,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                        ],
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
