import 'package:flutter/material.dart';
import 'package:life_rescue/main.dart';
import 'package:life_rescue/ContatoEmergenciaPage.dart';
import 'package:life_rescue/PostosEmergenciaPage.dart';
import 'package:life_rescue/NumeroEmergencia.dart';


class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    CategoriesPage(),
    EmergencyContactAddPage(),
    EmergencyPointsMapPage(),
    EmergencyNumbersScreen(), // Adicionando o novo widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Locais Proximos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.numbers),
            label: 'Numeros Emergencia',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[700],
        onTap: _onItemTapped,
      ),
    );
  }
}
