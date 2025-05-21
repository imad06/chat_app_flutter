import 'package:chaty/pages/register_page.dart';
import 'package:flutter/material.dart';
//import 'pages/Login_page.dart'; // <-- L majuscule ici
import 'package:chaty/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
      theme: lightMode,
    );
  }
}