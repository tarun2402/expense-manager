import 'dart:async';
import 'package:expense_app/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.grey[200],
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(),
      title: new Text(
        'Expense_Manager',
        textScaleFactor: 2,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.blue[800],
            letterSpacing: .5,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      image: Image.asset('assets/images/exp.jpg'),
      loadingText: Text(
        "Loading",
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.blue[800],
            letterSpacing: .5,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      photoSize: 150.0,
      loaderColor: Colors.blue[800],
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}
