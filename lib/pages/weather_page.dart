import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey: '3dfd5810880e38017a14a82726d3c958');
  Weather? _weather;

  // Fetches weather and updates state variable
  void _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? condition) {
    switch (condition?.toLowerCase()) {
      case 'clear':
        return "assets/sunny.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/clouds_2.json';
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City
              Text(
                _weather?.cityName ?? "City loading...",
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.amberAccent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Lottie.asset(getWeatherAnimation(_weather?.condition)),
              const SizedBox(
                height: 20,
              ),
              // Temperature
              Text(
                '${_weather?.temp.round() ?? "Loading..."} °C',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                ),
              ),
              // Weather condition
              Text(
                _weather?.condition ?? "Loading...",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}