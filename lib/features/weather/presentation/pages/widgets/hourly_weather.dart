import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/weather_model.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<HourlyForecast> hourly;

  const HourlyWeatherList(this.hourly, {super.key});

  @override
  Widget build(BuildContext context) {
    if (hourly.isEmpty) {
      return const Text('Không có dữ liệu theo giờ');
    }

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: hourly.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = hourly[index];
          final hour = DateFormat('HH:mm').format(item.time);

          return Container(
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(hour, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Text(
                  '${item.temperature.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
