import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/weather_model.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<HourlyForecast> hourly;

  const HourlyWeatherList(this.hourly, {super.key});

  @override
  Widget build(BuildContext context) {
    if (hourly.isEmpty) {
      return const Center(
        child: Text(
          'Không có dữ liệu theo giờ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dự báo theo giờ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F1F1F),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: hourly.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = hourly[index];
                final hour = DateFormat('HH:mm').format(item.time);
                final isNow = index == 0;

                return Container(
                  width: 70,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isNow ? const Color(0xFF2196F3) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isNow ? 'Hiện tại' : hour,
                        style: TextStyle(
                          fontSize: 12,
                          color: isNow ? Colors.white : const Color(0xFF757575),
                          fontWeight: isNow ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                      Icon(
                        _getWeatherIcon(item.temperature),
                        size: 28,
                        color: isNow ? Colors.white : const Color(0xFF2196F3),
                      ),
                      Text(
                        '${item.temperature.toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isNow ? Colors.white : const Color(0xFF1F1F1F),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(double temperature) {
    if (temperature >= 30) {
      return Icons.wb_sunny;
    } else if (temperature >= 20) {
      return Icons.wb_cloudy;
    } else {
      return Icons.cloud;
    }
  }
}