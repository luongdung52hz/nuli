import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as Get;
import 'package:nuli_app/core/routers/router_name.dart';
import 'package:nuli_app/core/widgets/loading_screen.dart';
import 'package:nuli_app/features/article/presentation/pages/list_article.dart';
import 'package:nuli_app/features/auth/presentation/pages/login_screen.dart';
import 'package:nuli_app/features/auth/presentation/pages/register_screen.dart';
import 'package:nuli_app/features/chat/presentation/pages/chat_screen.dart';
import 'package:nuli_app/features/home/presentation/pages/home_screen.dart';
import 'package:nuli_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:nuli_app/features/weather/presentation/pages/weather_screen.dart';
import '../../features/article/data/models/article_model.dart';
import '../../features/article/presentation/pages/article_screen.dart';
import '../../features/auth/presentation/pages/forgot_pass_screen.dart';

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
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        final isLoggedIn = user != null;

        // Danh sách các route auth
        final authRoutes = [
          Routes.login,
          Routes.register,
          Routes.forgotPass,
          Routes.loading,
        ];

        final isAuthRoute = authRoutes.contains(state.matchedLocation);

        // Nếu đang ở loading screen
        if (state.matchedLocation == Routes.loading) {

          return null;
        }

        // Chưa đăng nhập mà cố vào trang cần auth
        if (!isLoggedIn && !isAuthRoute) {
          return Routes.login;
        }

        // Đã đăng nhập mà còn ở trang auth
        if (isLoggedIn && isAuthRoute) {
          return Routes.home;
        }

        return null;
      },
      routes: [

        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => const RegisterScreen(),
         ),
        GoRoute(path: Routes.forgotPass,
          builder: (context, state)=> const ForgotPasswordScreen(),
        ),
        GoRoute(path:Routes.loading,
        builder: (context, state) => const LoadingScreen()
        ),
        GoRoute(path: Routes.chat,
        builder:(context, state)=> AiChatScreen()
        ),
        GoRoute(path: Routes.weather,
          builder:(context, state) => const WeatherScreen()
        ),
        GoRoute(path: Routes.setting,
            builder:(context, state)=> SettingsScreen()
        ),
        GoRoute(
          path: '/news',
          builder: (context, state) {
            Get.put(ArticleListScreen() as Uri); // Inject controller
            return const ArticleListScreen();
          },
          routes: [
            GoRoute(
              path: '/detail', // Không params, dùng extra cho article
              builder: (context, state) {
                final article = state.extra as ArticleModel; // Từ onTap push
                return ArticleScreen(article: article);
              },
            ),
          ],
        ),

      ]
  );
}

