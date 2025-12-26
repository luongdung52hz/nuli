import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/weather_model.dart';

class DailyWeatherList extends StatelessWidget {
  final List<DailyForecast> daily;

  const DailyWeatherList(this.daily, {super.key});

  @override
  Widget build(BuildContext context) {
    if (daily.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Không có dữ liệu theo ngày',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(30),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dự báo 7 ngày ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daily.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemBuilder: (context, index) {
              final day = daily[index];
              final isToday = index == 0;
              final date = isToday
                  ? 'Hôm nay'
                  : _getVietnameseDayName(day.date);

              return _buildDayItem(
                date: date,
                icon: _getWeatherIcon(day.high),
                low: day.low,
                high: day.high,
                isToday: isToday,
              );
            },
          ),
        ],
      ),
    );
  }

  String _getVietnameseDayName(DateTime date) {
    final dayOfWeek = date.weekday;
    final dayNames = ['Thứ 2', 'Thứ 3', 'T4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ Nhật'];
    final dayName = dayNames[dayOfWeek - 1];
    final formattedDate = DateFormat('dd/MM').format(date);
    return '$dayName - $formattedDate';
  }

  Widget _buildDayItem({
    required String date,
    required IconData icon,
    required double low,
    required double high,
    required bool isToday,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Ngày
          Expanded(
            flex: 3,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
                color: isToday ? const Color(0xFF1F1F1F) : const Color(0xFF757575),
              ),
            ),
          ),

          // Icon thời tiết
          Icon(
            icon,
            size: 24,
            color: Colors.blue,
          ),

          const SizedBox(width: 10),

          // Nhiệt độ
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Nhiệt độ thấp
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          size: 12,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${low.toStringAsFixed(0)}°',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 4),

                  // Nhiệt độ cao
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          size: 12,
                          color: Colors.orange.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${high.toStringAsFixed(0)}°',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),)

          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(double temperature) {
    if (temperature >= 30) {
      return Icons.wb_sunny;
    } else if (temperature >= 25) {
      return Icons.wb_sunny_outlined;
    } else if (temperature >= 20) {
      return Icons.wb_cloudy;
    } else {
      return Icons.cloud;
    }
  }
}