import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/pages/weather_cubit.dart';

import '../widgets/custom_divider.dart';
import '../widgets/styles.dart';
import 'weather_state.dart';
import 'screens/detailed_forecast.dart';
import 'screens/todays_weather.dart';
import 'screens/weather_details.dart';
import 'screens/weather_forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    super.key,
  });

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool _isAnyDialogActive = false;

  @override
  void initState() {
    context.read<WeatherCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocListener<WeatherCubit, WeatherState>(
      listener: (context, state) async {
        if (state.errorMessage.isNotEmpty && !_isAnyDialogActive) {
          setState(() {
            _isAnyDialogActive = true;
          });
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: Column(
                  children: [
                    Text(state.errorMessage),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          if (mounted) {
            context.read<WeatherCubit>().resetErrorMessage();
          }

          _isAnyDialogActive = false;
        }
      },
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text("Weather Whisk"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              elevation: 0.0,
            ),
            body: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                          color: Colors.black, size: 100));
                }
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: state.background,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 0.05, vertical: h * 0.05),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: h * 0.05),
                                TodaysWeather(),
                                CustomDivider(),
                                SizedBox(height: Styles.defaultDividerSpace),
                                WeatherDetails(),
                                SizedBox(height: Styles.defaultDividerSpace),
                                CustomDivider(),
                                SizedBox(height: Styles.defaultDividerSpace),
                                WeatherForecast(),
                                SizedBox(height: Styles.defaultDividerSpace),
                                DetailedForecast()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
