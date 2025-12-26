import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class CurrentWeatherCard extends StatelessWidget {
  final weather;

  const CurrentWeatherCard(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0,2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tên địa điểm
          Text(
            weather.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),

          // Nhiệt độ chính
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather.temperature.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                  height: 1,
                ),
              ),
              const Text(
                '°',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkText,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Tình trạng thời tiết
          Text(
            weather.condition,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),

          // Nhiệt độ cao/thấp
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.paleGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_upward,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${weather.high}°',
                  style: const TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(
                  Icons.arrow_downward,
                  color: Colors.blue,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${weather.low}°',
                  style: const TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}