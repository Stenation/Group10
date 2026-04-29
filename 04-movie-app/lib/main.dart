import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(
        title: 'Movies',
        movieUri:
            'https://git.fiw.fhws.de/introduction-to-flutter-2025ss/unit-07-http-and-bloc/-/raw/329759b27023c59828215b51dd081b58c5c07d50/http_demo/movie_data.json',
      ),
    );
  }
}
