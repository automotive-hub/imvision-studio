import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imvision_studio/screens/test.dart';

import 'dashboard.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovation Q1 - 2023',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(textTheme: GoogleFonts.montserratTextTheme()),
      home: const DashBoardTest(),
    );
  }
}
