import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_area_controller.dart';
import '../../../components/custom_chat_bubble.dart';
import '../../../core/theme/app_theme.dart';

class ChatAreaView extends GetView<ChatAreaController> {
  const ChatAreaView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatAreaController());
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: context.appBackground,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('Chat Area Variants', style: AppTypography.heading1.adapt(context)),
          ),
          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('1. Default Alignment', style: AppTypography.heading2.adapt(context)),
          ),
          const SizedBox(height: 16),
          const CustomChatBubble(
            text: "Hi, is the watch still up for sale?",
            time: "4:56 pm",
            isSender: true,
            isRead: true,
          ),
          const CustomChatBubble(
            text: "Yes, it's available.",
            time: "4:56 pm",
            isSender: false,
          ),

          const SizedBox(height: 48),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('2. Left Aligned (With Avatars)', style: AppTypography.heading2.adapt(context)),
          ),
          const SizedBox(height: 16),
          const CustomChatBubble(
            text: "Awesome! Can I see a couple of pictures?",
            time: "4:56 pm",
            isSender: true,
            isRead: true,
          ),
          const CustomChatBubble(
            text: "Sure! Sending them over now.",
            time: "4:56 pm",
            isSender: false,
            showAvatar: true,
            avatarUrl: 'https://i.pravatar.cc/150?u=george', // <-- URL Avatar dimasukkan
          ),
          const CustomChatBubble(
            text: "Great, I'll send it now. Thanks!",
            time: "4:56 pm",
            isSender: true,
            isRead: false,
          ),
          const CustomChatBubble(
            text: "Thank you!",
            time: "4:56 pm",
            isSender: false,
            showAvatar: true,
            avatarUrl: 'https://i.pravatar.cc/150?u=george', // <-- URL Avatar dimasukkan
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.surface,
            border: Border(top: BorderSide(color: theme.outline)),
          ),
          child: Row(
            children: [
              Icon(Icons.add, color: theme.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: context.appBackground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: theme.onSurfaceVariant, fontSize: 14),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(color: theme.onSurface),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.mic, color: theme.onSurfaceVariant),
              const SizedBox(width: 16),
              CircleAvatar(
                backgroundColor: theme.primary,
                radius: 20,
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}