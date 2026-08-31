import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Enum untuk ukuran Avatar
enum AvatarSize {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
}

/// Extension untuk mendapatkan ukuran pixel dari AvatarSize
extension AvatarSizeExtension on AvatarSize {
  double get value {
    switch (this) {
      case AvatarSize.xs: return 16.0;
      case AvatarSize.sm: return 24.0;
      case AvatarSize.md: return 32.0;
      case AvatarSize.lg: return 48.0;
      case AvatarSize.xl: return 64.0;
      case AvatarSize.xxl: return 80.0;
      case AvatarSize.xxxl: return 96.0;
    }
  }

  double get badgeSize {
    return value * 0.25; // Badge size is proportional to avatar size
  }

  double get fontSize {
    return value * 0.4;
  }
}

/// Enum untuk bentuk dasar Avatar
enum AvatarShape {
  circle,
  rounded,
  square,
}

/// Enum untuk tipe Badge
enum AvatarBadgeType {
  none,
  online,
  offline,
  notification,
}

/// Komponen CustomAvatar yang reusable
class CustomAvatar extends StatelessWidget {
  final AvatarSize size;
  final AvatarShape shape;
  final AvatarBadgeType badgeType;
  final String? imageUrl;
  final String? initials;
  final IconData? defaultIcon;
  final int notificationCount;

  const CustomAvatar({
    super.key,
    this.size = AvatarSize.md,
    this.shape = AvatarShape.circle,
    this.badgeType = AvatarBadgeType.none,
    this.imageUrl,
    this.initials,
    this.defaultIcon,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.value,
      height: size.value,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Base Avatar
          _buildBaseAvatar(),
          
          // Badge Overlay
          if (badgeType != AvatarBadgeType.none) _buildBadge(),
        ],
      ),
    );
  }

  /// Membuat bentuk dasar avatar beserta kontennya (gambar/inisial/ikon)
  Widget _buildBaseAvatar() {
    Widget content;

    // Menentukan konten: Image > Initials > Default Icon
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      content = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: size.value,
        height: size.value,
        errorBuilder: (_, __, ___) => _buildFallbackContent(),
      );
    } else {
      content = _buildFallbackContent();
    }

    // Menentukan bentuk (shape)
    switch (shape) {
      case AvatarShape.circle:
        return ClipOval(child: content);
      case AvatarShape.rounded:
        return ClipRRect(
          borderRadius: BorderRadius.circular(size.value * 0.3),
          child: content,
        );
      case AvatarShape.square:
        return ClipRRect(
          borderRadius: BorderRadius.circular(size.value * 0.1),
          child: content,
        );
    }
  }

  /// Konten fallback jika gambar tidak tersedia
  Widget _buildFallbackContent() {
    return Container(
      width: size.value,
      height: size.value,
      color: AppColors.primaryPurple,
      alignment: Alignment.center,
      child: initials != null && initials!.isNotEmpty
          ? Text(
              initials!,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                color: AppColors.surfaceWhite,
                fontWeight: FontWeight.bold,
                fontSize: size.fontSize,
              ),
            )
          : Icon(
              defaultIcon ?? Icons.person,
              color: AppColors.surfaceWhite,
              size: size.value * 0.6,
            ),
    );
  }

  /// Membuat badge di pojok kanan bawah
  Widget _buildBadge() {
    final badgeDiameter = size.badgeSize;
    final borderWidth = badgeDiameter * 0.15;
    
    Widget badgeContent = const SizedBox();
    Color badgeColor = Colors.transparent;

    switch (badgeType) {
      case AvatarBadgeType.online:
        badgeColor = AppColors.success;
        break;
      case AvatarBadgeType.offline:
        badgeColor = AppColors.textTertiary;
        break;
      case AvatarBadgeType.notification:
        badgeColor = AppColors.error;
        badgeContent = Center(
          child: Text(
            notificationCount > 9 ? '9+' : notificationCount.toString(),
            style: TextStyle(
              color: AppColors.surfaceWhite,
              fontSize: badgeDiameter * 0.6,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        break;
      case AvatarBadgeType.none:
        break;
    }

    // Posisi badge disesuaikan agar selalu berada di pojok kanan bawah
    // Untuk circle, posisinya sedikit lebih ke dalam dibanding kotak
    final double offset = shape == AvatarShape.circle ? badgeDiameter * 0.15 : -badgeDiameter * 0.1;

    return Positioned(
      bottom: offset,
      right: offset,
      child: Container(
        width: badgeDiameter,
        height: badgeDiameter,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.surfaceWhite,
            width: borderWidth,
          ),
        ),
        child: badgeContent,
      ),
    );
  }
}
