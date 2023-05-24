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
  int _selectedMenu = 0;


  static List<Widget> allPages = <Widget>[
    AjouterParcour(),ModifierParcour(),SupprimerParcour(),AfficherParcour(), //0,1,2,3 lorqu'on est sur _selectedIndex = 0 selectedMenu
    AjouterEleve(),ModifierEleve(),SupprimerEleve(),AfficherEleve()        //si selected index = 1 doit chercher entre 4,5,6,7 selectedMenu+4
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0 ){
      _selectedMenu = _selectedMenuParcour;
    }else{
      _selectedMenu = _selectedMenuEleve + 4;
    }
    focusNode.unfocus();
  }

  void selectMenu(int menuChoisi){
    if (_selectedIndex == 0 ){
      _selectedMenuParcour = menuChoisi;
      _selectedMenu = menuChoisi;
    }else{
      _selectedMenuEleve = menuChoisi;
      _selectedMenu = menuChoisi + 4;
    }
    focusNode.unfocus();
  }

  void _onMenuTapped(int indexMenu){
    setState(() {
      selectMenu(indexMenu);
      //_selectedMenu = indexMenu;
    });
    Navigator.pop(context);
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD ECOLE'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          //TODO : modifier couleur
          color: Colors.deepPurple[300],
          child: ListView(
            children: [
              Container(
                child: DrawerHeader(
                    child: Center(
                        child: Text(
                          'ACCEUIL',
                          style: TextStyle(fontSize: 25),
                        )
                    )
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add,
                  size: 40,
                  shadows: [],
                ),
                title: Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  _onMenuTapped(0);
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.edit
                ),
                title: Text(
                    'Modifier',
                    style: TextStyle(fontSize: 18)
                ),
                onTap: () {
                  _onMenuTapped(1);
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.delete
                ),
                title: Text(
                    'Supprimer',
                    style: TextStyle(fontSize: 18)
                ),
                onTap: () {
                  _onMenuTapped(2);
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.list_alt_sharp
                ),
                title: Text(
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
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            focusNode.unfocus();
          },
          child: FocusScope(
            node: focusNode,
            child: Center(
              child: IndexedStack(
                  index: _selectedMenu,
                  children: allPages
              ),
            ),
          )
      ),
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
}
