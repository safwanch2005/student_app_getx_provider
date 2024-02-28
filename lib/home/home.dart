import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:student_app_provider/controller/controller.dart';
import 'package:student_app_provider/controller/index_provider.dart';
import 'package:student_app_provider/pages/add_student_page/add_student.dart';
import 'package:student_app_provider/pages/grid_view/grid_view.dart';
import 'package:student_app_provider/pages/list_view/list_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    const ListViewPage(),
    GridViewPage(),
    AddStudentPage(),
  ];
  final indexController = Get.put(IndexProvider());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              " STUDENT MANAGER",
              style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            Consumer<ScreenProvider>(
              builder: (BuildContext context, screenProvider, _) => Text(
                "Total : ${screenProvider.allStudentList.length} ",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<IndexProvider>(builder: (i) {
        return Container(child: pages[i.index]);
      }),
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: GNav(color: Colors.black, tabs: [
        GButton(
          backgroundColor: Colors.black12,
          icon: Icons.list_rounded,
          text: 'List View',
          onPressed: () {
            indexController.changeIndex(0);
          },
        ),
        GButton(
          backgroundColor: Colors.black26,
          icon: Icons.grid_view_rounded,
          text: 'Grid View',
          onPressed: () {
            indexController.changeIndex(1);
          },
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white30,
          onPressed: () {
            Get.to(() => AddStudentPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }
}
