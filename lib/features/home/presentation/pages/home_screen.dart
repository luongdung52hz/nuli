import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/constants/app_constans.dart';
import 'package:nuli_app/core/constants/app_strings.dart';
import 'package:nuli_app/features/home/presentation/pages/widgets/action_card.dart';
import 'package:nuli_app/features/home/presentation/pages/widgets/schedule_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/routers/router_name.dart';
import '../../../../core/widgets/bottom_nav_app.dart';
import '../../../weather/presentation/controller/weather_controller.dart';
import '../../../weather/presentation/pages/widgets/current_weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<WeatherController>().loadCurrentWeather(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGreen),
      );
    }

    if (controller.error != null) {
      return Center(
        child: Text(
          controller.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    final weather = controller.current;
    if (weather == null) {
      return const Center(child: Text('Đang tải thời tiết...'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName, style: AppTextStyles.headingLarge),
        backgroundColor: AppColors.primaryGreen,
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.go(Routes.weather),
              child: CurrentWeatherCard(weather),
            ),
            const SizedBox(height: 16),
            // const ScheduleCard(),
            const SizedBox(height: 20),
            const Text(
              'Quick Action',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ActionsCard(context),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavApp(currentIndex: 0),
    );
  }

}
