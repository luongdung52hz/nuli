import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/constants/app_icons.dart';
import 'package:nuli_app/core/utils/validators.dart';
import 'package:nuli_app/core/widgets/button_app.dart';
import 'package:nuli_app/core/widgets/textfield_app.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/routers/router_name.dart';
import 'package:provider/provider.dart';
import '../provider/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSuccesSnackBar(){
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Liên kết đặt lại mật khẩu đã gửi đến ${_emailCtrl.text.trim()}! '
                'Kiểm tra email (kể cả thư rác) và click link để reset.',
          ),
          backgroundColor: AppColors.primaryGreen,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              context.go(Routes.login);
            },
          ),
        ),
      );
      // Tự động quay về login sau 3 giây nếu không click OK
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) context.go(Routes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    if (auth.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // Logo
                  Image.asset(
                    AppIcons.logoApp,
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.eco, size: 100);
                    },
                  ),
                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.lg,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  const Text(
                    "Chào mừng bạn đến với ứng dụng",
                    style: TextStyle(fontSize: 14, color: AppColors.darkText),
                  ),
                  const SizedBox(height: 60),

                  // Email TextField
                  CustomTextField(
                    controller: _emailCtrl,
                    labelText: 'Email',
                    validator: Validators.validateEmail,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 26),

                  // Button reset pass
                  Consumer<AuthController>(
                    builder: (context, auth, child) {
                      return CustomButton(
                        isLoading: auth.isLoading,
                        text: 'Gửi liên kết',
                        onPressed: auth.isLoading
                            ? null
                            : () async {
                          if (!_fromKey.currentState!.validate()) return;

                          final success = await auth.resetPassword(
                            _emailCtrl.text.trim(),
                          );
                          _showSuccesSnackBar();
                          if (!success) {
                            _showErrorSnackBar(
                              auth.error ?? 'Đăng nhập thất bại',
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 26),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nhớ mật khẩu rồi? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () => context.go(Routes.login),
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}