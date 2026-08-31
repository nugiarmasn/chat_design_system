import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class MessageComposer extends StatefulWidget {
  final ValueChanged<String>? onSend;
  final VoidCallback? onPlusTap;
  final VoidCallback? onMicTap;
  final VoidCallback? onEmojiTap;
  final VoidCallback? onGalleryTap;

  const MessageComposer({
    super.key,
    this.onSend,
    this.onPlusTap,
    this.onMicTap,
    this.onEmojiTap,
    this.onGalleryTap,
  });

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final TextEditingController _textController = TextEditingController();
  bool _isRecording = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _hasText = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_hasText) {
      widget.onSend?.call(_textController.text);
      _textController.clear();
    }
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1.0),
        ),
      ),
      child: SafeArea(
        child: _isRecording ? _buildRecordingState() : _buildNormalState(),
      ),
    );
  }

  Widget _buildNormalState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.xs,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _textController,
            maxLines: 5,
            minLines: 1,
            style: AppTypography.body,
            decoration: InputDecoration(
              hintText: 'Type your message...',
              hintStyle: AppTypography.body.copyWith(
                color: AppColors.textTertiary,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              _buildIconButton(
                Icons.add_circle_outline,
                widget.onPlusTap,
              ),
              _buildIconButton(
                Icons.mic_none,
                () {
                  widget.onMicTap?.call();
                  _toggleRecording(); // Demo static UI
                },
              ),
              _buildIconButton(
                Icons.emoji_emotions_outlined,
                widget.onEmojiTap,
              ),
              _buildIconButton(
                Icons.image_outlined,
                widget.onGalleryTap,
              ),
              const Spacer(),
              _buildSendButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _toggleRecording,
            icon: const Icon(Icons.delete_outline, color: AppColors.textSecondary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Spacer(),
          // Bouncing/Vibrating mic representation
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic,
              color: AppColors.error,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            '00:00:10',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.error,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: _toggleRecording,
            icon: const Icon(Icons.stop_circle_outlined, color: AppColors.textSecondary, size: 28),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(
          icon,
          color: AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    final bool isEnabled = _hasText;
    return InkWell(
      onTap: isEnabled ? _handleSend : null,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primaryBlue : AppColors.divider,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.send,
          color: isEnabled ? AppColors.surfaceWhite : AppColors.textTertiary,
          size: 20,
        ),
      ),
    );
  }
}
