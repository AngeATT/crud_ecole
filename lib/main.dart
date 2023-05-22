import 'package:flutter/material.dart';
import 'styles/Style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Nav Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              ),
              ListTile(
                leading: Icon(
                    Icons.delete
                ),
                title: Text(
                    'Supprimer',
                    style: TextStyle(fontSize: 18)
                ),
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: _getPage(_selectedIndex),
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

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Center(child: Text('Parcour'));
      case 1:
        return Center(child: Text('Eleve'));
      default:
        return Center(child: Text('Page inconnue'));
    }
  }
}
