import 'package:crud_ecole/pages/Parcours/AfficherParcours.dart';
import 'package:crud_ecole/pages/Etudiant/AjouterEtudiant.dart';
import 'package:crud_ecole/pages/Etudiant/AfficherEtudiant.dart';
import 'package:crud_ecole/pages/Parcours/AjouterParcours.dart';
import 'package:crud_ecole/pages/Parcours/ModifierParcours.dart';
import 'package:crud_ecole/pages/Parcours/SupprimerParcours.dart';
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
    const AfficherParcours(),
    const AfficherEtudiant(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void add() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget widget = _selectedTabIndex == 0
        ? const AjouterParcours()
        : const AjouterEtudiant();

    if (height > width) {
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
                //height: 20,
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
                height: height * 0.8,
                child: widget,
              )
            ],
          );
        },
      );
    } else {
      debugPrint('desktop');
    }
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
