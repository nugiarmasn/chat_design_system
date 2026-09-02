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
  aiActive,
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
                    fontWeight: FontWeight.bold,
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
          Text('Edit Message', style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold).adapt(context)),
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
                  : AppTypography.body.copyWith(fontWeight: FontWeight.w600).adapt(context),
            ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    bool isActive = variant == ChatInputVariant.typing || variant == ChatInputVariant.multiline || variant == ChatInputVariant.mentioned || variant == ChatInputVariant.editMessage;
    bool isAiActive = variant == ChatInputVariant.aiActive;
    
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.sm, right: AppSpacing.sm, bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const IconAction(icon: Icons.add_circle_outline),
                const IconAction(icon: CupertinoIcons.mic),
                const IconAction(icon: CupertinoIcons.smiley),
                const IconAction(icon: CupertinoIcons.doc),
                IconAction(
                  icon: CupertinoIcons.sparkles,
                  color: isAiActive ? const Color(0xFF130C88) : null,
                ),
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
  final Color? color;
  final double? size;
  const IconAction({super.key, required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(icon, color: color ?? context.appTextSecondary, size: size ?? 24),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.up,
      children: [
        _buildBottomForm(context),
        _buildVoiceCard(context),
      ],
    );
  }

  Widget _buildVoiceCard(BuildContext context) {
    if (variant == VoiceComposerVariant.preview) {
      return _buildPreviewCard(context);
    }
    
    final bool isRecording = variant == VoiceComposerVariant.recording;
    final bool isPause = variant == VoiceComposerVariant.pause;
    final bool isDefault = variant == VoiceComposerVariant.defaultState;
    
    final Color darkPurple = const Color(0xFF130C88);
    final Color brightRed = const Color(0xFFFF3B30);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isRecording ? 12.0 : 0.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRecording ? darkPurple.withOpacity(0.1) : Colors.transparent,
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: isDefault ? darkPurple.withOpacity(0.15) : darkPurple,
              child: const Icon(Icons.mic, color: Colors.white, size: 36),
            ),
          ),
          if (!isDefault) ...[
            const SizedBox(height: 16),
            Text(
              '00:00:10',
              style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500).adapt(context),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, Icons.delete_outline, iconColor: context.appTextSecondary),
              const SizedBox(width: 24),
              if (isRecording)
                _buildCircleIconBtn(context, Icons.pause, iconColor: brightRed)
              else
                _buildCircleIconBtn(context, Icons.mic, iconColor: brightRed),
              const SizedBox(width: 24),
              _buildCircleIconBtn(context, Icons.stop, iconColor: context.appTextSecondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(BuildContext context) {
    final Color darkPurple = const Color(0xFF130C88);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: darkPurple,
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
                  child: Icon(Icons.play_arrow, color: darkPurple, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildAudioWaveform()),
                const SizedBox(width: 12),
                const Text('00:00/00:32', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, Icons.delete_outline, iconColor: context.appTextSecondary),
              const SizedBox(width: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: darkPurple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: darkPurple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 24),
              _buildCircleIconBtn(context, Icons.mic_none, iconColor: context.appTextSecondary),
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

  Widget _buildCircleIconBtn(BuildContext context, IconData icon, {required Color iconColor}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.appDivider),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  Widget _buildBottomForm(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appDivider),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                IconAction(icon: Icons.add_circle_outline),
                IconAction(icon: CupertinoIcons.mic),
                IconAction(icon: CupertinoIcons.smiley),
                IconAction(icon: CupertinoIcons.doc),
                IconAction(icon: CupertinoIcons.sparkles),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.appDivider,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: AppColors.textTertiary, size: 20),
          ),
        ],
      ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPopupContainer(
          context: context,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(context, CupertinoIcons.camera_fill, 'Camera'),
                _buildMenuItem(context, CupertinoIcons.photo_fill, 'Attach Image'),
                _buildMenuItem(context, CupertinoIcons.video_camera_solid, 'Attach Video'),
                _buildMenuItem(context, CupertinoIcons.play_circle_fill, 'Attach Audio'),
                _buildMenuItem(context, CupertinoIcons.doc_fill, 'Attach Document'),
                _buildMenuItem(context, Icons.menu, 'Poll'),
                _buildWhiteboardMenuItem(context),
                _buildMenuItem(context, Icons.edit_document, 'Collaborative Document'),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appDivider),
          ),
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF130C88),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                    const IconAction(icon: CupertinoIcons.mic),
                    const IconAction(icon: CupertinoIcons.smiley),
                    const IconAction(icon: CupertinoIcons.doc),
                    const IconAction(icon: CupertinoIcons.sparkles),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.appDivider,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: AppColors.textTertiary, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWhiteboardMenuItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 12, top: 8, bottom: 8),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFF130C88),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Icon(Icons.gesture, color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          Text('Collaborative Whiteboard', style: AppTypography.bodyMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w500).adapt(context)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 12, top: 8, bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF130C88), size: 26),
          const SizedBox(width: 8),
          Text(label, style: AppTypography.bodyMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w500).adapt(context)),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChatInputField(variant: ChatInputVariant.aiActive),
        const SizedBox(height: 8),
        _buildPopupContainer(
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem(context, CupertinoIcons.chat_bubble_text_fill, 'Suggest a reply'),
              _buildMenuItem(context, CupertinoIcons.doc_text_fill, 'Conversation summary'),
              _buildMenuItem(context, Icons.smart_toy, 'Ask AI Bot'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF130C88), size: 22),
          const SizedBox(width: AppSpacing.md),
          Text(label, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500).adapt(context)),
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
    bool isSuggest = title.toLowerCase().contains('suggest');
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChatInputField(variant: ChatInputVariant.aiActive),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appDivider),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600).adapt(context)),
                    Icon(Icons.close, size: 20, color: context.appTextSecondary),
                  ],
                ),
              ),
              Divider(height: 1, color: context.appDivider),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: isSuggest ? Column(
                  children: [
                    _buildSuggestItem(context, 'Thanks for handling the logistics, Michael. Your effort in securing the group discount for the hotel is much appreciated!'),
                    const SizedBox(height: 12),
                    _buildSuggestItem(context, 'Michael, I appreciate you taking care of the logistics and getting us that group discount at the hotel. Thanks a lot!'),
                    const SizedBox(height: 12),
                    _buildSuggestItem(context, 'Thank you, Michael, for organizing everything. Your work on getting the group discount for the hotel didn\'t go unnoticed!'),
                  ],
                ) : Text(content, style: AppTypography.bodyMedium.copyWith(height: 1.5).adapt(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestItem(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: context.appDivider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: AppTypography.bodyMedium.copyWith(height: 1.5).adapt(context)),
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: chips.map((c) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: context.appSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: context.appDivider),
            ),
            child: Text(c, style: AppTypography.caption.copyWith(fontSize: 13, fontWeight: FontWeight.w500).adapt(context)),
          )).toList(),
        ),
        const SizedBox(height: 16),
        const ChatInputField(variant: ChatInputVariant.defaultState),
      ],
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
