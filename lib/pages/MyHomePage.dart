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

  int _selectedMenu = 0;

  static List <List<Widget>> pages = <List<Widget>>[ //gere laffichage des menus
    [AjouterParcour(),AjouterEleve()],
    [ModifierParcour(),ModifierEleve()],
    [SupprimerParcour(),SupprimerEleve()],
    [AfficherParcour(),AfficherEleve()]
  ];

  static List<Widget> pagesParcour = <Widget>[
    AjouterParcour(),ModifierParcour(),SupprimerEleve(),AfficherParcour()
  ];
  static List<Widget> pagesEleve = <Widget>[
    AjouterEleve(),ModifierEleve(),SupprimerEleve(),AfficherEleve()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void selectMenu(int menuChoisi){
    if (_selectedIndex == 0 ){
      _selectedMenuParcour = menuChoisi;
    }else{
      _selectedMenuEleve = menuChoisi;
    }
  }

  void _onMenuTapped(int indexMenu){
    setState(() {
      selectMenu(indexMenu);
      //_selectedMenu = indexMenu;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('CRUD ECOLE')),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [_getPage(_selectedMenuParcour,_selectedMenuEleve,0),_getPage(_selectedMenuParcour,_selectedMenuEleve,1)],
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

  Widget _getPage(int menuParcour,int menuEleve, int navBarChoisie) {
    switch (navBarChoisie) {
      case 0:
        return pagesParcour[menuParcour];
      case 1:
        return pagesEleve[menuEleve];
      default:
        return Center(child: Text('Page inconnue'));
    }
  }
}
