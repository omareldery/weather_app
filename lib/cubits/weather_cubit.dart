import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_state.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';


class WeatherCubit extends Cubit<WeatherState> {
  WeatherService weatherService;
  WeatherModel? weatherModel;
  String? cityName ;
  WeatherCubit(this.weatherService) : super(WeatherInitial());

  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
   WeatherModel weatherModel =
   await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccess(weatherModel: weatherModel));
    } on Exception catch (e) {
      emit(WeatherFailure());
    }
  }
}
