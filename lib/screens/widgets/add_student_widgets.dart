import 'dart:io';
import 'package:student_registration/screens/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_registration/db/functions/db_functions.dart';
import 'package:student_registration/db/model/data_model.dart';
import 'package:student_registration/screens/widgets/list_student_widget.dart';

class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _placeController = TextEditingController();

  final _phoneController = TextEditingController();

  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 56, 58),
      appBar: AppBar(
        title: Text('R E G I S T E R'),
        backgroundColor: Color.fromARGB(255, 79, 24, 4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        actions: [
          IconButton(
              onPressed: () {
                _refreshScreen();
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListStudentWidget()));
              },
              icon: Icon(Icons.list)),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Color.fromARGB(255, 56, 56, 58),
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : AssetImage("assets/Mascot PNG.png") as ImageProvider,
                  ),
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 79, 24, 4)),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: Icon(Icons.image),
                    label: Text("GALLERY")),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 79, 24, 4)),
                    onPressed: () {
                      _pickImageFromCam();
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text("CAMERA")),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-z,A-Z," "]'))
                      ],
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Name",
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 24, 4), width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Age",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 79, 24, 4), width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      }
                      int? age = int.tryParse(value);
                      if (age == null || age <= 0 || age > 150) {
                        return "Please enter a valid age";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    controller: _placeController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Place",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 79, 24, 4), width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Place is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      hintText: "Phone No",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 79, 24, 4), width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 79, 24, 4),
                  onPressed: () {
                    _formKey.currentState!.validate();
                    onAddStudentButtonClicked();
                  },
                  child: Icon(Icons.add),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _class = _placeController.text.trim();
    final _address = _phoneController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _class.isEmpty || _address.isEmpty) {
      return;
    }
    print('$_name $_age $_class $_address');

    final _student = StudentModel(
        name: _name,
        age: _age,
        place: _class,
        phone: _address,
        image: _selectedImage!.path);
    addStudent(_student);
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }

  _pickImageFromCam() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }

  void _refreshScreen() {
    _nameController.clear();
    _ageController.clear();
    _placeController.clear();
    _phoneController.clear();
    setState(() {
      _selectedImage = null;
    });
  }
}
