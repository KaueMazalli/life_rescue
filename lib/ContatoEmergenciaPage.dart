import 'package:flutter/material.dart';

class EmergencyContactAddPage extends StatefulWidget {
  @override
  _EmergencyContactAddPageState createState() => _EmergencyContactAddPageState();
}

class _EmergencyContactAddPageState extends State<EmergencyContactAddPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContact() {
    // Aqui você pode adicionar lógica para salvar o contato no banco de dados, etc.
    String name = _nameController.text;
    String phone = _phoneController.text;
    print('Nome: $name, Telefone: $phone');

    // Após salvar, você pode navegar para outra página ou realizar outra ação
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato de Emergência'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text('Salvar Contato'),
            ),
          ],
        ),
      ),
    );
  }
}
