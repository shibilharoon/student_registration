import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_registration/db/model/data_model.dart';
import './widgets/list_student_widget.dart';

class ViewStudentScreen extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String phone;
  final String imagePath;

  const ViewStudentScreen({
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 56, 58),
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        backgroundColor: Color.fromARGB(255, 79, 24, 4),
        title: Text('P R O F I L E'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 79, 24, 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: FileImage(File(imagePath)),
              ),
            ),
            SizedBox(height: 30),
            CardItem(
              title: 'Name',
              content: name,
              isAlternate: false,
            ),
            CardItem(
              title: 'Age',
              content: age,
              isAlternate: true,
            ),
            CardItem(
              title: 'Place',
              content: place,
              isAlternate: false,
            ),
            CardItem(
              title: 'Phone',
              content: phone,
              isAlternate: true,
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String content;
  final bool isAlternate;

  const CardItem({
    required this.title,
    required this.content,
    required this.isAlternate,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isAlternate ? Colors.white : Color.fromARGB(255, 79, 24, 4);
    final textColor =
        isAlternate ? Color.fromARGB(255, 79, 24, 4) : Colors.white;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: bgColor,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
