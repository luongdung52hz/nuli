import 'package:flutter/material.dart';
import 'package:nuli_app/core/services/location_service.dart';

import '../../data/models/weather_model.dart';
import '../../data/repositories/weather_repository.dart';

class WeatherController extends ChangeNotifier {
  final WeatherRepository _repository;
  late final LocationService _locationService;


  WeatherController(this._repository, this._locationService);

  bool _isLoading = false;
  String? _error;
  String? _locationLabel;

  WeatherModel? _current;
  List<DailyForecast> _daily = [];
  List<HourlyForecast> _hourly = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get locationLabel => _locationLabel;

  WeatherModel? get current => _current;
  List<DailyForecast> get daily => _daily;
  List<HourlyForecast> get hourly => _hourly;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void setError(String? value) {
    _error = value;
    notifyListeners();
  }

  Future<void> loadWeatherCurrentLocation() async{
    setLoading(true);
    try {
      setError(null);
      var position = await _locationService.getCurrentPosition() ;

      await loadForecast(
        position.latitude,
        position.longitude,
      );
    }
    catch (e) {
    setError(e.toString());
    } finally {
    setLoading(false);
    }
  }
  
  Future<void> loadCurrentWeather({
    double? latitude,
    double? longitude,
  }) async {
    setLoading(true);

    try {
      setError(null);
      _current = await _repository.getCurrentWeather(
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      setError(e.toString()) ;
    } finally {
      setLoading(false);
    }
  }
  

  /// Load full forecast (current + daily + hourly)
  Future<void> loadForecast(
      double latitude,
      double longitude,
      ) async {
    setLoading(true);

    try {
      setError(null);

      final result = await _repository.getForecast(latitude, longitude);

      _current = result.current;
      _daily = result.daily;
      _hourly = result.hourly;
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
