import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContact {
  String name;
  String phone;

  EmergencyContact({required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      name: map['name'],
      phone: map['phone'],
    );
  }
}

class EmergencyContactAddPage extends StatefulWidget {
  @override
  _EmergencyContactAddPageState createState() =>
      _EmergencyContactAddPageState();
}

class _EmergencyContactAddPageState extends State<EmergencyContactAddPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  List<EmergencyContact> _emergencyContacts = [];
  bool _showFields = false;
  bool _isEditing = false;
  int _editIndex = -1;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.5),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _loadContacts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadContacts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final contactsData = prefs.getStringList('contacts');
    if (contactsData != null) {
      setState(() {
        _emergencyContacts = contactsData
            .map((contact) => EmergencyContact.fromMap(
                  json.decode(contact),
                ))
            .toList();
      });
    }
  }

  void _saveContacts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final contactsData = _emergencyContacts.map((contact) {
      return json.encode(contact.toMap());
    }).toList();
    prefs.setStringList('contacts', contactsData);
  }

  void _toggleFieldsVisibility() {
    setState(() {
      _showFields = !_showFields;
      _isEditing = false;
      _editIndex = -1;
      if (_showFields) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _saveContact() {
    String name = _nameController.text;
    String phone = _phoneController.text;

    if (_isEditing) {
      _emergencyContacts[_editIndex] =
          EmergencyContact(name: name, phone: phone);
    } else {
      _emergencyContacts.add(EmergencyContact(name: name, phone: phone));
    }

    _nameController.clear();
    _phoneController.clear();

    _saveContacts();

    setState(() {
      _showFields = false;
      _isEditing = false;
      _editIndex = -1;
    });
  }

  void _editContact(int index) {
    setState(() {
      _nameController.text = _emergencyContacts[index].name;
      _phoneController.text = _emergencyContacts[index].phone;
      _showFields = true;
      _isEditing = true;
      _editIndex = index;
      _animationController.forward();
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _emergencyContacts.removeAt(index);
      _saveContacts();
    });
  }

  void _callContact(String phone) async {
  String url = 'tel:$phone';
  print('Tentando discar para $phone');
  
  try {
    await launch(url);
  } catch (e) {
    print('Erro ao tentar discar: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos de Emergência'),
      ),
      floatingActionButton: _emergencyContacts.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: _toggleFieldsVisibility,
              child: Icon(_showFields ? Icons.close : Icons.add),
            ),
      body: _emergencyContacts.isEmpty
          ? Center(
              child: SlideTransition(
                position: _slideAnimation,
                child: GestureDetector(
                  onTap: _toggleFieldsVisibility,
                  child: Icon(
                    Icons.add_circle,
                    size: 100.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: _emergencyContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_emergencyContacts[index].name),
                  subtitle: Text(_emergencyContacts[index].phone),
                  onTap: () {
                    _callContact(_emergencyContacts[index].phone);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editContact(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteContact(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomSheet: _showFields
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _saveContact,
                    child: Text(_isEditing ? 'Editar Contato' : 'Salvar Contato'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
