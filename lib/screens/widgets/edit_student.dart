import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_registration/db/model/data_model.dart';
import 'package:student_registration/screens/widgets/list_student_widget.dart';
import 'package:student_registration/db/functions/db_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_registration/screens/widgets/add_student_widgets.dart';
import 'package:hive/hive.dart';

class edit_student extends StatefulWidget {
  var name;
  var age;
  var place;
  var phone;
  int index;
  dynamic imagePath;

  edit_student({
    required this.index,
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.imagePath,
  });

  @override
  State<edit_student> createState() => _edit_studentState();
}

class _edit_studentState extends State<edit_student> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _placeController = TextEditingController(text: widget.place);
    _phoneController = TextEditingController(text: widget.phone);
    _selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 56, 58),
      appBar: AppBar(
        title: Text("E D I T"),
        backgroundColor: Color.fromARGB(255, 79, 24, 4),
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: const Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage("assets/Mascot PNG.png") as ImageProvider,
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: "Name",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _placeController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Class',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Address',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 79, 24, 4)),
                          onPressed: () {
                            updateall();
                          },
                          icon: Icon(Icons.done),
                          label: Text("Update")),
                      // ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.cyan,
                      //     ),
                      //     onPressed: () {
                      //       updateall();
                      //     },
                      //     child: Text("Update")),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> updateall() async {
    final name0 = _nameController.text.trim();
    final age0 = _ageController.text.trim();
    final place0 = _placeController.text.trim();
    final phone0 = _phoneController.text.trim();
    final image0 = _selectedImage!.path;

    if (name0.isEmpty ||
        age0.isEmpty ||
        place0.isEmpty ||
        phone0.isEmpty ||
        image0.isEmpty) {
      return;
    } else {
      final update = StudentModel(
          name: name0, age: age0, place: place0, phone: phone0, image: image0);

      editstudent(widget.index, update);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));
    }
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
