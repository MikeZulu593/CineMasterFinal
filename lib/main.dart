import 'package:flutter/material.dart';
import 'screens/bienvenida_screen.dart';

void main() {
  runApp(const CineMasterApp());
}

class CineMasterApp extends StatelessWidget {
  const CineMasterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineMaster',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const BienvenidaScreen(),
    );
  }
}
