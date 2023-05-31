import 'dart:async';
import 'package:crud_ecole/globals.dart' as globals;
import 'package:crud_ecole/customwidgets/ParcoursCard.dart';
import 'package:crud_ecole/models/ParcoursFormatted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crud_ecole/textinputformatters/NameTextInputFormatter.dart';

import 'AjouterParcours.dart';

class AfficherParcours extends StatefulWidget {
  const AfficherParcours({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AfficherParcoursState createState() => _AfficherParcoursState();
}

class _AfficherParcoursState extends State<AfficherParcours>
    with SingleTickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  FocusScopeNode focusScopeNode = FocusScopeNode();

  late AnimationController _animationController;
  double squareScale = 1;

  String searched = '';

  List<ParcoursFormatted> classes = [];
  List<ParcoursFormatted> searchedclasses = [];

  Future<List<ParcoursFormatted>> fetchdatas() async {
    classes = await globals.db.getFormattedParcours();
    if (searched.isEmpty) {
      searchedclasses = classes;
    } else {
      searchedclasses =
          await globals.db.getFormattedParcoursWithPattern(searched);
    }
    setState(() {});
    return searchedclasses;
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
              child: AjouterParcours(
                modeModifier: false,
                idParcour: -1,
                state: state,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchdatas();
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
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            focusScopeNode.unfocus();
          },
          child: FocusScope(
            node: focusScopeNode,
            child: Container(
              alignment: Alignment.center,
              child: FutureBuilder<List<ParcoursFormatted>>(
                  future: fetchdatas(),
                  builder: (context, snapshot) {
                    debugPrint('entered: ' +
                        snapshot.hasData.toString() +
                        snapshot.data.toString() +
                        snapshot.connectionState.toString());
                    if (classes.isEmpty) {
                      return const Center(
                        child: Text(
                          'Ajoutez des classes pour les voir ici',
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
                                  child: Card(
                                    shadowColor:
                                        Theme.of(context).primaryColorLight,
                                    elevation: 5,
                                    child: TextField(
                                      onChanged: (value) {
                                        searched = value;
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9a-zA-Zé ]')),
                                        NameTextInputFormatter(),
                                      ],
                                      decoration: InputDecoration(
                                          hintText: 'Classe',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Builder(builder: (context) {
                            if (searchedclasses.isEmpty) {
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
                                  itemCount: searchedclasses.length,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    EdgeInsetsGeometry bottompadding;
                                    if (position ==
                                        searchedclasses.length - 1) {
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
                                          child: ParcoursCard(
                                              parcours: ParcoursFormatted(
                                                id: searchedclasses[position]
                                                    .id,
                                                libelle:
                                                    searchedclasses[position]
                                                        .libelle,
                                                effectif:
                                                    searchedclasses[position]
                                                        .effectif,
                                              ),
                                              db: globals.db,
                                              fContext: context,
                                              state: state),
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
