import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/index_list_controller.dart';
import '../../../components/custom_chat_list.dart';
import '../../../core/theme/app_theme.dart';

class IndexListView extends GetView<IndexListController> {
  const IndexListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IndexListController());

    return Scaffold(
      backgroundColor: context.appBackground,
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text('Index List', style: AppTypography.heading1.adapt(context)),
          const SizedBox(height: 32),

          Wrap(
            spacing: 32, runSpacing: 32,
            children: [
              // KOLOM 1: CHAT LIST
              _buildColumnSection(
                context,
                title: 'Chats',
                children: [
                  CustomChatList(name: 'George Alan', time: '4:30 PM', subtitle: 'Lorem ipsum dolor sit amet...', unreadCount: 0, avatarUrl: 'https://i.pravatar.cc/150?u=george'),
                  CustomChatList(name: 'Uber Cars', time: '4:30 PM', subtitle: 'Sender: Lorem ipsum...', unreadCount: 0, avatarUrl: 'https://i.pravatar.cc/150?u=uber'),
                  CustomChatList(name: 'Safiya Fareena', time: '4:30 PM', subtitle: 'Video', type: ChatListType.attachment, attachmentIcon: Icons.videocam, unreadCount: 1, avatarUrl: 'https://i.pravatar.cc/150?u=safiya'),
                  CustomChatList(name: 'Robert Allen', time: '4:30 PM', subtitle: 'Photo Lorem ipsum...', type: ChatListType.attachment, attachmentIcon: Icons.photo, avatarUrl: 'https://i.pravatar.cc/150?u=robert'),
                  CustomChatList(name: 'Epic Game', time: '4:30 PM', subtitle: 'John Paul: @Robert Lorem...', unreadCount: 24, avatarUrl: 'https://i.pravatar.cc/150?u=epic'),
                ],
              ),

              // KOLOM 2: CALLS
              _buildColumnSection(
                context,
                title: 'Calls',
                children: [
                  CustomChatList(name: 'John Paul', time: '8 August, 8:14 pm', type: ChatListType.call, subtitle: 'Incoming', isMissedCall: false, avatarUrl: 'https://i.pravatar.cc/150?u=john'),
                  CustomChatList(name: 'Epic Games', time: '8 August, 8:14 pm', type: ChatListType.call, subtitle: 'Outgoing', isMissedCall: false, avatarUrl: 'https://i.pravatar.cc/150?u=epicgame'),
                  CustomChatList(name: 'Tessa (2)', time: '8 August, 8:14 pm', type: ChatListType.call, subtitle: 'Missed', isMissedCall: true, avatarUrl: 'https://i.pravatar.cc/150?u=tessa'),
                  CustomChatList(name: 'Paul David', time: '8 August, 8:14 pm', type: ChatListType.call, subtitle: 'Incoming', isMissedCall: false, avatarUrl: 'https://i.pravatar.cc/150?u=paul'),
                ],
              ),

              // KOLOM 3: CONTACTS (A, B, C)
              _buildColumnSection(
                context,
                title: 'Contacts',
                children: [
                  CustomChatList(type: ChatListType.groupHeader, name: '', headerText: 'A'),
                  CustomChatList(name: 'Alex Mason', type: ChatListType.contact, avatarUrl: 'https://i.pravatar.cc/150?u=alex'),
                  CustomChatList(name: 'Andrew Joseph', type: ChatListType.contact, avatarUrl: 'https://i.pravatar.cc/150?u=andrew'),
                  CustomChatList(type: ChatListType.groupHeader, name: '', headerText: 'B'),
                  CustomChatList(name: 'Brian Michael', type: ChatListType.contact, avatarUrl: 'https://i.pravatar.cc/150?u=brian'),
                  CustomChatList(type: ChatListType.groupHeader, name: '', headerText: 'C'),
                  CustomChatList(name: 'Cameron Lee', type: ChatListType.contact, avatarUrl: 'https://i.pravatar.cc/150?u=cameron'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumnSection(BuildContext context, {required String title, required List<Widget> children}) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: AppTypography.heading2.adapt(context)),
          ),
          const Divider(height: 1),
          ...children,
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}