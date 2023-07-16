import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pogodappka/features/places/presentation/views/home_screen.dart';

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
