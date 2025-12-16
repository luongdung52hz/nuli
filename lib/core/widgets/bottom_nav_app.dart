import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:nuli_app/core/constants/app_colors.dart';

class BottomNavApp extends StatelessWidget {
  final int currentIndex;
  const BottomNavApp(  {super.key,required this.currentIndex});

  @override
  Widget  build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.paleGreen,
        boxShadow: [
          BoxShadow(
            color: AppColors.paleOrange.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, -2),
          )
        ]
      ),
    );
  }
}
