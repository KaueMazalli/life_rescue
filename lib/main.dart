import 'package:flutter/material.dart';
import 'package:life_rescue/main.dart';
import 'package:life_rescue/bottom_nav_screen.dart'; // Importe o arquivo da barra de navegação inferior

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Rescue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // Altere para MainScreen ao invés de Scaffold diretamente
    );
  }
}

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Defina a GlobalKey para o Scaffold
      appBar: AppBar(
        title: Image.asset('assets/logo.png'), // Substitua pelo caminho do seu logo
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Acesse a GlobalKey para abrir o menu lateral
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Adicione aqui a função para pedir permissão de localização
            },
          ),
        ],
        toolbarHeight: 50, // Defina a altura desejada da AppBar
      ),
      body: BottomNavScreen(), // Use a barra de navegação inferior como página inicial
      drawer: Drawer( // Adicione o Drawer para o menu lateral
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Postos de emergência próximos'),
              onTap: () {
                // Adicione ação para o item do menu
              },
            ),
            ListTile(
              title: Text('Contato de emergência'),
              onTap: () {
                // Adicione ação para o item do menu
              },
            ),
            ListTile(
              title: Text('Número de emergência'),
              onTap: () {
                // Adicione ação para o item do menu
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(categories.length, (index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryDetailPage(category: categories[index])),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                ),
                padding: EdgeInsets.all(20.0),
              ),
              child: Text(
                categories[index],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CategoryDetailPage extends StatelessWidget {
  final String category;

  const CategoryDetailPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('Detalhes da categoria $category'),
      ),
    );
  }
}

final List<String> categories = [
  'Queimadura',
  'Intoxicação',
  'Picada',
  'Engasgo',
  'Fraturas',
  'Desmaio',
  'Convulsão',
  'AVC',
];