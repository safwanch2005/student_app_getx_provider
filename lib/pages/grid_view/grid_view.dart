import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/controller.dart';
import 'package:student_app_provider/pages/details_page/details_page.dart';

// ignore: must_be_immutable
class GridViewPage extends StatelessWidget {
  GridViewPage({super.key});
  TextEditingController searchCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenProvider>(
      builder: (BuildContext context, screenProvider, _) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            child: TextFormField(
              controller: searchCont,
              onChanged: (value) async {
                await context.read<ScreenProvider>().searchStudent(value);
              },
              style: GoogleFonts.poppins(color: Colors.black),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'search students',
                hintStyle:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(33.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: screenProvider.allStudentList.isEmpty
                ? Center(
                    child: Text(
                      "No Data",
                      style: GoogleFonts.poppins(
                          fontSize: 50, color: Colors.black38),
                    ),
                  )
                : GridView.builder(
                    itemCount: screenProvider.allStudentList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final data = screenProvider.allStudentList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return DetailsPage(
                                name: data.name,
                                age: data.age.toString(),
                                rollNo: data.rollNo.toString(),
                                parentNum: data.parentNumber.toString(),
                                image: data.image);
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(
                                color: Colors.black26,
                                width: 1), // Border properties
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.deepPurple,
                                backgroundImage: FileImage(File(data.image)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                data.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Age: ${data.age}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                "Roll No : ${data.rollNo}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
