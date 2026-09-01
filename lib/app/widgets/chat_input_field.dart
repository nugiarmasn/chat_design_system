import 'package:flutter/material.dart';
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: variant == ChatInputVariant.focus || variant == ChatInputVariant.typing
                  ? AppColors.textSecondary.withOpacity(0.5)
                  : context.appDivider,
            ),
            boxShadow: [
              if (variant == ChatInputVariant.focus || variant == ChatInputVariant.typing)
                BoxShadow(
                  color: AppColors.textSecondary.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (variant == ChatInputVariant.editMessage) ...[
                _buildEditHeader(context),
              ],
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
      {'name': 'Alex Mason', 'avatar': 'https://i.pravatar.cc/150?u=alex'},
      {'name': 'Andrew Joseph', 'avatar': 'https://i.pravatar.cc/150?u=andrew'},
      {'name': 'Avery Quinn', 'avatar': 'https://i.pravatar.cc/150?u=avery', 'selected': true},
      {'name': 'Brian Michael', 'avatar': 'https://i.pravatar.cc/150?u=brian'},
      {'name': 'Cameron Lee', 'avatar': 'https://i.pravatar.cc/150?u=cameron'},
      {'name': 'Charles Dean', 'avatar': 'https://i.pravatar.cc/150?u=charles'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: users.map((u) {
          final isSelected = u['selected'] == true;
          return Container(
            color: isSelected ? context.appDivider.withOpacity(0.5) : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Row(
              children: [
                CustomAvatar(
                  imageUrl: u['avatar'] as String,
                  size: AvatarSize.sm,
                  shape: AvatarShape.circle,
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  u['name'] as String,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ).adapt(context),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEditHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.isDark ? context.appDivider.withOpacity(0.2) : AppColors.backgroundLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Message', style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600).adapt(context)),
          Text('Previous message', style: AppTypography.caption),
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
      text = 'Hey! Just finished the draft for the project.\nNeed your feedback by tomorrow if possible.|';
      hint = '';
    } else if (variant == ChatInputVariant.mentioned) {
      text = '';
      hint = '';
    } else if (variant == ChatInputVariant.editMessage) {
      text = 'First line|';
      hint = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
      child: variant == ChatInputVariant.mentioned
          ? RichText(
              text: TextSpan(
                style: AppTypography.body.adapt(context),
                children: [
                  TextSpan(text: '@john ', style: TextStyle(color: AppColors.primaryBlue)),
                  TextSpan(text: '@a|'),
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
    bool isActive = variant == ChatInputVariant.typing || variant == ChatInputVariant.multiline || variant == ChatInputVariant.mentioned || variant == ChatInputVariant.editMessage;
    
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.sm, right: AppSpacing.sm, bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                IconAction(icon: Icons.add_circle_outline),
                IconAction(icon: Icons.mic_none),
                IconAction(icon: Icons.emoji_emotions_outlined),
                IconAction(icon: Icons.sticky_note_2_outlined),
                IconAction(icon: Icons.auto_awesome),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.deepPurple : context.appDivider,
              shape: BoxShape.circle,
            ),
            child: Icon(
              variant == ChatInputVariant.editMessage ? Icons.check : Icons.send,
              color: isActive ? Colors.white : AppColors.textTertiary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class IconAction extends StatelessWidget {
  final IconData icon;
  const IconAction({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(icon, color: context.appTextSecondary, size: 24),
    );
  }
}

// ==========================================
// VOICE COMPOSER VARIANTS
// ==========================================

enum VoiceComposerVariant {
  defaultState,
  pause,
  recording,
  preview,
}

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.deepPurple.withOpacity(0.1),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.deepPurple,
              child: Icon(Icons.mic, color: Colors.white, size: 32),
            ),
          ),
          if (variant != VoiceComposerVariant.defaultState) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              '00:00:10',
              style: AppTypography.bodyMedium.adapt(context),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, Icons.delete_outline, false),
              const SizedBox(width: AppSpacing.md),
              if (variant == VoiceComposerVariant.defaultState || variant == VoiceComposerVariant.pause)
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.deepPurple,
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
                  child: const Icon(Icons.play_arrow, color: AppColors.deepPurple, size: 20),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _buildAudioWaveform()),
                const SizedBox(width: AppSpacing.sm),
                const Text('00:00/00:32', style: TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, Icons.delete_outline, false),
              const SizedBox(width: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
                  ],
                ),
                child: const Icon(Icons.send, color: AppColors.deepPurple, size: 28),
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
        final heights = [4, 8, 12, 6, 16, 10, 4, 18, 14, 8, 20, 10, 6, 12, 16, 8, 4, 14, 6, 8];
        return Container(
          width: 2,
          height: heights[index].toDouble(),
          color: Colors.white.withOpacity(0.7),
        );
      }),
    );
  }

  Widget _buildCircleIconBtn(BuildContext context, IconData icon, bool isSolid, {bool isRed = false}) {
    Color iconColor = isRed ? AppColors.error : context.appTextSecondary;
    Color bgColor = isRed ? AppColors.error.withOpacity(0.1) : context.appDivider.withOpacity(0.5);
    
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSolid ? bgColor : Colors.transparent,
        shape: BoxShape.circle,
        border: isSolid ? null : Border.all(color: context.appDivider),
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}

// ==========================================
// POPUP / FEATURE VARIANTS
// ==========================================

class PopupAttachment extends StatelessWidget {
  const PopupAttachment({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPopupContainer(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(context, Icons.camera_alt, 'Camera'),
          _buildMenuItem(context, Icons.image, 'Attach Image'),
          _buildMenuItem(context, Icons.videocam, 'Attach Video'),
          _buildMenuItem(context, Icons.audiotrack, 'Attach Audio'),
          _buildMenuItem(context, Icons.description, 'Attach Document'),
          Divider(height: 1, color: context.appDivider),
          _buildMenuItem(context, Icons.poll, 'Poll'),
          _buildMenuItem(context, Icons.brush, 'Collaborative Whiteboard'),
          _buildMenuItem(context, Icons.article, 'Collaborative Document'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.deepPurple, size: 20),
          const SizedBox(width: AppSpacing.md),
          Text(label, style: AppTypography.bodyMedium.adapt(context)),
        ],
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Center(child: Text('Smiley & People', style: AppTypography.caption)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(40, (index) {
                return const Text('😀', style: TextStyle(fontSize: 20));
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: context.appDivider),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.access_time, color: AppColors.deepPurple, size: 20),
                Icon(Icons.emoji_emotions_outlined, color: context.appTextSecondary, size: 20),
                Icon(Icons.pets, color: context.appTextSecondary, size: 20),
                Icon(Icons.fastfood, color: context.appTextSecondary, size: 20),
                Icon(Icons.sports_soccer, color: context.appTextSecondary, size: 20),
                Icon(Icons.directions_car, color: context.appTextSecondary, size: 20),
                Icon(Icons.lightbulb_outline, color: context.appTextSecondary, size: 20),
              ],
            ),
          ),
        ],
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.access_time, color: AppColors.deepPurple, size: 20),
                Icon(Icons.emoji_emotions_outlined, color: context.appTextSecondary, size: 20),
                Icon(Icons.pets, color: context.appTextSecondary, size: 20),
                Icon(Icons.fastfood, color: context.appTextSecondary, size: 20),
                Icon(Icons.sports_soccer, color: context.appTextSecondary, size: 20),
                Icon(Icons.directions_car, color: context.appTextSecondary, size: 20),
              ],
            ),
          ),
          Divider(height: 1, color: context.appDivider),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text('Recent Stickers', style: AppTypography.caption),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(6, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.face, color: Colors.orange, size: 40),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(context, Icons.chat_bubble_outline, 'Suggest a reply'),
          _buildMenuItem(context, Icons.summarize_outlined, 'Conversation summary'),
          _buildMenuItem(context, Icons.smart_toy_outlined, 'Ask AI Bot'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.deepPurple, size: 20),
          const SizedBox(width: AppSpacing.md),
          Text(label, style: AppTypography.bodyMedium.adapt(context)),
        ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600).adapt(context)),
                Icon(Icons.close, size: 16, color: context.appTextSecondary),
              ],
            ),
          ),
          Divider(height: 1, color: context.appDivider),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(content, style: AppTypography.bodyMedium.adapt(context)),
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
      children: chips.map((c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.appDivider),
        ),
        child: Text(c, style: AppTypography.caption.adapt(context)),
      )).toList(),
    );
  }
}

// Utility wrapper for popups
Widget _buildPopupContainer({required BuildContext context, required Widget child}) {
  return Container(
    width: double.infinity,
    constraints: const BoxConstraints(maxWidth: 280),
    decoration: BoxDecoration(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}
