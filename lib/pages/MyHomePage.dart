import 'package:crud_ecole/pages/Parcours/AfficherParcours.dart';
import 'package:crud_ecole/pages/Etudiant/AjouterEtudiant.dart';
import 'package:crud_ecole/pages/Etudiant/AfficherEtudiant.dart';
import 'package:crud_ecole/pages/Parcours/AjouterParcours.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusScopeNode focusNode = FocusScopeNode();
  int _selectedTabIndex = 0;

  final headertitles = <String>['Classes', 'Etudiants'];
  static List<Widget> allPages = <Widget>[
    AfficherParcours(),
    AfficherEtudiant(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void add() {
    Widget widget;
    double size;
    if (_selectedTabIndex == 0) {
      widget = const AjouterParcours();
      size = 200;
    } else {
      widget = const AjouterEtudiant();
      size = MediaQuery.of(context).size.height - 450;
    }
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              //height: size,
              child: Column(
                children: [
                  SizedBox(
                    height: size,
                    child: widget,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD ECOLE'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: const Icon(Icons.add),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            focusNode.unfocus();
          },
          child: FocusScope(
            node: focusNode,
            child: Center(
              child: IndexedStack(index: _selectedTabIndex, children: allPages),
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: headertitles[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: headertitles[1],
          )
        ],
        currentIndex: _selectedTabIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
