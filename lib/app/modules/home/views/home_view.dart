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
import '../../index_list/views/index_list_view.dart';
import '../../popovers_dialogs/views/popovers_dialogs_view.dart';
import '../../snackbars_bottom_sheets/views/snackbars_bottom_sheets_view.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/chat_input_field.dart';
import '../../../widgets/message_composer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const double _mobileBreakpoint = 768; 

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
      case 6:
        return const PopoversDialogsView();
      case 7:
        return const SnackbarsBottomSheetsView();
      case 8:
        return const ChatAreaView();
      case 9:
        return const IndexListView();
      case 10:
        return _buildMessageComposerContent(context);
      case 11:
        return _buildAvatarsContent(context);
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Halaman $menuTitle akan dirender di sini.',
              textAlign: TextAlign.center,
              style: AppTypography.body.adapt(context),
            ),
          ),
        );
    }
  }

  Widget _buildShowcaseRow(BuildContext context, Widget child, String label) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        if (isMobile) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodySecondary
                      .copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      )
                      .adapt(context),
                ),
                const SizedBox(height: AppSpacing.sm),
                child,
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 7, child: child),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: AppTypography.bodySecondary.adapt(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageComposerContent(BuildContext context) {
    return Container(
      color: context.appBackground,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  children: [
                    Text(
                      'Text Message Composer',
                      style: AppTypography.heading1.adapt(context),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildShowcaseRow(
                      context,
                      const ChatInputField(variant: ChatInputVariant.defaultState),
                      'Default',
                    ),
                    _buildShowcaseRow(
                      context,
                      const ChatInputField(variant: ChatInputVariant.focus),
                      'Focus',
                    ),
                    _buildShowcaseRow(
                      context,
                      const ChatInputField(variant: ChatInputVariant.typing),
                      'Typing',
                    ),
                    _buildShowcaseRow(
                      context,
                      const ChatInputField(variant: ChatInputVariant.multiline),
                      'Multiline',
                    ),
                    _buildShowcaseRow(
                      context,
                      const ChatInputField(variant: ChatInputVariant.mentioned),
                      'Mention',
                    ),
                    _buildShowcaseRow(
                      context,
                      const ChatInputField(variant: ChatInputVariant.editMessage),
                      'Edit Message',
                    ),

                    Divider(height: 48, color: context.appDivider),

                    Text(
                      'Voice Message Composer',
                      style: AppTypography.heading1.adapt(context),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildShowcaseRow(
                      context,
                      const VoiceComposer(variant: VoiceComposerVariant.defaultState),
                      'Default',
                    ),
                    _buildShowcaseRow(
                      context,
                      const VoiceComposer(variant: VoiceComposerVariant.pause),
                      'Pause',
                    ),
                    _buildShowcaseRow(
                      context,
                      const VoiceComposer(variant: VoiceComposerVariant.recording),
                      'Recording',
                    ),
                    _buildShowcaseRow(
                      context,
                      const VoiceComposer(variant: VoiceComposerVariant.preview),
                      'Preview',
                    ),

                    Divider(height: 48, color: context.appDivider),

                    Text(
                      'AI Features',
                      style: AppTypography.heading1.adapt(context),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildShowcaseRow(
                      context,
                      const PopupAiMenu(),
                      'AI - Menu',
                    ),
                    _buildShowcaseRow(
                      context,
                      const AiCard(
                        title: 'Suggest a reply',
                        content: 'Thanks for handling the logistics...',
                      ),
                      'AI - Suggest a reply',
                    ),
                    _buildShowcaseRow(
                      context,
                      const AiCard(
                        title: 'Conversation summary',
                        content:
                            'The user expressed interest in a watch listed for sale and confirmed its availability with the seller. They negotiated the price down from \$130 to \$120. After agreeing on the new price, the user asked if they could pick up the watch the same day. The seller responded positively with emojis, and the user confirmed availability after 5 PM. They concluded the conversation with plans to meet soon.',
                      ),
                      'AI - Conversation summary',
                    ),
                    _buildShowcaseRow(
                      context,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PopupAiMenu(),
                          SizedBox(height: 8),
                          ChatInputField(),
                        ],
                      ),
                      'AI - Ask AI Bot',
                    ),
                    _buildShowcaseRow(
                      context,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConversationStarters(),
                          SizedBox(height: 8),
                          ChatInputField(),
                        ],
                      ),
                      'Conversation Starter',
                    ),

                    Divider(height: 48, color: context.appDivider),

                    Text(
                      'Popups & Attachments',
                      style: AppTypography.heading1.adapt(context),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildShowcaseRow(
                      context,
                      const PopupAttachment(),
                      'Attachment',
                    ),
                    _buildShowcaseRow(context, const PopupEmoji(), 'Emoji'),
                    _buildShowcaseRow(context, const PopupSticker(), 'Sticker'),
                  ],
                ),
              ),
            ),
          ),
          MessageComposer(
            onSend: (text) {
              Get.snackbar(
                'Message Sent',
                text,
                snackPosition: SnackPosition.TOP,
                backgroundColor: context.appSurface,
                colorText: context.appTextPrimary,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarsContent(BuildContext context) {
    return Container(
      color: context.appBackground,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Initials Avatar',
                  style: AppTypography.heading1.adapt(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildAvatarGrid(
                  initials: 'SF',
                  badgeType: AvatarBadgeType.online,
                ),
                const SizedBox(height: AppSpacing.xxl),

                Text(
                  'Icon Avatar',
                  style: AppTypography.heading1.adapt(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildAvatarGrid(
                  defaultIcon: Icons.person,
                  badgeType: AvatarBadgeType.offline,
                ),
                const SizedBox(height: AppSpacing.xxl),

                Text(
                  'Image Avatar',
                  style: AppTypography.heading1.adapt(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildAvatarGrid(
                  imageUrl: 'https://i.pravatar.cc/150?u=scott',
                  badgeType: AvatarBadgeType.notification,
                  notificationCount: 3,
                ),
              ],
            ),
          ),
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

  Widget _sidebarContent(BuildContext context, {required bool isDrawer}) {
    return Container(
      width: isDrawer ? null : 280,
      color: context.appSurface,
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
                  Flexible(
                    child: Text(
                      'Component Library',
                      style: AppTypography.heading2.adapt(context),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        controller.isDarkMode.value
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: context.appTextPrimary,
                      ),
                      tooltip: 'Toggle Light/Dark Mode',
                      onPressed: controller.toggleTheme,
                      splashRadius: 20,
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
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? AppColors.primaryBlue
                              : context.appTextPrimary,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: AppColors.primaryBlue.withValues(
                        alpha: 0.1,
                      ),
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
              backgroundColor: context.appSurface,
              foregroundColor: context.appTextPrimary,
              elevation: 0,
              title: Obx(
                () => Text(
                  controller.menus[controller.selectedIndex.value],
                  style: AppTypography.heading2.adapt(context),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(color: context.appDivider, height: 1.0),
              ),
            ),
            drawer: Drawer(
              backgroundColor: context.appSurface,
              child: _sidebarContent(context, isDrawer: true),
            ),
            body: contentArea,
          );
        }

        return Scaffold(
          backgroundColor: context.appBackground,
          body: Row(
            children: [
              _sidebarContent(context, isDrawer: false),
              VerticalDivider(
                thickness: 1,
                width: 1,
                color: context.appDivider,
              ),
              Expanded(child: contentArea),
            ],
          ),
        );
      },
    );
  }
}