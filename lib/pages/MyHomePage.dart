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
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _selectedMenu = 0;

  static List <List<Widget>> pages = <List<Widget>>[ //gere laffichage des menus
    [const AjouterParcour(),const AjouterEleve()],
    [const ModifierParcour(),const ModifierEleve()],
    [const SupprimerParcour(),const SupprimerEleve()],
    [const AfficherParcour(),const AfficherEleve()]

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMenuTapped(int indexMenu){
    setState(() {
      _selectedMenu = indexMenu;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('CRUD ECOLE')),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          //TODO : modifier couleur
          color: Colors.deepPurple[300],
          child: ListView(
            children: [
              Container(
                child: const DrawerHeader(
                    child: Center(
                        child: Text(
                          'ACCEUIL',
                          style: TextStyle(fontSize: 25),
                        )
                    )
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                  size: 40,
                  shadows: [],
                ),
                title: const Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  _onMenuTapped(0);
                },
              ),
              ListTile(
                leading: const Icon(
                    Icons.edit
                ),
                title: const Text(
                    'Modifier',
                    style: TextStyle(fontSize: 18)
                ),
                onTap: () {
                  _onMenuTapped(1);
                },
              ),
              ListTile(
                leading: const Icon(
                    Icons.delete
                ),
                title: const Text(
                    'Supprimer',
                    style: TextStyle(fontSize: 18)
                ),
                onTap: () {
                  _onMenuTapped(2);
                },
              ),
              ListTile(
                leading: const Icon(
                    Icons.list_alt_sharp
                ),
                title: const Text(
                    'Afficher',
                    style: TextStyle(fontSize: 18)
                ),
                onTap: () {
                  _onMenuTapped(3);
                },
              )
            ],
          ),
        ),
      ),
      body: _getPage(_selectedMenu,_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Parcour',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Eleve',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int indexMenu,int index) {
    switch (index) {
      case 0:
        return pages[indexMenu][0];
      case 1:
        return pages[indexMenu][1];
      default:
        return const Center(child: Text('Page inconnue'));
    }
  }
}
