import 'dart:ffi';
import 'dart:io';
import '../view_profile.dart';
import 'package:flutter/material.dart';
import 'package:student_registration/db/functions/db_functions.dart';
import 'package:student_registration/db/model/data_model.dart';
import 'package:student_registration/screens/widgets/add_student_widgets.dart';
import 'package:student_registration/screens/widgets/edit_student.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  String _search = '';
  List<StudentModel> searchedlist = [];

  loadstudent() async {
    final allstudents = await getAllStudents();

    setState(() {
      searchedlist = allstudents;
    });
  }

  @override
  void initState() {
    searchResult();
    loadstudent();
    super.initState();
  }

  void searchResult() {
    setState(() {
      searchedlist = studentListNotifier.value
          .where((StudentModel) =>
              StudentModel.name.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 56, 58),
      appBar: AppBar(
        title: Center(
          child: Text('S T U D E N T  L I S T'),
        ),

        backgroundColor: Color.fromARGB(255, 79, 24, 4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        // leading: IconButton(
        // onPressed: () {
        //   Navigator.of(context).push(
        //       MaterialPageRoute(builder: (context) => AddStudentWidget()));
        // },
        // icon: Icon(Icons.group_add_rounded)),

        // leading: IconButton(
        //     onPressed: () {
        //       TextFormField(
        //         decoration: InputDecoration(
        //             hintText: 'Search here',
        //             border: OutlineInputBorder(),
        //             fillColor: Colors.white,
        //             filled: true,
        //             prefixIcon: Icon(Icons.search),
        //             iconColor: Colors.black),
        //         onChanged: (value) {
        //           setState(() {
        //             _search = value;
        //           });
        //           searchResult();
        //         },
        //       );
        //     },
        //     icon: Icon(Icons.search)),

        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddStudentWidget()));
              },
              icon: Icon(Icons.group_add_rounded))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 24, 4), width: 2),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
                searchResult();
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = studentList[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Card(
                        color: Color.fromARGB(255, 79, 24, 4),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewStudentScreen(
                                  name: data.name,
                                  age: data.age,
                                  place: data.place,
                                  phone: data.phone,
                                  imagePath: data.image ?? "",
                                ),
                              ),
                            );
                          },
                          textColor: Colors.white,
                          title: Text(data.name),
                          subtitle: Text(data.age),
                          leading: CircleAvatar(
                              backgroundImage: data.image != null
                                  ? FileImage(File(data.image!))
                                  : AssetImage("assets/Mascot PNG.png")
                                      as ImageProvider),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    deleteStudent(index);
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Color.fromARGB(255, 255, 17, 0))),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: searchedlist.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
