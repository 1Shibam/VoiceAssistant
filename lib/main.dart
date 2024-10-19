// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:your_assistant/pages/home_page.dart';
import 'package:your_assistant/pages/pallete.dart';

void main() {
  runApp(const MyApp());
}

bool debugShowWidgetInspector = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My-Assistant',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallete.whiteColor,
          appBarTheme: const AppBarTheme(color: Pallete.whiteColor)),
      home: const homePage(),
    );
  }
}
