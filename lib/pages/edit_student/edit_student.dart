import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/controller.dart';
import 'package:student_app_provider/model/model.dart';

class EditStudent extends StatelessWidget {
  EditStudent(
      {super.key,
      required this.name,
      required this.age,
      required this.rollNo,
      required this.parentNum,
      required this.image,
      required this.id});
  final _formKey = GlobalKey<FormState>();
  final _nameEdditingController = TextEditingController();
  final _ageEdditingController = TextEditingController();
  final _rollNoEdditingController = TextEditingController();
  final _parentNumberEdditingController = TextEditingController();
  final int id;

  final String name;
  final String age;
  final String rollNo;
  final String parentNum;
  final String image;
  @override
  Widget build(BuildContext context) {
    _nameEdditingController.text = name;
    _ageEdditingController.text = age;
    _rollNoEdditingController.text = rollNo;
    _parentNumberEdditingController.text = parentNum;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Consumer<ScreenProvider>(
            builder: (BuildContext context, screenProvider, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Text(
                  "ADD NEW\n\t\t\tSTUDENT",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 50,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: TextFormField(
                    controller: _nameEdditingController,
                    style: GoogleFonts.poppins(color: Colors.black),
                    textAlign: TextAlign.center,
                    validator: (value) =>
                        value!.isEmpty ? "enter student name" : null,
                    decoration: InputDecoration(
                      hintText: 'student name',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: TextFormField(
                    controller: _rollNoEdditingController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(color: Colors.black),
                    textAlign: TextAlign.center,
                    validator: (value) =>
                        value!.isEmpty ? "enter student age" : null,
                    decoration: InputDecoration(
                      hintText: 'roll number',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: TextFormField(
                    controller: _ageEdditingController,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? "enter roll number" : null,
                    style: GoogleFonts.poppins(color: Colors.black),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'age',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: TextFormField(
                    controller: _parentNumberEdditingController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.poppins(color: Colors.black),
                    textAlign: TextAlign.center,
                    validator: (value) =>
                        value!.isEmpty ? "enter parent number" : null,
                    decoration: InputDecoration(
                      hintText: 'parent mobile number',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1, color: Colors.black45),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      screenProvider.image.isEmpty
                          ? IconButton(
                              onPressed: () async {
                                await screenProvider.pickImage();
                              },
                              icon: const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.black45),
                            )
                          : const SizedBox(),
                      screenProvider.image.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(screenProvider.image),
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              ),
                            )
                          : const SizedBox(),
                      screenProvider.image.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                screenProvider.clearImage();
                              },
                              icon: const Icon(Icons.highlight_remove,
                                  color: Colors.black45),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final data = StudentModel(
                              id: id,
                              name: _nameEdditingController.text,
                              age: int.parse(_ageEdditingController.text),
                              rollNo: int.parse(_rollNoEdditingController.text),
                              parentNumber: int.parse(
                                  _parentNumberEdditingController.text),
                              image: screenProvider.image);
                          await context
                              .read<ScreenProvider>()
                              .editStudent(data);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Updated Successfully'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black38)),
                      child: const Text("Add"),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
