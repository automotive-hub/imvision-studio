import 'package:flutter/material.dart';

import 'dashboard.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovation Q1 - 2023',
      theme: ThemeData.light(useMaterial3: true,),
      home: const DashboardScreen(),
    );
  }
}
