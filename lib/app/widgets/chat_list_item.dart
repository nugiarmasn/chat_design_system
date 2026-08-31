import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'custom_avatar.dart';

enum MessageType {
  text,
  photo,
}

enum MessageStatus {
  none,
  sent, // Single grey check
  delivered, // Double grey check
  read, // Double blue check
}

class ChatListItem extends StatelessWidget {
  final String name;
  final String time;
  final String messageSnippet;
  final String avatarUrl;
  final bool isOnline;
  final bool showStatusBadge;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final String? senderPrefix; // e.g., "You: ", "Sender: "
  final VoidCallback? onTap;

  const ChatListItem({
    super.key,
    required this.name,
    required this.time,
    required this.messageSnippet,
    required this.avatarUrl,
    this.isOnline = false,
    this.showStatusBadge = false,
    this.messageType = MessageType.text,
    this.messageStatus = MessageStatus.none,
    this.senderPrefix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAvatar(
              imageUrl: avatarUrl,
              size: AvatarSize.lg, // Large is usually standard for chat lists (e.g. 48-64px)
              badgeType: showStatusBadge 
                  ? (isOnline ? AvatarBadgeType.online : AvatarBadgeType.offline)
                  : AvatarBadgeType.none,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        time,
                        style: AppTypography.timeLabel,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      if (messageStatus != MessageStatus.none) ...[
                        _buildStatusIcon(),
                        const SizedBox(width: 4),
                      ],
                      if (senderPrefix != null && senderPrefix!.isNotEmpty) ...[
                        Text(
                          senderPrefix!,
                          style: AppTypography.bodySecondary,
                        ),
                        const SizedBox(width: 2),
                      ],
                      if (messageType == MessageType.photo) ...[
                        const Icon(
                          Icons.image,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Photo',
                          style: AppTypography.bodySecondary.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (messageSnippet.isNotEmpty) ...[
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              messageSnippet,
                              style: AppTypography.bodySecondary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]
                      ] else ...[
                        Expanded(
                          child: Text(
                            messageSnippet,
                            style: AppTypography.bodySecondary,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    IconData iconData;
    Color iconColor;

    switch (messageStatus) {
      case MessageStatus.sent:
        iconData = Icons.check;
        iconColor = AppColors.textTertiary;
        break;
      case MessageStatus.delivered:
        iconData = Icons.done_all;
        iconColor = AppColors.textTertiary;
        break;
      case MessageStatus.read:
        iconData = Icons.done_all;
        iconColor = AppColors.primaryBlue;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Icon(
      iconData,
      size: 16,
      color: iconColor,
    );
  }
}
