import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  final weather;

  const WeatherDetails(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
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
            'Chi tiết',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F1F1F),
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailItem(
            icon: Icons.water_drop_outlined,
            label: 'Độ ẩm',
            value: '${weather.humidity}%',
            color: Colors.blue,
            showDivider: true,
          ),
          _buildDetailItem(
            icon: Icons.air,
            label: 'Gió',
            value: '${weather.windSpeed} m/s',
            color: Colors.greenAccent,
            showDivider: true,
          ),
          _buildDetailItem(
            icon: Icons.grain,
            label: 'Lượng mưa',
            value: '${weather.precipitation} mm',
            color: Colors.purpleAccent,
            showDivider: true,
          ),
          _buildDetailItem(
            icon: Icons.wb_sunny_outlined,
            label: 'Mặt trời mọc',
            value: weather.sunrise,
            color: Colors.orange,
            showDivider: true,
          ),
          _buildDetailItem(
            icon: Icons.nightlight_outlined,
            label: 'Mặt trời lặn',
            value: weather.sunset,
            color: Colors.blueAccent,
            showDivider: false, // Item cuối không cần divider
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
      ],
    );
  }
}