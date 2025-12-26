import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/routers/router_name.dart';
import '../../../../core/widgets/bottom_nav_app.dart';
import '../../../../core/widgets/button_app.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../../../chat/presentation/controller/ai_chat_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Settings"),
            Consumer<AuthController>(
              builder: (context, auth, child) {
                return CustomButton(
                    isLoading: auth.isLoading,
                    text: 'Đăng xuất',
                    onPressed: () async {
                      context.read<AiChatController>().resetChat();
                      await auth.signOut();
                      context.go(Routes.login);
                    }
                );
              },
            ),

          ]

        )

      ),
      bottomNavigationBar: const BottomNavApp(currentIndex: 4),
    );
  }
}
