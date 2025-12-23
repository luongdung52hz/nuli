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
import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();


  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _confirmPassCtrl.dispose();
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
                    "Đăng ký",
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

                  // Name TextField
                  CustomTextField(
                    controller: _nameCtrl,
                    labelText: 'Họ và tên',
                    validator: Validators.validateDisplayName,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),

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
                    validator: Validators.validatePassword,
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
                  const SizedBox(height: 16),

                  //ConfirmPass TextField
                  CustomTextField(
                    controller: _confirmPassCtrl,
                    labelText: 'Nhắc lại mật khẩu',
                    validator: (value)=>Validators.validateConfirmPassword(
                      value, _passCtrl.text
                    ),
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.lock_outline,
                    keyboardType: TextInputType.none,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),

                  Consumer<AuthController>(
                    builder: (context, auth, child) {
                      return CustomButton(
                        isLoading: auth.isLoading,
                        text: 'Đăng ký',
                        onPressed: auth.isLoading
                            ? null
                            : () async {
                          if (!_fromKey.currentState!.validate()) return;
                          final success = await auth.signUpWithEmail(
                            _emailCtrl.text.trim(),
                            _passCtrl.text.trim(),
                            _nameCtrl.text.trim(),
                          );
                          if (!success) {
                            _showErrorSnackBar(
                              auth.error ?? 'Đăng ký thất bại',
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Đã có tài khoản?",
                        style: TextStyle(
                          color: AppColors.mutedText,
                        ),
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