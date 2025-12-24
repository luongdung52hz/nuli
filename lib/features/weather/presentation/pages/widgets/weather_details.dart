import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuli_app/features/weather/presentation/pages/widgets/weather_item.dart';

class WeatherDetails extends StatelessWidget {
  final weather;

  const WeatherDetails(this.weather);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RowItem('Độ ẩm', '${weather.humidity}%'),
            RowItem('Gió', '${weather.windSpeed} m/s'),
            RowItem('Lượng mưa', '${weather.precipitation} mm'),
            RowItem('Mặt trời mọc', weather.sunrise),
            RowItem('Mặt trời lặn', weather.sunset),
          ],
        ),
      ),
    );
  }
}
