import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchView extends StatelessWidget {
  String? cityName;

  SearchView({super.key, this.cityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context).getWeather(
                cityName: cityName!,
              );
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
              decoration:
              InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                label: const Text('search'),
                suffixIcon: GestureDetector(
                    onTap: () async {
                      WeatherService service = WeatherService();

                      WeatherModel? weather = await service.getWeather(cityName: cityName!);

                      BlocProvider.of<WeatherCubit>(context, listen: false).weatherModel = weather;
                      BlocProvider.of<WeatherCubit>(context, listen: false).cityName = cityName;

                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.search)),
                border: const OutlineInputBorder(),
                hintText: 'Enter a city',
              ),
            ),

          ),
        ),
      );

  }
}
