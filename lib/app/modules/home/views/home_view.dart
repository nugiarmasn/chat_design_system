import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../pages/bars_navigation/nav_bars_page.dart';
import '../../../pages/bars_navigation/bottom_and_tabs_page.dart';
import '../../../pages/bars_navigation/search_bars_page.dart';
import '../../text_fields/views/text_fields_view.dart';
import '../../buttons/views/buttons_view.dart';
import '../../toggles/views/toggles_view.dart';
import '../../chat_area/views/chat_area_view.dart';
import '../../index_list/views/index_list_view.dart'; // <-- TAMBAHKAN IMPORT INI
import '../../../core/theme/app_theme.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/chat_list_tile.dart';
import '../../../widgets/chat_input_field.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const double _mobileBreakpoint = 700;

  Widget _buildContent(BuildContext context, int index, String menuTitle) {
    switch (index) {
      case 0:
        return const ButtonsView();
      case 1:
        return const TextFieldsView();
      case 2:
        return const TogglesView();
      case 3:
        return const NavBarsPage();
      case 4:
        return const BottomAndTabsPage();
      case 5:
        return const SearchBarsPage();
      case 8:
        return const ChatAreaView();
      case 9: // Lists / Chat & Users
        return const IndexListView(); // <-- UBAH MENJADI IndexListView
      case 10:
        return _buildMessageComposerContent(context);
      case 11:
        return _buildAvatarsContent(context);
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Halaman $menuTitle akan dirender di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: context.appTextSecondary),
            ),
          ),
        );
    }
  }

  Widget _buildAvatarsContent(BuildContext context) {
    return Container(
      color: context.appBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Initials Avatar', style: AppTypography.heading1.adapt(context)),
            const SizedBox(height: AppSpacing.lg),
            _buildAvatarGrid(initials: 'SF', badgeType: AvatarBadgeType.online),
            const SizedBox(height: AppSpacing.xxl),
            Text('Icon Avatar', style: AppTypography.heading1.adapt(context)),
            const SizedBox(height: AppSpacing.lg),
            _buildAvatarGrid(defaultIcon: Icons.person, badgeType: AvatarBadgeType.offline),
            const SizedBox(height: AppSpacing.xxl),
            Text('Image Avatar', style: AppTypography.heading1.adapt(context)),
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

  Widget _buildAvatarGrid({
    String? initials,
    IconData? defaultIcon,
    String? imageUrl,
    AvatarBadgeType badgeType = AvatarBadgeType.none,
    int notificationCount = 0,
  }) {
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

  // Fungsi ini TIDAK digunakan lagi, tapi kita biarkan saja agar tidak error jika ada referensi lain
  Widget _buildChatListContent(BuildContext context) {
    return Container(
      color: context.appSurface,
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
          Divider(height: 1, color: context.appDivider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            readStatus: ChatReadStatus.delivered,
            onTap: () {},
          ),
          Divider(height: 1, color: context.appDivider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet consectet...',
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
          Divider(height: 1, color: context.appDivider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: '',
            hasAttachment: true,
            readStatus: ChatReadStatus.read,
            onTap: () {},
          ),
          Divider(height: 1, color: context.appDivider),
          ChatListTile(
            avatarInitials: 'SF',
            name: 'Scott Franklin',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet...',
            hasAttachment: true,
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
          Divider(height: 1, color: context.appDivider),
          ChatListTile(
            avatarIcon: Icons.group,
            name: 'Travel Buddies',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            senderPrefix: 'You: ',
            readStatus: ChatReadStatus.read,
            onTap: () {},
          ),
          Divider(height: 1, color: context.appDivider),
          ChatListTile(
            avatarIcon: Icons.group,
            name: 'Travel Buddies',
            time: '4:30 PM',
            messageSnippet: 'Lorem ipsum dolor sit amet cons...',
            senderPrefix: 'Sender: ',
            readStatus: ChatReadStatus.none,
            onTap: () {},
          ),
          Divider(height: 1, color: context.appDivider),
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
          Divider(height: 1, color: context.appDivider),
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

  Widget _buildMessageComposerContent(BuildContext context) {
    return Container(
      color: context.appBackground,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          Text('Normal Input State', style: AppTypography.heading2.adapt(context)),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(),
          const SizedBox(height: AppSpacing.xxl),
          Text('Input with Typed Text', style: AppTypography.heading2.adapt(context)),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(initialText: 'Hey! Just finished the draft for the project. Need your feedback by tomorrow if possible.'),
          const SizedBox(height: AppSpacing.xxl),
          Text('Voice Note Recording State', style: AppTypography.heading2.adapt(context)),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(state: ChatInputState.recording),
          const SizedBox(height: AppSpacing.xxl),
          Text('Action Summary Box (Suggest a reply)', style: AppTypography.heading2.adapt(context)),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(
            topWidget: ActionSummaryBox(
              title: 'Suggest a reply',
              titleIcon: Icons.auto_awesome,
              content: 'Thanks for handling the logistics, Michael. Your effort in ensuring the group discount for the hotel is much appreciated!\n\nMichael, I appreciate you taking care of the logistics and getting us that group discount at the hotel. Thanks a lot!',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Action Summary Box (Conversation summary)', style: AppTypography.heading2.adapt(context)),
          const SizedBox(height: AppSpacing.md),
          const ChatInputField(
            topWidget: ActionSummaryBox(
              title: 'Conversation summary',
              titleIcon: Icons.summarize,
              content: 'The user expressed interest in a watch listed for sale and confirmed its availability with the seller. They negotiated the price down from \$130 to \$120.',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Attachment Popup Menu', style: AppTypography.heading2.adapt(context)),
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

  Widget _sidebarContent(BuildContext context, {required bool isDrawer}) {
    return Container(
      width: isDrawer ? null : 280,
      color: const Color(0xFFF4F5F7),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      'Component Library',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                        () => IconButton(
                      icon: Icon(
                        controller.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                      ),
                      tooltip: 'Toggle Light/Dark Mode',
                      onPressed: controller.toggleTheme,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final selected = controller.selectedIndex.value;
                return ListView.builder(
                  itemCount: controller.menus.length,
                  itemBuilder: (context, index) {
                    final isSelected = selected == index;
                    return ListTile(
                      title: Text(
                        controller.menus[index],
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? const Color(0xFF0052CC) : Colors.black87,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: Colors.blue.withOpacity(0.1),
                      onTap: () {
                        controller.changeMenu(index);
                        if (isDrawer) Navigator.of(context).pop();
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        final contentArea = Obx(() {
          final index = controller.selectedIndex.value;
          final title = controller.menus[index];
          return _buildContent(context, index, title);
        });

        if (isMobile) {
          return Scaffold(
            appBar: AppBar(
              title: Obx(() => Text(controller.menus[controller.selectedIndex.value])),
            ),
            drawer: Drawer(child: _sidebarContent(context, isDrawer: true)),
            body: contentArea,
          );
        }

        return Scaffold(
          body: Row(
            children: [
              _sidebarContent(context, isDrawer: false),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: contentArea),
            ],
          ),
        );
      },
    );
  }
}