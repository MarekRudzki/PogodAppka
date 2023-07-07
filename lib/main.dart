import 'package:flutter/material.dart';
import 'package:pogodappka/screens/home_screen/home_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Pogodappka',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
