import 'package:flutter/material.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/services/weather_service.dart';
void main() {
  runApp(BlocProvider(
     create: (context) {
        return WeatherCubit(  WeatherService());
      },
    child: const WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: BlocProvider.of< WeatherCubit>(context).weatherModel == null ? Colors.blue : BlocProvider.of< WeatherCubit>(context).weatherModel!.getThemeColor(),),
      home:  const HomeView(),
    );
  }
}
