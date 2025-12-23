import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/constants/app_icons.dart';

import '../routers/router_name.dart';

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
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index){
          switch (index){
            case 0:
              context.go(Routes.home);
              break;
            case 1:
              context.go(Routes.chat);
              break;
            case 2:
              context.go(Routes.home);
              break;
            case 3:
              context.go(Routes.home);
              break;
            case 4:
              context.go(Routes.setting);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: _CustomNavIcon(
              index: 0,
              currentIndex: currentIndex,
              svgPath: AppIcons.iconHome),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: _CustomNavIcon(
              index: 1,
              currentIndex: currentIndex,
              svgPath: AppIcons.iconChat),
            label: "Chat AI",
          ),
          BottomNavigationBarItem(icon: _CustomNavIcon(
              index: 2,
              currentIndex: currentIndex,
              svgPath: AppIcons.iconVideo),
            label: "Video",
          ),
          BottomNavigationBarItem(icon: _CustomNavIcon(
              index: 3,
              currentIndex: currentIndex,
              svgPath: AppIcons.iconCalendar),
            label: "Calendar",
          ),
          BottomNavigationBarItem(icon: _CustomNavIcon(
              index: 4,
              currentIndex: currentIndex,
              svgPath: AppIcons.iconSetting),
            label: "Setting",
          ),
        ],
      )
    );
  }
}

class _CustomNavIcon extends StatelessWidget{
  final int index;
  final int currentIndex;
  final String svgPath;

  const _CustomNavIcon({
   required this.index,
   required this.currentIndex,
   required this.svgPath,
 });
  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;
    final Color iconColor = isSelected ? AppColors.primaryGreen: Colors.grey;
    final Color bgColor = isSelected ? Colors.white: Colors.transparent;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(13),
            boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
                ),
            ] : null,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 22,
              width: 22,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ],

        )
      ],
    );
  }
}
