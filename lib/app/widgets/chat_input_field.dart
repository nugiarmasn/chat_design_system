import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// State untuk ChatInputField menentukan tampilan input
enum ChatInputState {
  normal,
  recording,
}

/// Komponen reusable untuk area input pesan (Chat Input Field)
class ChatInputField extends StatelessWidget {
  final ChatInputState state;
  final String? initialText;
  final Widget? topWidget; // Tempat menaruh widget tambahan di atas input (misal: kotak suggest)

  const ChatInputField({
    super.key,
    this.state = ChatInputState.normal,
    this.initialText,
    this.topWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topWidget != null) ...[
          topWidget!,
          const SizedBox(height: AppSpacing.sm),
        ],
        Container(
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appDivider),
          ),
          child: state == ChatInputState.recording
              ? const VoiceNoteRecorder()
              : _buildNormalInput(context),
        ),
      ],
    );
  }

  /// Membuat UI kotak input normal dengan textfield dan action icons
  Widget _buildNormalInput(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: initialText != null ? TextEditingController(text: initialText) : null,
          style: AppTypography.body.adapt(context),
          decoration: InputDecoration(
            hintText: 'Type your message...',
            hintStyle: AppTypography.bodySecondary.adapt(context),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
          maxLines: null,
          textInputAction: TextInputAction.send,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: context.appTextSecondary,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic_none),
                    color: context.appTextSecondary,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    color: context.appTextSecondary,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.auto_awesome),
                    color: context.appTextSecondary,
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: AppColors.primaryBlue,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget khusus untuk state Voice Note saat merekam suara
class VoiceNoteRecorder extends StatelessWidget {
  const VoiceNoteRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primaryPurple.withOpacity(0.2),
            child: const Icon(Icons.mic, size: 32, color: AppColors.primaryPurple),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '00:00:10',
            style: AppTypography.bodyMedium.adapt(context),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: context.appTextSecondary,
                onPressed: () {},
              ),
              const SizedBox(width: AppSpacing.lg),
              CircleAvatar(
                backgroundColor: AppColors.error.withOpacity(0.1),
                child: const Icon(Icons.mic, color: AppColors.error), // Icon mic merah/pause
              ),
              const SizedBox(width: AppSpacing.lg),
              IconButton(
                icon: const Icon(Icons.stop),
                color: context.appTextSecondary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Menu overlay popup untuk attachment options
class AttachmentPopupMenu extends StatelessWidget {
  const AttachmentPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Ukuran popup statis untuk demo
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appDivider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildItem(context, Icons.camera_alt, 'Camera'),
          _buildItem(context, Icons.image, 'Attach Image'),
          _buildItem(context, Icons.videocam, 'Attach Video'),
          _buildItem(context, Icons.audiotrack, 'Attach Audio'),
          _buildItem(context, Icons.description, 'Attach Document'),
          Divider(height: 1, color: context.appDivider),
          _buildItem(context, Icons.poll, 'Poll'),
          _buildItem(context, Icons.brush, 'Collaborative Whiteboard'),
          _buildItem(context, Icons.article, 'Collaborative Document'),
        ],
      ),
    );
  }

  /// Membuat baris item menu di popup
  Widget _buildItem(BuildContext context, IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(label, style: AppTypography.bodyMedium.adapt(context)),
      dense: true,
      onTap: () {},
    );
  }
}

/// UI khusus untuk kotak 'Suggest a reply' atau 'Conversation summary'
class ActionSummaryBox extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final String content;

  const ActionSummaryBox({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.content,
  });

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
          // Bagian Header Kotak
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.xs,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs,
            ),
            child: Row(
              children: [
                Icon(titleIcon, color: AppColors.primaryBlue, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold).adapt(context),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  color: context.appTextSecondary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.appDivider),
          // Bagian Konten Teks
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              content,
              style: AppTypography.bodySecondary.adapt(context),
            ),
          ),
        ],
      ),
    );
  }
}
