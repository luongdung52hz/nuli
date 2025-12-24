import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget WeatherCard() {
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
            Text("Thời tiết hôm nay",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Nhiệt độ: 30°C"),
            Text("Độ ẩm: 65%"),
          ],
        ),
      ],
    ),
  );
}