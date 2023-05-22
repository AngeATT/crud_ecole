import 'package:flutter/material.dart';

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
          color: Colors.black12,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Icon(
                    Icons.home,
                    size: 35,
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
