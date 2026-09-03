import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import 'custom_avatar.dart';

enum ChatInputVariant {
  defaultState,
  focus,
  typing,
  multiline,
  mentioned,
  editMessage,
}

class ChatInputField extends StatelessWidget {
  final ChatInputVariant variant;

  const ChatInputField({
    super.key,
    this.variant = ChatInputVariant.defaultState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (variant == ChatInputVariant.mentioned) ...[
          _buildMentionPopup(context),
          const SizedBox(height: AppSpacing.sm),
        ],
        Container(
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  variant == ChatInputVariant.focus ||
                      variant == ChatInputVariant.typing
                  ? AppColors.textSecondary.withValues(alpha: 0.5)
                  : context.appDivider,
            ),
            boxShadow: [
              if (variant == ChatInputVariant.focus ||
                  variant == ChatInputVariant.typing)
                BoxShadow(
                  color: AppColors.textSecondary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (variant == ChatInputVariant.editMessage)
                _buildEditHeader(context),
              _buildInputArea(context),
              _buildBottomActions(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMentionPopup(BuildContext context) {
    final users = [
      {
        'name': 'Alex Mason',
        'avatar': 'https://i.pravatar.cc/150?u=alex',
        'selected': false,
      },
      {
        'name': 'Andrew Joseph',
        'avatar': 'https://i.pravatar.cc/150?u=andrew',
        'selected': false,
      },
      {
        'name': 'Avery Quinn',
        'avatar': 'https://i.pravatar.cc/150?u=avery',
        'selected': true,
      },
    ];

    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: users.length,
          itemBuilder: (context, index) {
            final u = users[index];
            final isSelected = u['selected'] == true;
            return InkWell(
              onTap: () {}, // Handle mention selection
              child: Container(
                color: isSelected
                    ? context.appDivider.withValues(alpha: 0.5)
                    : Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    CustomAvatar(
                      imageUrl: u['avatar'] as String,
                      size: AvatarSize.sm,
                      shape: AvatarShape.circle,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        u['name'] as String,
                        style: AppTypography.bodyMedium
                            .copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            )
                            .adapt(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.isDark
            ? context.appDivider.withValues(alpha: 0.2)
            : AppColors.backgroundLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Message',
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.bold)
                .adapt(context),
          ),
          Text('Previous message', style: AppTypography.caption.adapt(context)),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    String text = '';
    String hint = 'Type your message...';

    if (variant == ChatInputVariant.typing) {
      text = 'First line|';
      hint = '';
    } else if (variant == ChatInputVariant.multiline) {
      text =
          'Hey! Just finished the draft for the project.\nNeed your feedback by tomorrow if possible.|';
      hint = '';
    } else if (variant == ChatInputVariant.mentioned ||
        variant == ChatInputVariant.editMessage) {
      text = 'First line|';
      hint = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: variant == ChatInputVariant.mentioned
          ? RichText(
              text: TextSpan(
                style: AppTypography.body.adapt(context),
                children: [
                  const TextSpan(
                    text: '@john ',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '@a|',
                    style: AppTypography.body.adapt(context),
                  ),
                ],
              ),
            )
          : Text(
              text.isEmpty ? hint : text,
              style: text.isEmpty
                  ? AppTypography.bodySecondary.adapt(context)
                  : AppTypography.body.adapt(context),
            ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    bool isActive =
        variant == ChatInputVariant.typing ||
        variant == ChatInputVariant.multiline ||
        variant == ChatInputVariant.mentioned ||
        variant == ChatInputVariant.editMessage;

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: const [
                IconAction(icon: Icons.add_circle_outline),
                IconAction(icon: Icons.mic_none),
                IconAction(icon: Icons.emoji_emotions_outlined),
                IconAction(icon: Icons.sticky_note_2_outlined),
                IconAction(icon: Icons.auto_awesome),
              ],
            ),
          ),
          InkWell(
            onTap: isActive ? () {} : null,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryBlue : context.appDivider,
                shape: BoxShape.circle,
              ),
              child: Icon(
                variant == ChatInputVariant.editMessage
                    ? Icons.check
                    : Icons.send,
                color: isActive ? Colors.white : AppColors.textTertiary,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconAction extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const IconAction({super.key, required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color ?? context.appTextSecondary,
        size: size ?? 24,
      ),
      onPressed: () {},
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ), // Touch target 40dp min
      padding: EdgeInsets.zero,
      splashRadius: 20,
    );
  }
}

// ==========================================
// VOICE COMPOSER VARIANTS
// ==========================================

enum VoiceComposerVariant { defaultState, pause, recording, preview }

class VoiceComposer extends StatelessWidget {
  final VoiceComposerVariant variant;
  const VoiceComposer({
    super.key,
    this.variant = VoiceComposerVariant.defaultState,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == VoiceComposerVariant.preview) {
      return _buildPreviewState(context);
    }

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appDivider),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryBlue,
              child: Icon(Icons.mic, color: Colors.white, size: 32),
            ),
          ),
          if (variant != VoiceComposerVariant.defaultState) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              '00:00:10',
              style: AppTypography.bodyMedium
                  .copyWith(fontFeatures: const [FontFeature.tabularFigures()])
                  .adapt(context),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, Icons.delete_outline, false),
              const SizedBox(width: AppSpacing.md),
              if (variant == VoiceComposerVariant.defaultState ||
                  variant == VoiceComposerVariant.pause)
                _buildCircleIconBtn(context, Icons.mic, true, isRed: true)
              else
                _buildCircleIconBtn(context, Icons.pause, true, isRed: true),
              const SizedBox(width: AppSpacing.md),
              _buildCircleIconBtn(context, Icons.stop, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewState(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appDivider),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _buildAudioWaveform()),
                const SizedBox(width: AppSpacing.sm),
                const Text(
                  '00:00/00:32',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, Icons.delete_outline, false),
              const SizedBox(width: AppSpacing.lg),
              InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              _buildCircleIconBtn(context, Icons.mic_none, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAudioWaveform() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(20, (index) {
        final heights = [
          4,
          8,
          12,
          6,
          16,
          10,
          4,
          18,
          14,
          8,
          20,
          10,
          6,
          12,
          16,
          8,
          4,
          14,
          6,
          8,
        ];
        return Container(
          width: 2,
          height: heights[index].toDouble(),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }

  Widget _buildCircleIconBtn(
    BuildContext context,
    IconData icon,
    bool isSolid, {
    bool isRed = false,
  }) {
    Color iconColor = isRed ? AppColors.error : context.appTextSecondary;
    Color bgColor = isRed
        ? AppColors.error.withValues(alpha: 0.1)
        : context.appDivider.withValues(alpha: 0.5);

    return InkWell(
      onTap: () {},
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSolid ? bgColor : Colors.transparent,
          shape: BoxShape.circle,
          border: isSolid ? null : Border.all(color: context.appDivider),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}

// ==========================================
// POPUP / FEATURE VARIANTS (REFACTORED)
// ==========================================

class PopupAttachment extends StatelessWidget {
  const PopupAttachment({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPopupContainer(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(context, CupertinoIcons.camera_fill, 'Camera'),
                _buildMenuItem(
                  context,
                  CupertinoIcons.photo_fill,
                  'Attach Image',
                ),
                _buildMenuItem(
                  context,
                  CupertinoIcons.video_camera_solid,
                  'Attach Video',
                ),
                _buildMenuItem(
                  context,
                  CupertinoIcons.play_circle_fill,
                  'Attach Audio',
                ),
                _buildMenuItem(
                  context,
                  CupertinoIcons.doc_fill,
                  'Attach Document',
                ),
                _buildMenuItem(context, Icons.bar_chart, 'Poll'),
                _buildMenuItem(
                  context,
                  Icons.gesture,
                  'Collaborative Whiteboard',
                ),
                _buildMenuItem(
                  context,
                  Icons.edit_document,
                  'Collaborative Document',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      const IconAction(icon: CupertinoIcons.mic),
                      const IconAction(icon: CupertinoIcons.smiley),
                      const IconAction(icon: CupertinoIcons.doc),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: context.appDivider,
                    foregroundColor: AppColors.textTertiary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ), // Touch target > 48dp
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium
                    .copyWith(fontWeight: FontWeight.w500)
                    .adapt(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopupEmoji extends StatelessWidget {
  const PopupEmoji({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPopupContainer(
      context: context,
      height: 320, // Bounded height for Lazy Loading ScrollView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Center(
              child: Text(
                'Smiley & People',
                style: AppTypography.caption.adapt(context),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 70, // Simulated data
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: const Center(
                    child: Text('😀', style: TextStyle(fontSize: 24)),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1, color: context.appDivider),
          _buildEmojiTabBar(context),
        ],
      ),
    );
  }

  Widget _buildEmojiTabBar(BuildContext context) {
    final icons = [
      Icons.access_time,
      Icons.emoji_emotions_outlined,
      Icons.pets,
      Icons.fastfood,
      Icons.sports_soccer,
      Icons.directions_car,
      Icons.lightbulb_outline,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(icons.length, (index) {
          final isActive = index == 1;
          return IconButton(
            icon: Icon(
              icons[index],
              color: isActive
                  ? AppColors.primaryBlue
                  : context.appTextSecondary,
              size: 22,
            ),
            onPressed: () {},
          );
        }),
      ),
    );
  }
}

class PopupSticker extends StatelessWidget {
  const PopupSticker({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPopupContainer(
      context: context,
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStickerTabBar(context),
          Divider(height: 1, color: context.appDivider),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Recent Stickers',
              style: AppTypography.caption.adapt(context),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Proporsional untuk sticker
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.face, color: Colors.orange, size: 40),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickerTabBar(BuildContext context) {
    final icons = [
      Icons.access_time,
      Icons.emoji_emotions_outlined,
      Icons.pets,
      Icons.fastfood,
      Icons.sports_soccer,
      Icons.directions_car,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(icons.length, (index) {
          final isActive = index == 0;
          return IconButton(
            icon: Icon(
              icons[index],
              color: isActive
                  ? AppColors.primaryBlue
                  : context.appTextSecondary,
              size: 22,
            ),
            onPressed: () {},
          );
        }),
      ),
    );
  }
}

// ==========================================
// AI FEATURE VARIANTS
// ==========================================

class PopupAiMenu extends StatelessWidget {
  const PopupAiMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPopupContainer(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(
              context,
              Icons.chat_bubble_outline,
              'Suggest a reply',
            ),
            _buildMenuItem(
              context,
              Icons.summarize_outlined,
              'Conversation summary',
            ),
            _buildMenuItem(context, Icons.smart_toy_outlined, 'Ask AI Bot'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 12.0,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.adapt(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiCard extends StatelessWidget {
  final String title;
  final String content;

  const AiCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.sm,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600)
                      .adapt(context),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  iconSize: 18,
                  color: context.appTextSecondary,
                  onPressed: () {},
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.appDivider),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              content,
              style: AppTypography.bodyMedium
                  .copyWith(height: 1.5)
                  .adapt(context),
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationStarters extends StatelessWidget {
  const ConversationStarters({super.key});

  @override
  Widget build(BuildContext context) {
    final chips = [
      'Hi there! How\'s it going?',
      'Hey, how are you doing today?',
      'Hello! How\'s your day been so far?',
      'Hope all\'s well!',
      'How\'s your day?',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips
          .map(
            (c) => InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: context.appDivider),
                ),
                child: Text(
                  c,
                  style: AppTypography.bodySecondary.adapt(context),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// Utility wrapper for popups
Widget _buildPopupContainer({
  required BuildContext context,
  required Widget child,
  double? height,
}) {
  return Material(
    color: context.appSurface,
    borderRadius: BorderRadius.circular(16),
    elevation: 8,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    child: Container(
      width: double.infinity,
      height: height,
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appDivider),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(15), child: child),
    ),
  );
}
