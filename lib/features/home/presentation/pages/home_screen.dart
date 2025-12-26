import 'package:flutter/material.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/constants/app_constans.dart';
import 'package:nuli_app/core/constants/app_strings.dart';
import 'package:nuli_app/features/home/presentation/pages/widgets/action_card.dart';
import 'package:nuli_app/features/home/presentation/pages/widgets/schedule_card.dart';
import 'package:nuli_app/features/home/presentation/pages/widgets/weathe_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/bottom_nav_app.dart';
import '../../../article/presentation/pages/list_article.dart';
import '../../../weather/presentation/controller/weather_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherController>().loadCurrentWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppConstants.appName, style: AppTextStyles.headingLarge),
        backgroundColor: AppColors.primaryGreen,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            )
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<WeatherController>().loadWeatherCurrentLocation(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherSection(),
              const SizedBox(height: 20),

              // const Text(
              //   'Quick Action',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 12),
              // ActionsCard(context),

              const SizedBox(height: 20),

              ArticleListScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavApp(currentIndex: 0),
    );
  }
}