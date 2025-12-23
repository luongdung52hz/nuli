import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/widgets/textfield_app.dart';
import 'package:nuli_app/features/chat/presentation/controller/ai_chat_controller.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/bottom_nav_app.dart';
import '../../data/models/ai_chat_model.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AiChatController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/home'),
      ),
        title: const Text(
          'Hỏi AI Nông nghiệp',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(

        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.messages.length,
              itemBuilder: (context, index) {
                final msg = provider.messages[index];
                return Align(
                  alignment: msg.role == ChatRole.user
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: msg.role == ChatRole.user
                          ? Colors.green[200]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.message),
                  ),
                );
              },
            ),
          ),
          if (provider.isLoading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(color: AppColors.primaryGreen,),
            ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        controller: controller,
                        labelText:"Hỏi về nông nghiệp"),

                )
              ),
              IconButton(
                icon: SvgPicture.asset(
                AppIcons.iconSend,
                height: 34,
                width: 34,
                 ),
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    provider.send(text);
                    controller.clear();
                  }
                },
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(height: 10,)
        ],
      ),
    //  bottomNavigationBar: const BottomNavApp(currentIndex: 1),
    );
  }
}
