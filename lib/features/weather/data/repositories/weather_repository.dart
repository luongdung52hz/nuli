import 'package:nuli_app/core/services/weather_service.dart';
import 'package:nuli_app/features/weather/data/models/weather_model.dart';

class WeatherRepository{
   final WeatherService _weatherService;
   WeatherRepository(this._weatherService, );


   Future<WeatherModel> getCurrentWeather({
     double? latitude,
     double? longitude,
   }){
     return _weatherService.fetchCurrentWeather(
       latitude: latitude,
       longitude: longitude,
     );
   }

   Future<WeatherModel> getCurrentWeatherForLocation(
       double latitude,
       double longitude,
       ){
     return _weatherService.fetchCurrentWeatherFor(
       latitude,
       longitude,);
   }

   Future<({
   WeatherModel current,
   List<DailyForecast> daily,
   List<HourlyForecast> hourly,
   })> getForecast(
       double latitude,
       double longitude,
       ) {
     return _weatherService.fetchForecastFor(latitude, longitude);
   }

}