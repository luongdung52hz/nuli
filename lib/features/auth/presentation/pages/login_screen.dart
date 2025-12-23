import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
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

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    if (auth.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.home);
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
                    "Đăng nhập",
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
                  const SizedBox(height: 30),

                  // Email TextField
                  CustomTextField(
                    controller: _emailCtrl,
                    labelText: 'Email',
                    validator: Validators.validateEmail,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password TextField
                  CustomTextField(
                    controller: _passCtrl,
                    prefixIcon: Icons.lock,
                    labelText: 'Mật khẩu',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) async {
                      if (_fromKey.currentState!.validate() && !auth.isLoading) {
                        final success = await auth.signInWithEmail(
                          _emailCtrl.text.trim(),
                          _passCtrl.text.trim(),
                        );
                        if (!success) {
                          _showErrorSnackBar(
                            auth.error ?? 'Đăng nhập thất bại',
                          );
                        }
                      }
                    },
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go(Routes.forgotPass),
                      child: const Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                          color: AppColors.secondaryyGreen,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email Login Button
                  Consumer<AuthController>(
                    builder: (context, auth, child) {
                      return CustomButton(
                        isLoading: auth.isLoading,
                        text: 'Đăng Nhập',
                        onPressed: auth.isLoading
                            ? null
                            : () async {
                          if (!_fromKey.currentState!.validate()) return;

                          final success = await auth.signInWithEmail(
                            _emailCtrl.text.trim(),
                            _passCtrl.text.trim(),
                          );

                          if (!success) {
                            _showErrorSnackBar(
                              auth.error ?? 'Đăng nhập thất bại',
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "hoặc",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Google Sign In Button
                  Consumer<AuthController>(
                    builder: (context, auth, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: auth.isLoading
                              ? null
                              : () async {
                            final success = await auth.signInWithGoogle();

                            if (!success) {
                              _showErrorSnackBar(
                                auth.error ?? 'Đăng nhập Google thất bại',
                              );
                            }
                          },
                          icon: auth.isLoading
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryGreen,
                              ),
                            ),
                          )
                              : SvgPicture.asset(
                            AppIcons.logoGoogle,
                            height: 24,
                            width: 24,
                          ),
                          label: Text(
                            auth.isLoading
                                ? 'Đang đăng nhập...'
                                : 'Đăng nhập bằng Google',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkText,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              // vertical: 20,
                              horizontal: 30,
                            ),
                            side: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Chưa có tài khoản?",
                        style: TextStyle(
                          color: AppColors.mutedText,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(Routes.register),
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}