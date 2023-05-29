// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _mainPage();
  }

  _mainPage() async {
    await Future.delayed(
      const Duration(milliseconds: 2900),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => QuizApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: const [
            Image(
              height: 500,
              width: 300,
              image: AssetImage('images/splash.png'),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
