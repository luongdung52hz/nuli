import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/current_weather_card.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/weather_details.dart';
import 'package:provider/provider.dart';

import '../controller/weather_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<WeatherController>().loadWeatherCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thời tiết hôm nay'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: _buildBody(controller),
    );
  }

  Widget _buildBody(WeatherController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen,));
    }

    if (controller.error != null) {
      return Center(
        child: Text(
          controller.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (controller.current == null) {
      return const Center(child: Text('Không có dữ liệu thời tiết'));
    }

    final weather = controller.current!;

    return RefreshIndicator(
      onRefresh: () => controller.loadCurrentWeather(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CurrentWeatherCard(weather),
          const SizedBox(height: 16),
          WeatherDetails(weather),
        ],
      ),
    );
  }
}
