import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Enum untuk menentukan status baca pesan (centang)
enum ChatReadStatus {
  none,
  sent,       // Centang satu abu-abu
  delivered,  // Centang dua abu-abu
  read,       // Centang dua biru
}

/// Komponen reusable untuk satu baris list obrolan
class ChatListTile extends StatelessWidget {
  final String avatarInitials;
  final IconData? avatarIcon;
  final String name;
  final String messageSnippet;
  final String time;
  final ChatReadStatus readStatus;
  final bool hasAttachment;
  final String? senderPrefix;
  final VoidCallback? onTap;

  const ChatListTile({
    super.key,
    required this.name,
    required this.messageSnippet,
    required this.time,
    this.avatarInitials = '',
    this.avatarIcon,
    this.readStatus = ChatReadStatus.none,
    this.hasAttachment = false,
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
            // 1. Sisi Kiri: Foto profil / Avatar
            _buildAvatar(context),
            const SizedBox(width: AppSpacing.md),
            
            // 2. Sisi Tengah: Nama User dan Cuplikan Pesan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ).adapt(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _buildMessageSnippet(context),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            
            // 3. Sisi Kanan: Jam/Waktu dan indikator status baca
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: AppTypography.timeLabel.adapt(context),
                ),
                const SizedBox(height: AppSpacing.xs),
                _buildReadStatusIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Membuat widget avatar berdasarkan inisial atau icon
  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.primaryPurple,
      child: avatarIcon != null
          ? Icon(avatarIcon, color: AppColors.surfaceWhite, size: 24)
          : Text(
              avatarInitials,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  /// Membuat widget baris untuk cuplikan pesan dengan icon attachment jika ada
  Widget _buildMessageSnippet(BuildContext context) {
    return Row(
      children: [
        if (senderPrefix != null) ...[
          Text(
            senderPrefix!,
            style: AppTypography.bodySecondary.copyWith(
              color: context.appTextPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        if (hasAttachment) ...[
          Icon(
            Icons.image,
            size: 14,
            color: context.appTextSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            'Photo ',
            style: AppTypography.bodySecondary.copyWith(
              fontWeight: FontWeight.w500,
            ).adapt(context),
          ),
        ],
        Expanded(
          child: Text(
            messageSnippet,
            style: AppTypography.bodySecondary.adapt(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Membuat widget indikator status baca (centang)
  Widget _buildReadStatusIcon() {
    IconData? iconData;
    Color iconColor = AppColors.textTertiary;

    switch (readStatus) {
      case ChatReadStatus.sent:
        iconData = Icons.check;
        break;
      case ChatReadStatus.delivered:
        iconData = Icons.done_all;
        break;
      case ChatReadStatus.read:
        iconData = Icons.done_all;
        iconColor = AppColors.primaryBlue;
        break;
      case ChatReadStatus.none:
      default:
        return const SizedBox(height: 16, width: 16); // Placeholder kosong
    }

    return Icon(
      iconData,
      size: 16,
      color: iconColor,
    );
  }
}
