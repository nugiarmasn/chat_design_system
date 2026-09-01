import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/component_library_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/chat_list_item.dart'; // Tetap dipertahankan kalau masih dipakai di tempat lain
import '../../../widgets/chat_list_tile.dart'; // Import komponen baru
import '../../../widgets/chat_input_field.dart'; // Import komponen input chat
import '../../../widgets/message_composer.dart';

class ComponentLibraryView extends GetView<ComponentLibraryController> {
  const ComponentLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Component Library', style: TextStyle(fontFamily: AppTypography.fontFamily)),
        centerTitle: true,
        backgroundColor: AppColors.surfaceWhite,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.divider, height: 1.0),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar
          Container(
            width: 250,
            color: AppColors.surfaceWhite,
            child: Obx(() {
              // Panggil .value secara langsung di dalam block Obx 
              // agar GetX bisa mendeteksi dependency sebelum render builder ListView
              final selectedValue = controller.selectedMenu.value;
              
              return ListView.separated(
                itemCount: controller.menuItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (context, index) {
                  final item = controller.menuItems[index];
                  final isSelected = item == selectedValue;
                  return ListTile(
                    title: Text(
                      item,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: AppColors.primaryBlueLight, // Menggunakan warna highlight terang
                    onTap: () => controller.selectMenu(item),
                  );
                },
              );
            }),
          ),
          const VerticalDivider(width: 1, thickness: 1, color: AppColors.divider),
          
          // Content Area
          Expanded(
            child: Obx(() {
              return _buildContent(controller.selectedMenu.value);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(String selectedMenu) {
    switch (selectedMenu) {
      case 'Views / Avatars':
        return _buildAvatarsContent();
      case 'Lists / Chat & Users':
        return _buildChatListContent();
      case 'Forms / Message Area':
        return _buildMessageComposerContent();
      default:
        return const Center(child: Text('Select a component'));
    }
  }

  Widget _buildAvatarsContent() {
    return Container(
      color: AppColors.backgroundLight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Initials Avatar', style: AppTypography.heading1),
            const SizedBox(height: AppSpacing.lg),
            _buildAvatarGrid(initials: 'SF', badgeType: AvatarBadgeType.online),
            
            const SizedBox(height: AppSpacing.xxl),
            Text('Icon Avatar', style: AppTypography.heading1),
            const SizedBox(height: AppSpacing.lg),
            _buildAvatarGrid(defaultIcon: Icons.person, badgeType: AvatarBadgeType.offline),
            
            const SizedBox(height: AppSpacing.xxl),
            Text('Image Avatar', style: AppTypography.heading1),
            const SizedBox(height: AppSpacing.lg),
            _buildAvatarGrid(
              imageUrl: 'https://i.pravatar.cc/150?u=scott',
              badgeType: AvatarBadgeType.notification,
              notificationCount: 3,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper untuk merender variasi ukuran dan bentuk dari satu tipe konten avatar
  Widget _buildAvatarGrid({
    String? initials,
    IconData? defaultIcon,
    String? imageUrl,
    AvatarBadgeType badgeType = AvatarBadgeType.none,
    int notificationCount = 0,
  }) {
    // Membalik ukuran agar yang terbesar (xxxl) tampil lebih dulu
    final sizes = AvatarSize.values.reversed.toList();
    
    return Wrap(
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.xl,
      children: sizes.map((size) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAvatar(
              size: size,
              shape: AvatarShape.circle,
              initials: initials,
              defaultIcon: defaultIcon,
              imageUrl: imageUrl,
              badgeType: badgeType,
              notificationCount: notificationCount,
            ),
            const SizedBox(width: AppSpacing.md),
            CustomAvatar(
              size: size,
              shape: AvatarShape.rounded,
              initials: initials,
              defaultIcon: defaultIcon,
              imageUrl: imageUrl,
              badgeType: badgeType,
              notificationCount: notificationCount,
            ),
            const SizedBox(width: AppSpacing.md),
            CustomAvatar(
              size: size,
              shape: AvatarShape.square,
              initials: initials,
              defaultIcon: defaultIcon,
              imageUrl: imageUrl,
              badgeType: badgeType,
              notificationCount: notificationCount,
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildChatListContent() {
    return Container(
      color: AppColors.surfaceWhite,
      child: ListView(
        children: [
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet consectet...',
            readStatus: ChatReadStatus.read,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            readStatus: ChatReadStatus.delivered,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet consectet...',
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: '',
            hasAttachment: true,
            readStatus: ChatReadStatus.read,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet...',
            hasAttachment: true,
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarIcon: Icons.group,
            name: 'Travel Buddies',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            senderPrefix: 'You: ',
            readStatus: ChatReadStatus.read,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarIcon: Icons.group,
            name: 'Travel Buddies',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            senderPrefix: 'Sender: ',
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarIcon: Icons.group,
            name: 'Travel Buddies',
            time: '4:30 PM',
            messageSnippet: '',
            hasAttachment: true,
            senderPrefix: 'You: ',
            readStatus: ChatReadStatus.read,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          ChatListTile(
            avatarIcon: Icons.group,
            name: 'Travel Buddies',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            hasAttachment: true,
            senderPrefix: 'Sender: ',
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposerContent() {
    return Container(
      color: AppColors.backgroundLight,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          Text('Normal Input State', style: AppTypography.heading2),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(),
          
          const SizedBox(height: AppSpacing.xxl),
          Text('Input with Typed Text', style: AppTypography.heading2),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(initialText: 'Hey! Just finished the draft for the project. Need your feedback by tomorrow if possible.'),
          
          const SizedBox(height: AppSpacing.xxl),
          Text('Voice Note Recording State', style: AppTypography.heading2),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(state: ChatInputState.recording),
          
          const SizedBox(height: AppSpacing.xxl),
          Text('Action Summary Box (Suggest a reply)', style: AppTypography.heading2),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(
            topWidget: ActionSummaryBox(
              title: 'Suggest a reply',
              titleIcon: Icons.auto_awesome,
              content: 'Thanks for handling the logistics, Michael. Your effort in ensuring the group discount for the hotel is much appreciated!\n\nMichael, I appreciate you taking care of the logistics and getting us that group discount at the hotel. Thanks a lot!',
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),
          Text('Action Summary Box (Conversation summary)', style: AppTypography.heading2),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(
            topWidget: ActionSummaryBox(
              title: 'Conversation summary',
              titleIcon: Icons.summarize,
              content: 'The user expressed interest in a watch listed for sale and confirmed its availability with the seller. They negotiated the price down from \$130 to \$120.',
            ),
          ),
          
          const SizedBox(height: AppSpacing.xxl),
          Text('Attachment Popup Menu', style: AppTypography.heading2),
          const SizedBox(height: AppSpacing.md),
          const Align(
            alignment: Alignment.centerLeft,
            child: AttachmentPopupMenu(),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
