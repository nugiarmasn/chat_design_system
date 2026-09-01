import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../pages/bars_navigation/nav_bars_page.dart';
import '../../../pages/bars_navigation/bottom_and_tabs_page.dart';
import '../../../pages/bars_navigation/search_bars_page.dart';
import '../../text_fields/views/text_fields_view.dart';
import '../../buttons/views/buttons_view.dart';
import '../../toggles/views/toggles_view.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/chat_list_tile.dart';
import '../../../widgets/chat_input_field.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // Breakpoint: di bawah lebar ini, sidebar disembunyikan jadi Drawer.
  static const double _mobileBreakpoint = 700;

  Widget _buildContent(BuildContext context, int index, String menuTitle) {
    switch (index) {
      case 0: // Controls / Buttons
        return const ButtonsView();
      case 1: // Controls / Text Fields
        return const TextFieldsView();
      case 2: // Controls / Toggles & Choices
        return const TogglesView();
      case 3: // Bars / Nav Bars
        return const NavBarsPage();
      case 4: // Navigation / Bottom & Tabs
        return const BottomAndTabsPage();
      case 5: // Bars / Search Bars
        return const SearchBarsPage();
      case 9: // Lists / Chat & Users
        return _buildChatListContent(context);
      case 10: // Message Area
        return _buildMessageComposerContent(context);
      case 11: // Views / Avatars & Badges
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;

            final leftColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Text Message Composer', style: AppTypography.heading1.adapt(context)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Default', const ChatInputField(variant: ChatInputVariant.defaultState)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Focus', const ChatInputField(variant: ChatInputVariant.focus)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Typing', const ChatInputField(variant: ChatInputVariant.typing)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Multiline', const ChatInputField(variant: ChatInputVariant.multiline)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Mentioned', const ChatInputField(variant: ChatInputVariant.mentioned)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Edit Message', const ChatInputField(variant: ChatInputVariant.editMessage)),
                
                const SizedBox(height: AppSpacing.xxl),
                Text('Feature', style: AppTypography.heading1.adapt(context)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Attachment', const PopupAttachment()),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Emoji', const PopupEmoji()),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Sticker', const PopupSticker()),
              ],
            );

            final rightColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Voice', style: AppTypography.heading1.adapt(context)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Voice - Default', const VoiceComposer(variant: VoiceComposerVariant.defaultState)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Voice - Pause', const VoiceComposer(variant: VoiceComposerVariant.pause)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Voice - Recording', const VoiceComposer(variant: VoiceComposerVariant.recording)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Voice - Preview', const VoiceComposer(variant: VoiceComposerVariant.preview)),
                
                const SizedBox(height: AppSpacing.xxl),
                Text('AI Feature', style: AppTypography.heading1.adapt(context)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'AI - Menu', const PopupAiMenu()),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(
                  context,
                  'AI - Suggest a reply', 
                  const AiCard(
                    title: 'Suggest a reply',
                    content: 'Thanks for handling the logistics, Michael. Your effort in securing the group discount for the hotel is much appreciated!\n\nMichael, I appreciate you taking care of the logistics and getting us that group discount at the hotel. Thanks a lot!\n\nThank you, Michael, for organizing everything. Your work on getting the group discount for the hotel didn\'t go unnoticed!',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const ChatInputField(variant: ChatInputVariant.defaultState),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(
                  context,
                  'AI - Conversation summary', 
                  const AiCard(
                    title: 'Conversation summary',
                    content: 'The user expressed interest in a watch listed for sale and confirmed its availability with the seller. They negotiated the price down from \$130 to \$120. After agreeing on the new price, the user asked if they could pick up the watch the same day. The seller responded positively with emojis, and the user confirmed availability after 5 PM. They concluded the conversation with plans to meet soon.',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const ChatInputField(variant: ChatInputVariant.defaultState),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'AI - Ask AI Bot', const ChatInputField(variant: ChatInputVariant.defaultState)),
                const SizedBox(height: AppSpacing.xl),
                _buildLabeledItem(context, 'Conversation Starter', const ConversationStarters()),
                const SizedBox(height: AppSpacing.sm),
                const ChatInputField(variant: ChatInputVariant.defaultState),
              ],
            );

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: leftColumn),
                  const SizedBox(width: AppSpacing.xxl),
                  Expanded(child: rightColumn),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftColumn,
                  const SizedBox(height: AppSpacing.xxl),
                  rightColumn,
                ],
              );
            }
          }
        ),
      ),
    );
  }

  Widget _buildLabeledItem(BuildContext context, String label, Widget child) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: child,
        ),
        const SizedBox(width: AppSpacing.xl),
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: AppTypography.bodySecondary.adapt(context),
          ),
        ),
      ],
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
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      'Component Library',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                        () => IconButton(
                      icon: Icon(
                        controller.isDarkMode.value
                            ? Icons.dark_mode
                            : Icons.light_mode,
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
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF0052CC)
                              : Colors.black87,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: Colors.blue.withOpacity(0.1),
                      onTap: () {
                        controller.changeMenu(index);
                        if (isDrawer) Navigator.of(context).pop(); // tutup drawer
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
          // Layar sempit: sidebar jadi Drawer, ada AppBar dengan tombol menu.
          return Scaffold(
            appBar: AppBar(
              title: Obx(
                    () => Text(controller.menus[controller.selectedIndex.value]),
              ),
            ),
            drawer: Drawer(child: _sidebarContent(context, isDrawer: true)),
            body: contentArea,
          );
        }

        // Layar lebar: sidebar permanen di kiri.
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