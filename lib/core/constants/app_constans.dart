import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();
  static const String appName = 'NULI';
  static final String apiKeyAI = dotenv.env['APIKEY_GEMINI'] ?? '';
  static final String apiKeyWeather = dotenv.env['APIKEY_WEATHER'] ?? '';
  static final String apiKeyYoutube = dotenv.env['APIKEY_YOUTUBE'] ?? '';
  static const String aiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';
  static const String weatherUrl = 'https://api.weatherapi.com/v1';
  static const String defaultCity = 'Ha Noi';


  static const Duration requestTimeout = Duration(seconds: 10);

}
