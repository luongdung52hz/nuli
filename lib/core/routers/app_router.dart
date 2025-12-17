import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/routers/router_name.dart';
import 'package:nuli_app/features/auth/presentation/pages/login_screen.dart';
import 'package:nuli_app/features/home/presentation/pages/home_screen.dart';

class AppRouter {
  static final GoRouter routes = GoRouter(
      initialLocation: Routes.login,
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Lỗi Route')),
        body: Center(
          child: Text(
            'Không tìm thấy: ${state.matchedLocation}\nLỗi: ${state.error}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      routes: [

        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        )
      ]
  );
}
