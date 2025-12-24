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

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     context.read<WeatherController>().loadCurrentWeather();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final controller = context.read<WeatherController>();
    // final weather = controller.current!;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName, style: AppTextStyles.headingLarge),
        backgroundColor: AppColors.primaryGreen,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white,),
            onPressed: () => (),
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // GestureDetector(
            //   child: CurrentWeatherCard(weather),
            //   onTap: (){
            //     context.go(Routes.weather);
            //     },
            // ),
            const SizedBox(height: 16),
            ScheduleCard(),
            const SizedBox(height: 20),
            const Text(
              "Quick Acti",
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
