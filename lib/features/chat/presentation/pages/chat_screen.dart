import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:nuli_app/core/constants/app_colors.dart';
import 'package:nuli_app/core/constants/app_icons.dart';
import 'package:nuli_app/core/widgets/textfield_app.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/models/ai_chat_model.dart';
import '../controller/ai_chat_controller.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();

    // Reset chat khi rời màn hình
    context.read<AiChatController>().resetChat();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AiChatController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Hỏi AI Nông nghiệp ',
        onBack: () => context.go('/home'),
      ),
      body: Column(
        children: [
          /// Danh sách tin nhắn
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final msg = controller.messages[index];
                final isUser = msg.role == ChatRole.user;

                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.primaryGreen.withOpacity(0.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.message,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Loading AI
          if (controller.isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                color: AppColors.primaryGreen,
              ),
            ),

          /// Input chat
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _textController,
                      labelText: 'Hỏi về nông nghiệp...',
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.iconSend,
                      height: 28,
                      width: 28,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      final text = _textController.text.trim();
                      if (text.isNotEmpty) {
                        controller.send(text);
                        _textController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
