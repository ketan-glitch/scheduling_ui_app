import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/controller.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool change = false;
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      Get.lazyPut(() => ConsultationController());
      var nav = Navigator.of(context);
      await Future.delayed(const Duration(seconds: 1));
      change = !change;
      setState(() {});
      await Future.delayed(const Duration(seconds: 2));
      nav.pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const Spacer(),
          FlutterLogo(
            size: 200,
            duration: const Duration(seconds: 2),
            style: change ? FlutterLogoStyle.horizontal : FlutterLogoStyle.markOnly,
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            "Doctor Schedule app",
            style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
