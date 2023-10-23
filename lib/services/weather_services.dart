import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/forecast_model.dart';
import 'package:weather/model/weather_model.dart';

class WeatherService {
  Future<WeatherApiModel?> getWeatherByLatLon(
    final double lat,
    final double long,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${lat.toString()}&lon=${long.toString()}&appid=1122616b7ce77385de46d050b9a97eac&units=metric"));
      return WeatherApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<WeatherApiModel?> getWeatherByCity(
    final String city,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=b7df7d1c74645e5e6b5af897b020da25&units=metric"));
      return WeatherApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<WeatherForecastApiModel?> getForecastByLatLon(
    final double lat,
    final double long,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?lat=${lat.toString()}&lon=${long.toString()}&appid=b7df7d1c74645e5e6b5af897b020da25&units=metric"));
      return WeatherForecastApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<WeatherForecastApiModel?> getForecastByCity(
    final String city,
  ) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=b7df7d1c74645e5e6b5af897b020da25&units=metric"));
      return WeatherForecastApiModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
