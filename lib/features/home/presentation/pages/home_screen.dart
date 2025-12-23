import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_constans.dart';
import 'package:provider/provider.dart';

import '../../../../core/routers/router_name.dart';
import '../../../../core/widgets/button_app.dart';
import '../../../auth/presentation/provider/auth_controller.dart';

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
            _weatherCard(),
            const SizedBox(height: 16),
            _todaySchedule(),
            const SizedBox(height: 20),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _quickActions(context),
            Consumer<AuthController>(
              builder: (context, auth, child) {
                return CustomButton(
                    isLoading: auth.isLoading,
                    text: 'Đăng xuất',
                    onPressed: () async {
                      await auth.signOut();
                      context.go(Routes.login);
                    }
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // ================= WEATHER =================
  Widget _weatherCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.wb_sunny, size: 40, color: Colors.orange),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Today Weather",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Temperature: 30°C"),
              Text("Humidity: 65%"),
            ],
          ),
        ],
      ),
    );
  }

  // ================= SCHEDULE =================
  Widget _todaySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Farming Schedule",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const Icon(Icons.agriculture, color: Colors.green),
            title: const Text("Watering vegetables"),
            subtitle: const Text("06:00 AM"),
            trailing: const Icon(Icons.check_circle_outline),
          ),
        ),
      ],
    );
  }

  // ================= QUICK ACTIONS =================
  Widget _quickActions(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _actionItem(Icons.chat, "Chat AI"),
        _actionItem(Icons.video_library, "Videos"),
        _actionItem(Icons.calendar_month, "Schedule"),
        _actionItem(Icons.person, "Profile"),
      ],
    );
  }

  Widget _actionItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.green),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

}
