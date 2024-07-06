import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(
    apiKey: "4e6dcf3c6e6fbb908367af4f66ba4c10",
  );
  Weather? _weather;

  _fetchWeather() async {
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

  String getCondition(String? mainCondition) {
    if (mainCondition == null) return "assets/Sunny.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
        return "assets/Clouds.json";
      case "rain":
        return "assets/Rain.json";
      case "thunderstorm":
        return "assets/Thunderstorm.json";
      case "clear":
        return "assets/Sunny.json";
      default:
        return "assets/Sunny.json";
    }
  }

  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              const Icon(
                Icons.location_pin,
                color: Colors.white70,
              ),
              Text(
                _weather?.cityName.toUpperCase() ?? "loading city...",
                style: GoogleFonts.anton(
                  fontSize: 20.0,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              Lottie.asset(
                getCondition(
                  _weather!.mainCondition,
                ),
              ),
              const Spacer(),
              Text(
                "${_weather!.temperature.round()}°",
                style: GoogleFonts.anton(
                  color: Colors.grey[700],
                  fontSize: 25.0,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
