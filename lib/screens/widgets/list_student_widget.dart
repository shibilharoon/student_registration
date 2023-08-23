import 'dart:io';
import './edit_student.dart';
import 'package:flutter/material.dart';
import 'package:student_registration/db/functions/db_functions.dart';
import 'package:student_registration/db/model/data_model.dart';
import 'package:student_registration/screens/widgets/add_student_widgets.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Center(
          child: Text('D E T A I L S'),
        ),
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddStudentWidget()));
            },
            icon: Icon(Icons.group_add_rounded)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body:
          // Column(
          //   children: [
          // Container(
          //   margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          //   child: TextField(
          // controller:,
          //   decoration: InputDecoration(
          //     prefixIcon: const Icon(Icons.search),
          //     hintText: "Student Search",
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(20),
          //       borderSide: const BorderSide(color: Colors.white),
          //     ),
          //   ),
          // ),
          // ),
          ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              return ListTile(
                title: Text(data.name),
                subtitle: Text(data.age),
                leading: CircleAvatar(
                    backgroundImage: data.image != null
                        ? FileImage(File(data.image!))
                        : AssetImage("assets/pngegg.png") as ImageProvider),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          deleteStudent(index);
                        },
                        icon: const Icon(Icons.delete, color: Colors.black)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => edit_student(
                                index: index,
                                name: data.name,
                                age: data.age,
                                place: data.place,
                                phone: data.phone,
                                imagePath: data.image),
                          ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ))
                  ],
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        },
      ),
      // ],
    );
    // );
  }
}
