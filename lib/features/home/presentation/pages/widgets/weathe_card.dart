import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/routers/router_name.dart';
import '../../../../weather/presentation/controller/weather_controller.dart';
import '../../../../weather/presentation/pages/widgets/current_weather_card.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(
      builder: (context, controller, _) {
        final weather = controller.current;

        // Loading lần đầu
        if (controller.isLoading && weather == null) {
          return _buildLoadingCard();
        }

        // Có data thì hiển thị
        if (weather != null) {
          return GestureDetector(
            onTap: () => context.go(Routes.weather),
            child: CurrentWeatherCard(weather),
          );
        }

        // Fallback
        return _buildLoadingCard();
      },
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryGreen,
        ),
      ),
    );
  }
}
