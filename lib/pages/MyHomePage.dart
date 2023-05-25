import 'package:flutter/material.dart';
import 'AjouterEleve.dart';
import 'AjouterParcour.dart';
import 'ModifierParcour.dart';
import 'ModifierEleve.dart';
import 'SupprimerEleve.dart';
import 'SupprimerParcour.dart';
import 'AfficherEleve.dart';
import 'AfficherParcour.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _selectedMenuParcour = 0;
  int _selectedMenuEleve = 0;
  FocusScopeNode focusNode = FocusScopeNode();
  FocusScopeNode focusNode = FocusScopeNode();
  int _selectedTabIndex = 0;
  int _selectedMenu = 0;

  int _parcoursMenuIndex = 0;
  int _etudiantMenuIndex = 0;

  final headertitles = <String>['Parcours', 'Etudiants'];
  static List<Widget> allPages = <Widget>[
    AfficherParcours(),
    AjouterParcours(),
    ModifierParcours(),
    SupprimerParcours(),
    AfficherEtudiant(),
    AjouterEtudiant(),
    ModifierEtudiant(),
    SupprimerEtudiant(),
  ];

  void selectMenu() {
    setState(() {
      switch (_selectedTabIndex) {
        case 0:
          switch (_parcoursMenuIndex) {
            case 0:
              _selectedMenu = 0;
              break;
            case 1:
              _selectedMenu = 1;
              break;
            case 2:
              _selectedMenu = 2;
              break;
            case 3:
              _selectedMenu = 3;
              break;
          }
          break;
        case 1:
          switch (_etudiantMenuIndex) {
            case 0:
              _selectedMenu = 4;
              break;
            case 1:
              _selectedMenu = 5;
              break;
            case 2:
              _selectedMenu = 6;
              break;
            case 3:
              _selectedMenu = 7;
              break;
          }
          break;
      }
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    selectMenu();
  }

  void _onMenuSelected(int indexMenu) {
    Navigator.pop(context);
    switch (_selectedTabIndex) {
      case 0:
        _parcoursMenuIndex = indexMenu;
        break;
      case 1:
        _etudiantMenuIndex = indexMenu;
        break;
      default:
    }
    selectMenu();
  }

  void clear() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD ECOLE'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  headertitles[_selectedTabIndex],
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt_sharp),
              title: const Text('Afficher', style: TextStyle(fontSize: 18)),
              onTap: () {
                _onMenuSelected(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(
                'Ajouter',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _onMenuSelected(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Modifier', style: TextStyle(fontSize: 18)),
              onTap: () {
                _onMenuSelected(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Supprimer', style: TextStyle(fontSize: 18)),
              onTap: () {
                _onMenuSelected(3);
              },
            ),
          ],
        ),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            focusNode.unfocus();
          },
          child: FocusScope(
            node: focusNode,
            child: Center(
              child: IndexedStack(index: _selectedMenu, children: allPages),
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
      ));
  }
}
