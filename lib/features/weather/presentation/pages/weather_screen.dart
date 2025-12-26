import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/current_weather_card.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/daily_weather.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/hourly_weather.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/weather_details.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../controller/weather_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final weather = controller.current!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Thời tiết hôm nay',
        onBack: () => context.go('/home'),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadCurrentWeather(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CurrentWeatherCard(weather),
            const SizedBox(height: 16),
            WeatherDetails(weather),
            const SizedBox(height: 16),
            HourlyWeatherList(controller.hourly),
            const SizedBox(height: 16),
            DailyWeatherList(controller.daily),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
