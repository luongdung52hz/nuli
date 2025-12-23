import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ScheduleCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Lịch làm việc hôm nay",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const Icon(Icons.agriculture, color: Colors.green),
          title: const Text("Tưới rau"),
          subtitle: const Text("06:00 AM"),
          trailing: const Icon(Icons.check_circle_outline),
        ),
      ),
    ],
  );
}