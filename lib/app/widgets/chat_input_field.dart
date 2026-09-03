import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import 'custom_avatar.dart';

// Warna spesifik Figma untuk tombol aktif
const Color _figmaPurple = Color(0xFF5B38C9);
const Color _figmaGrey = Color(0xFFE5E5EA);

enum ChatInputVariant {
  defaultState,
  focus,
  typing,
  multiline,
  mentioned,
  editMessage,
  aiActive, // Tambahan dari temen lu
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
            borderRadius: BorderRadius.circular(16), // Rounded seperti Figma
            border: Border.all(
              color: variant == ChatInputVariant.focus || variant == ChatInputVariant.typing
                  ? _figmaPurple.withValues(alpha: 0.3)
                  : context.appDivider.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              if (variant == ChatInputVariant.focus || variant == ChatInputVariant.typing)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 15,
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
                Divider(height: 1, color: context.appDivider.withValues(alpha: 0.5)),
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
      {'name': 'Alex Mason', 'avatar': 'https://i.pravatar.cc/150?u=alex', 'selected': false},
      {'name': 'Andrew Joseph', 'avatar': 'https://i.pravatar.cc/150?u=andrew', 'selected': false},
      {'name': 'Avery Quinn', 'avatar': 'https://i.pravatar.cc/150?u=avery', 'selected': true},
    ];

    // MENGGABUNGKAN: Desain Figma rekan Anda + Arsitektur ListView (Performa)
    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(16),
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.06),
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
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Container(
                color: isSelected ? context.appDivider.withValues(alpha: 0.3) : Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10),
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
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ).adapt(context),
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDark ? Colors.white10 : const Color(0xFFF8F9FA),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Message', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: context.appTextPrimary)),
          Text('Previous message', style: AppTypography.caption.copyWith(color: context.appTextSecondary, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    String text = '';
    String hint = 'Type your message...';

    if (variant == ChatInputVariant.typing || variant == ChatInputVariant.editMessage) {
      text = 'First line|';
      hint = '';
    } else if (variant == ChatInputVariant.multiline) {
      text = 'Hey! Just finished the draft for the project.\nNeed your feedback by tomorrow if possible.|';
      hint = '';
    }

    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.md, bottom: 8),
      child: variant == ChatInputVariant.mentioned
          ? RichText(
              text: TextSpan(
                style: AppTypography.body.adapt(context),
                children: [
                  const TextSpan(text: '@john ', style: TextStyle(color: _figmaPurple, fontWeight: FontWeight.w500)),
                  TextSpan(text: '@a|', style: AppTypography.body.adapt(context)),
                ],
              ),
            )
          : Text(
              text.isEmpty ? hint : text,
              style: text.isEmpty
                  ? AppTypography.bodySecondary.copyWith(color: Colors.grey.shade400).adapt(context)
                  : AppTypography.body.copyWith(fontWeight: FontWeight.w400).adapt(context),
            ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    bool isActive = variant == ChatInputVariant.typing || variant == ChatInputVariant.multiline || variant == ChatInputVariant.mentioned || variant == ChatInputVariant.editMessage;
    bool isAiActive = variant == ChatInputVariant.aiActive;

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 12, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const IconAction(icon: CupertinoIcons.add_circled),
                const IconAction(icon: CupertinoIcons.mic),
                const IconAction(icon: CupertinoIcons.smiley),
                const IconAction(icon: CupertinoIcons.doc),
                IconAction(
                  icon: CupertinoIcons.sparkles,
                  color: isAiActive ? _figmaPurple : null,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: isActive ? () {} : null,
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? _figmaPurple : _figmaGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                variant == ChatInputVariant.editMessage ? Icons.check : Icons.send_rounded,
                color: Colors.white,
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

  const IconAction({super.key, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    // MENGGABUNGKAN: IconButton (aksesibilitas touch target > 40dp) + Parameter warna rekan Anda
    return IconButton(
      icon: Icon(icon, color: color ?? Colors.grey.shade500, size: 22),
      onPressed: () {},
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
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
  const VoiceComposer({super.key, this.variant = VoiceComposerVariant.defaultState});

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
    if (variant == VoiceComposerVariant.preview) return _buildPreviewCard(context);

    final bool isDefault = variant == VoiceComposerVariant.defaultState;
    final bool isPause = variant == VoiceComposerVariant.pause;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.symmetric(vertical: 32),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDefault ? _figmaGrey : _figmaPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.mic_fill, color: Colors.white, size: 36),
          ),
          if (!isDefault) ...[
            const SizedBox(height: 16),
            Text(
              '00:00:10',
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()], // Hindari angka bergoyang
              ).adapt(context),
            ),
          ] else ...[
            const SizedBox(height: 36),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, CupertinoIcons.trash, false),
              const SizedBox(width: 24),
              if (isDefault || isPause)
                _buildCircleIconBtn(context, CupertinoIcons.mic_fill, true, isRed: true)
              else
                _buildCircleIconBtn(context, CupertinoIcons.pause_fill, true, isRed: true),
              const SizedBox(width: 24),
              _buildCircleIconBtn(context, CupertinoIcons.stop_fill, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _figmaPurple,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.play_arrow_rounded, color: _figmaPurple, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildAudioWaveform()),
                const SizedBox(width: 12),
                const Text(
                  '00:00/00:32',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500, fontFeatures: [FontFeature.tabularFigures()]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIconBtn(context, CupertinoIcons.trash, false),
              const SizedBox(width: 24),
              InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: const Icon(Icons.send_rounded, color: _figmaPurple, size: 24),
                ),
              ),
              const SizedBox(width: 24),
              _buildCircleIconBtn(context, CupertinoIcons.mic, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAudioWaveform() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(15, (index) {
        final heights = [4, 8, 12, 6, 16, 10, 4, 18, 14, 8, 20, 10, 6, 12, 8];
        return Container(
          width: 2.5,
          height: heights[index].toDouble(),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget _buildCircleIconBtn(BuildContext context, IconData icon, bool isSolid, {bool isRed = false}) {
    Color iconColor = isRed ? AppColors.error : Colors.grey.shade600;
    Color bgColor = isRed ? AppColors.error.withValues(alpha: 0.1) : Colors.transparent;

    return InkWell(
      onTap: () {},
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: isSolid ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildBottomForm(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appDivider.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                IconAction(icon: CupertinoIcons.add_circled),
                IconAction(icon: CupertinoIcons.mic),
                IconAction(icon: CupertinoIcons.smiley),
                IconAction(icon: CupertinoIcons.doc),
                IconAction(icon: CupertinoIcons.sparkles),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: _figmaGrey, shape: BoxShape.circle),
            child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// POPUPS / FEATURE VARIANTS
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
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(context, CupertinoIcons.camera_fill, 'Camera'),
                _buildMenuItem(context, CupertinoIcons.photo_fill, 'Attach Image'),
                _buildMenuItem(context, CupertinoIcons.video_camera_solid, 'Attach Video'),
                _buildMenuItem(context, CupertinoIcons.play_circle_fill, 'Attach Audio'),
                _buildMenuItem(context, CupertinoIcons.doc_fill, 'Attach Document'),
                _buildMenuItem(context, Icons.poll, 'Poll'),
                _buildMenuItem(context, Icons.gesture, 'Collaborative Whiteboard'),
                _buildMenuItem(context, Icons.edit_document, 'Collaborative Document'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: _figmaPurple, shape: BoxShape.circle),
                      child: const Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ),
                  const IconAction(icon: CupertinoIcons.mic),
                  const IconAction(icon: CupertinoIcons.smiley),
                  const IconAction(icon: CupertinoIcons.doc),
                  const IconAction(icon: CupertinoIcons.sparkles),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: _figmaGrey, shape: BoxShape.circle),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: _figmaPurple, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label, 
                style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500).adapt(context),
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
    // MENGGABUNGKAN: GridView untuk performa, Figma untuk visual
    return _buildPopupContainer(
      context: context,
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Center(
              child: Text(
                'Smiley & People', 
                style: AppTypography.caption.copyWith(color: Colors.grey.shade500),
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
              itemCount: 70, 
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: const Center(child: Text('😀', style: TextStyle(fontSize: 22))),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Divider(height: 1, color: context.appDivider.withValues(alpha: 0.5)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.access_time, color: _figmaPurple, size: 22),
                Icon(Icons.emoji_emotions_outlined, color: Colors.grey.shade400, size: 22),
                Icon(Icons.pets, color: Colors.grey.shade400, size: 22),
                Icon(Icons.fastfood, color: Colors.grey.shade400, size: 22),
                Icon(Icons.sports_soccer, color: Colors.grey.shade400, size: 22),
                Icon(Icons.directions_car, color: Colors.grey.shade400, size: 22),
                Icon(Icons.lightbulb_outline, color: Colors.grey.shade400, size: 22),
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
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.access_time, color: _figmaPurple, size: 22),
                Icon(Icons.emoji_emotions_outlined, color: Colors.grey.shade400, size: 22),
                Icon(Icons.pets, color: Colors.grey.shade400, size: 22),
                Icon(Icons.fastfood, color: Colors.grey.shade400, size: 22),
                Icon(Icons.sports_soccer, color: Colors.grey.shade400, size: 22),
                Icon(Icons.directions_car, color: Colors.grey.shade400, size: 22),
              ],
            ),
          ),
          Divider(height: 1, color: context.appDivider.withValues(alpha: 0.5)),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
            child: Text(
              'Recent Stickers', 
              style: AppTypography.caption.copyWith(color: Colors.grey.shade500),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, 
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(Icons.face_retouching_natural, color: Colors.orange.shade400, size: 40),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
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
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: _figmaPurple, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label, 
                style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500).adapt(context),
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
          constraints: const BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 15, offset: const Offset(0, 4)),
            ],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 12, top: 12, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold).adapt(context)),
                    IconButton(
                      icon: Icon(CupertinoIcons.xmark, size: 16, color: Colors.grey.shade500),
                      onPressed: () {},
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: context.appDivider.withValues(alpha: 0.5)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: isSuggest ? Column(
                  children: [
                    _buildSuggestItem(context, 'Thanks for handling the logistics, Michael. Your effort in securing the group discount for the hotel is much appreciated!'),
                    const SizedBox(height: 12),
                    _buildSuggestItem(context, 'Michael, I appreciate you taking care of the logistics and getting us that group discount at the hotel. Thanks a lot!'),
                    const SizedBox(height: 12),
                    _buildSuggestItem(context, 'Thank you, Michael, for organizing everything. Your work on getting the group discount for the hotel didn\'t go unnoticed!'),
                  ],
                ) : Text(content, style: AppTypography.bodyMedium.copyWith(height: 1.5, color: Colors.grey.shade800).adapt(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestItem(BuildContext context, String text) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: AppTypography.bodyMedium.copyWith(height: 1.4, color: Colors.grey.shade700).adapt(context)),
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Wrap(
            spacing: 8,
            runSpacing: 10,
            children: chips.map((c) => InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: Text(c, style: AppTypography.bodyMedium.copyWith(color: Colors.grey.shade700).adapt(context)),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 16),
        const ChatInputField(variant: ChatInputVariant.defaultState),
      ],
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
    borderRadius: BorderRadius.circular(20),
    elevation: 8,
    shadowColor: Colors.black.withValues(alpha: 0.06),
    child: Container(
      width: double.infinity,
      height: height,
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19), 
        child: child,
      ),
    ),
  );
}