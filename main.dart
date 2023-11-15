import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  File? _image;
  String? _name;
  int? _age;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _submitProfile() {
    setState(() {
      _name = _nameController.text;
      _age = int.tryParse(_ageController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Profile Page"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            _myinfo(),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload Profile Picture'),
            ),
            ElevatedButton(
              onPressed: _submitProfile,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myinfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_image != null)
          Image.file(
            _image!,
            width: 100,
            height: 100,
          )
        else
          Image.asset(
            'assets/profilepicture.png',
            width: 100,
            height: 100,
          ),
        SizedBox(height: 16.0),
        Text(
          'Name: ${_name ?? ""}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Age: ${_age ?? ""}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
