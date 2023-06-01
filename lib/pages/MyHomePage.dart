import 'package:crud_ecole/pages/Parcours/AfficherParcours.dart';
import 'package:crud_ecole/pages/Etudiant/AfficherEtudiant.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD ECOLE'),
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
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
      ),
    );
  }
}
