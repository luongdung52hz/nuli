import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/routers/router_name.dart';
import 'package:nuli_app/core/widgets/loading_screen.dart';
import 'package:nuli_app/features/auth/presentation/pages/login_screen.dart';
import 'package:nuli_app/features/auth/presentation/pages/register_screen.dart';
import 'package:nuli_app/features/home/presentation/pages/home_screen.dart';
import '../../features/auth/presentation/pages/forgot_pass_screen.dart';


class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }
}
class AppRouter {
  static final GoRouter routes = GoRouter(
      initialLocation: Routes.loading,
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
        refreshListenable: AuthStateNotifier();
        final isLoggedIn = user != null;

        // Danh sách các route auth (không cần login)
        final authRoutes = [
          Routes.login,
          Routes.register,
          Routes.forgotPass,
          Routes.loading,
        ];

        final isAuthRoute = authRoutes.contains(state.matchedLocation);

        // Nếu đang ở loading screen, để nó xử lý
        if (state.matchedLocation == Routes.loading) {
          return null;
        }

        // Chưa đăng nhập mà cố vào trang cần auth → đá về login
        if (!isLoggedIn && !isAuthRoute) {
          return Routes.login;
        }

        // Đã đăng nhập mà còn ở trang auth → về home
        if (isLoggedIn && isAuthRoute) {
          return Routes.home;
        }

        return null; // Không redirect
      },

      //  RefreshListenable để GoRouter tự động rebuild khi auth thay đổi

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
        builder: (context, state) => const LoadingScreen())

      ]
  );
}

