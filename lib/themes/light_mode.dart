import 'package:flutter/material.dart';


ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
  surface: Colors.white, // <-- couleur de fond claire pour le light mode
  primary: Colors.grey.shade500,
  secondary: Colors.grey.shade200,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade700,
),
);