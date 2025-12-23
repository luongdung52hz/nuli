import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_constans.dart';
import 'package:provider/provider.dart';

import '../../../../core/routers/router_name.dart';
import '../../../../core/widgets/bottom_nav_app.dart';
import '../../../../core/widgets/button_app.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../widgets/action_card.dart';
import '../widgets/schedule_card.dart';
import '../widgets/weathe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    if (auth.user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF7),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(AppConstants.appName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeatherCard(),
            const SizedBox(height: 16),
            ScheduleCard(),
            const SizedBox(height: 20),
            const Text(
              "Quick Actions",
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
