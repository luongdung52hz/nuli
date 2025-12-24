class WeatherModel{
  const WeatherModel({
    required this.name,
    required this.temperature,
    required this.condition,
    required this.low,
    required this.high,
    required this.lastUpdated,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.sunrise,
    required this.sunset,
    required this.weatherCode,
 });

  final String name;
  final double temperature;
  final double low;
  final double high;
  final String condition;
  final DateTime lastUpdated;
  final int humidity;
  final double windSpeed;
  final double precipitation;
  final String sunrise;
  final String sunset;
  final int weatherCode;

  WeatherModel copyWith({
    String? name,
    double? temperature,
    double? low,
    double? high,
    String? condition,
    DateTime? lastUpdated,
    int? humidity,
    double? windSpeed,
    double? precipitation,
    String? sunrise,
    String? sunset,
    int? weatherCode,
 }) {
    return WeatherModel(
        name: name ?? this.name,
        temperature: temperature ?? this.temperature,
        condition: condition ?? this.condition,
        low: low ?? this.low,
        high: high ?? this.high,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        humidity: humidity ?? this.humidity,
        windSpeed: windSpeed ?? this.windSpeed,
        precipitation: precipitation ?? this.precipitation,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        weatherCode: weatherCode ?? this.weatherCode
    );
  }
}

//Theo ngày
class DailyForecast{
  const DailyForecast({
   required this.date,
   required this.low,
   required this.high,
   required this.weatherCode,
});

  final DateTime date;
  final double low;
  final double high;
  final int weatherCode;
}

//Theo giờ
class HourlyForecast{
  const HourlyForecast({
   required this.time,
   required this.temperature,
   required this.weatherCode,
});

  final DateTime time;
  final double temperature;
  final int weatherCode;
}