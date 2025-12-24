import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ActionsCard(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    children: [
      _actionItem(Icons.chat, "Chat AI"),
      _actionItem(Icons.video_library, "Videos"),
      _actionItem(Icons.calendar_month, "Schedule"),
      _actionItem(Icons.person, "Profile"),
    ],
  );
}

Widget _actionItem(IconData icon, String title) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 36, color: Colors.green),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
