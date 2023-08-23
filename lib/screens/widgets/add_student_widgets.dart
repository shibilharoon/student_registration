import 'dart:io';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Center(
          child: Text('R E G I S T E R'),
        ),
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        actions: [
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(7),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage("assets/pngegg.png") as ImageProvider,
                ),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  icon: Icon(Icons.image),
                  label: Text("GALLERY")),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    _pickImageFromCam();
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("CAMERA")),
              // MaterialButton(
              //     color: Colors.cyan,
              //     child: Text(
              //       "Gallery",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 16,
              //       ),
              //     ),
              //     onPressed: () {
              //       _pickImageFromGallery();
              //     }),
              // MaterialButton(
              //     color: Colors.cyan,
              //     child: Text(
              //       "Camera",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 16,
              //       ),
              //     ),
              //     onPressed: () {
              //       _pickImageFromCam();
              //     }),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: "Name"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: "Age"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: "Place"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: "phone no"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                backgroundColor: Colors.cyan,
                onPressed: onAddStudentButtonClicked,
                child: Icon(Icons.add),
              ),
              // IconButton(
              //   onPressed: () {
              //     onAddStudentButtonClicked();
              //   },
              //   icon: Icon(Icons.add),
              //   color: Colors.white,
              // ),
              // ElevatedButton.icon(
              //     onPressed: () {
              //       onAddStudentButtonClicked();
              //     },
              //     style: ElevatedButton.styleFrom(primary: Colors.red),
              //     icon: const Icon(Icons.add),
              //     label: const Text('Add Student')),
              const SizedBox(
                height: 10,
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ListStudentWidget(),
              //       ));
              //     },
              //     style: ElevatedButton.styleFrom(primary: Colors.red),
              //     child: const Text("View List")),
            ],
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
}
