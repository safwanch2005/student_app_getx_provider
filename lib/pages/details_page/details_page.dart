import 'dart:io';

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String age;
  final String rollNo;
  final String parentNum;
  final String image;

  const DetailsPage(
      {super.key,
      required this.name,
      required this.age,
      required this.rollNo,
      required this.parentNum,
      required this.image});

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    // Widget imageWidget = image != null
    //     ? ClipOval(
    //         child: Image.file(File(image),width: 50,height: 50,fit: BoxFit.cover,),
    //       )
    //     : Container();

    // ignore: unnecessary_null_comparison
    Widget imageProfileWidget = image != null
        ? ClipOval(
            child: Image.file(
              File(image),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        : Container();

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: ListTile(
          title: Text(
            name,
            style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: 'Raleway-VariableFont_wght',
                fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            imageProfileWidget,
            const SizedBox(
              height: 50,
            ),
            Text(
              'Name : $name',
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Raleway-VariableFont_wght',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Age : $age',
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Raleway-VariableFont_wght',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Roll Number : $rollNo',
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Raleway-VariableFont_wght',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Parent Number : $parentNum',
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Raleway-VariableFont_wght',
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
