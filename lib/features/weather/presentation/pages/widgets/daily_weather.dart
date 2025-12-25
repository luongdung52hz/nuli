import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/weather_model.dart';

class DailyWeatherList extends StatelessWidget {
  final List<DailyForecast> daily;

  const DailyWeatherList(this.daily, {super.key});

  @override
  Widget build(BuildContext context) {
    if (daily.isEmpty) {
      return const Text('Không có dữ liệu theo ngày');
    }

    return Column(
      children: daily.map((day) {
        final date = DateFormat('dd/MM').format(day.date);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date),
              Row(
                children: [
                  Text(
                    '${day.low.toStringAsFixed(0)}°',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${day.high.toStringAsFixed(0)}°',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
