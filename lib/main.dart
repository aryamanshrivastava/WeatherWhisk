// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/services/weather_services.dart';

import 'pages/weather_cubit.dart';
import 'pages/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherService(),
      child: BlocProvider(
        create: (context) => WeatherCubit(context.read<WeatherService>()),
        child: MaterialApp(
            theme: ThemeData(fontFamily: "Comfortaa"), home: WeatherPage()),
      ),
    );
  }
}
