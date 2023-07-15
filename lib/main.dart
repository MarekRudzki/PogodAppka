import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pogodappka/screens/home_screen/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const MaterialApp(
      title: 'Pogodappka',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
