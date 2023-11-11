import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherverse/models/weather_models.dart';
import 'package:weatherverse/services/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Api key
  final _weatherService = WeatherService('a15d9f8a11c87828e30c2c4d1bdd2e28');
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    // Get the current city
    String cityName = await _weatherService.getCurrentCity();

    // Get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      null;
    }
  }

  // Weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // Fetch weather on startup
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252425),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City name
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _weather?.cityName.toUpperCase() ?? 'Loading city...',
                style: GoogleFonts.fjallaOne(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Animation
              Lottie.asset(
                getWeatherAnimation(_weather?.mainCondition),
              ),
              const SizedBox(
                height: 50,
              ),
              // Temperature
              Text(
                '${_weather?.temperature.round()}°C',
                style: GoogleFonts.fjallaOne(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 35),
                ),
              ),
              Text(
                _weather?.mainCondition ?? '',
                style: GoogleFonts.fjallaOne(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
