
import 'package:buspassfinal/WelcomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(64, 147, 206, 100)),

      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

