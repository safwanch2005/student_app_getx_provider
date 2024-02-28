import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:student_app_provider/controller/controller.dart';
import 'package:student_app_provider/home/home.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  String _text = '';

  @override
  void initState() {
    super.initState();
    ScreenProvider().getStudents();
    navigateToHome();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = IntTween(begin: 0, end: 'Student \n\t\t\t Manager'.length)
        .animate(_controller)
      ..addListener(() {
        setState(() {
          _text = 'Student \n\t\t\t Manager'.substring(0, _animation.value);
        });
      });

    _controller.forward();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const Home(),
    //   ),
    // );
    Get.to(() => const Home());
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/3325490-200.png"),
              ),
              Text(
                _text.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
