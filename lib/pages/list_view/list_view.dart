import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/controller.dart';
import 'package:student_app_provider/pages/details_page/details_page.dart';
import 'package:student_app_provider/pages/edit_student/edit_student.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
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
                : ListView.builder(
                    itemCount: screenProvider.allStudentList.length,
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
                                color: Colors.black45,
                                width: 1), // Border properties
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 32,
                              backgroundImage: FileImage(File(data.image)),
                            ),
                            title: Text(
                              data.name,
                              style: GoogleFonts.poppins(fontSize: 23),
                            ),
                            subtitle: Text("age : ${data.age.toString()}",
                                style:
                                    GoogleFonts.poppins(color: Colors.black54)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    screenProvider.updateImage(data.image);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return EditStudent(
                                          id: data.id!,
                                          name: data.name,
                                          age: data.age.toString(),
                                          rollNo: data.rollNo.toString(),
                                          parentNum:
                                              data.parentNumber.toString(),
                                          image: data.image);
                                    }));
                                  },
                                  child: const Icon(Icons.edit_outlined),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () async {
                                    await screenProvider
                                        .deleteStudent(data.id!);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
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
