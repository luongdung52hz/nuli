import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/constants/app_icons.dart';
import 'package:nuli_app/core/utils/validators.dart';
import 'package:nuli_app/core/widgets/button_app.dart';
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
  bool _obscurePassword = true;


  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
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
      body:SafeArea(
        child: Center(child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: [
                  const SizedBox(height:30),
                  Image.asset(
                    AppIcons.logoApp,
                    height: 80,
                    width: 80,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.eco, size: 100,
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Đăng nhập ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.lg,
                      color: AppColors.darkText,),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Chào mừng bạn đến với ứng dụng ",
                    style: TextStyle(fontSize: 14, color: AppColors.darkText),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    validator:Validators.validateEmail ,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.1,
                          color: Colors.white
                        )
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundGreen
                     ),
                    ),
                     const SizedBox(height: 16,),
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _obscurePassword,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                             ? Icons.visibility_outlined
                             : Icons.visibility_off_outlined
                        ),
                        onPressed: (){
                          setState(() {
                            _obscurePassword =! _obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1
                        )
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundGreen,
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go(Routes.home),
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
                  Consumer<AuthController>(
                    builder: (context, auth, child) {
                      return CustomButton(
                        isLoading: auth.isLoading,
                        text: 'Đăng Nhập',
                        onPressed: auth.isLoading
                            ? null
                            : () async {
                          if (!_fromKey.currentState!.validate()) return;

                          await auth.signInWithEmail(
                            _emailCtrl.text.trim(),
                            _passCtrl.text.trim(),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),
//Regist
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chưa có tài khoản?",
                        style: TextStyle(
                          color: AppColors.mutedText,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(Routes.home),
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
            )
           ),
          )
        )
      )
    );
  }
}

