import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(EmergencyNumbersApp());
}

class EmergencyNumbersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Números de Emergência',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmergencyNumbersScreen(),
    );
  }
}

class EmergencyNumbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Números de Emergência'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            EmergencyNumberCard(
              title: 'SAMU',
              number: '192',
            ),
            SizedBox(height: 20),
            EmergencyNumberCard(
              title: 'Bombeiros',
              number: '193',
            ),
            SizedBox(height: 20),
            EmergencyNumberCard(
              title: 'Polícia',
              number: '190',
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyNumberCard extends StatelessWidget {
  final String title;
  final String number;

  const EmergencyNumberCard({
    Key? key,
    required this.title,
    required this.number,
  }) : super(key: key);

  void _launchPhone(BuildContext context) {
    String url = 'tel:$number';
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => _launchPhone(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                number,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
