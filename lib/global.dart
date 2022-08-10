import 'package:flutter/material.dart';

final myGradient = BoxDecoration(
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
  gradient: const LinearGradient(colors: [
    Color(0xFF34D1C2),
    Color(0xFF31A6DC)
    // Colors.blue,
    // Color.fromARGB(255, 70, 93, 105)
  ]),
);
const backgroundColor = Color.fromARGB(255, 70, 93, 105);
final buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.transparent, shadowColor: Colors.transparent);
