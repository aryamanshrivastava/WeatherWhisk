import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherService {
  // ignore: constant_identifier_names
  static const Base_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apikey;
  WeatherService(this.apikey);
  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse("$Base_URL?q=$cityName&appid=$apikey&units=metric"));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error getting weather");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .timeout(const Duration(seconds: 5));
    String city =
        await placemarkFromCoordinates(position.latitude, position.longitude)
            .then((List<Placemark> placemarks) => placemarks.first.locality!);
    if (city == "Kattankulathur") {
      city = "Chengalpattu";
    }
    return city;
  }
}
