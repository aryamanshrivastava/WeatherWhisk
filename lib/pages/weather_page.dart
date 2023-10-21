// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService('b7df7d1c74645e5e6b5af897b020da25');
  Weather? wweather;
  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() => wweather = weather);
    } catch (e) {
      print('Error: $e');
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
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
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: h * 0.05,
                ),
                Text(wweather?.cityName ?? '',
                    style: TextStyle(
                        fontSize: h * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            Lottie.asset(
              getWeatherAnimation(wweather?.mainCondition),
            ),
            Column(
              children: [
                Text('${wweather?.temperature.round()} °C',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                // Text(wweather?.mainCondition ?? '',
                //     style: TextStyle(
                //         fontSize: 30,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
