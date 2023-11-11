import 'package:flutter/material.dart';

import 'screens/weather_screen.dart';

void main() {
  runApp(const WeatherVerse());
}

class WeatherVerse extends StatefulWidget {
  const WeatherVerse({super.key});

  @override
  State<WeatherVerse> createState() => _WeatherVerseState();
}

class _WeatherVerseState extends State<WeatherVerse> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Verse',
      home: WeatherScreen(),
    );
  }
}