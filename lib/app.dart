import 'package:flutter/material.dart';
import 'package:nuli_app/core/constants/app_constans.dart';
import 'package:nuli_app/core/routers/app_router.dart';

class NuliApp extends StatelessWidget {
  const NuliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      routerConfig:AppRouter.routes );
  }
}
