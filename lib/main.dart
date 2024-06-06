import 'package:flutter/material.dart';

import 'presentation/pages/Weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color.fromARGB(255, 114, 114, 114),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color.fromARGB(255, 26, 26, 26),
          primaryColor: const Color.fromARGB(255, 114, 114, 114)),
      color: const Color.fromARGB(255, 114, 114, 114),
      themeMode: ThemeMode.system,
      home: const WeatherPage(),
    );
  }
}
