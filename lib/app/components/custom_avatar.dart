import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Enum untuk ukuran Avatar (Presisi sesuai Figma)
enum AvatarSize {
  xs,   // 20px
  sm,   // 24px
  md,   // 32px
  lg,   // 40px
  xl,   // 48px
  xxl,  // 60px
  xxxl, // 80px
}

/// Extension untuk mendapatkan ukuran pixel spesifik Figma
extension AvatarSizeExtension on AvatarSize {
  double get value {
    switch (this) {
      case AvatarSize.xs: return 20.0;
      case AvatarSize.sm: return 24.0;
      case AvatarSize.md: return 32.0;
      case AvatarSize.lg: return 40.0;
      case AvatarSize.xl: return 48.0;
      case AvatarSize.xxl: return 60.0;
      case AvatarSize.xxxl: return 80.0;
    }
  }

  double get badgeSize {
    // Rasio badge sekitar 28% dari avatar, batas minimal 8px agar tidak hilang
    return (value * 0.28).clamp(8.0, 24.0);
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

/// Komponen CustomAvatar yang reusable dan presisi Figma
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
          if (badgeType != AvatarBadgeType.none) _buildBadge(context),
        ],
      ),
    );
  }

  /// Membuat bentuk dasar avatar beserta kontennya
  Widget _buildBaseAvatar() {
    Widget content;

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

    // Menentukan bentuk (shape) dengan proporsi lekukan Figma
    switch (shape) {
      case AvatarShape.circle:
        return ClipOval(child: content);
      case AvatarShape.rounded:
        return ClipRRect(
          borderRadius: BorderRadius.circular(size.value * 0.25), // Squircle mulus ala iOS
          child: content,
        );
      case AvatarShape.square:
        return ClipRRect(
          borderRadius: BorderRadius.circular(size.value * 0.08), // Tumpul elegan
          child: content,
        );
    }
  }

  /// Konten fallback jika gambar tidak tersedia
  Widget _buildFallbackContent() {
    // Warna ungu spesifik Figma
    const Color figmaSoftPurple = Color(0xFFA5A6F6);

    return Container(
      width: size.value,
      height: size.value,
      color: figmaSoftPurple,
      alignment: Alignment.center,
      child: initials != null && initials!.isNotEmpty
          ? Text(
        initials!,
        style: TextStyle(
          fontFamily: AppTypography.fontFamily,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: size.fontSize,
          height: 1.0, // Center vertikal presisi
        ),
      )
          : Icon(
        defaultIcon ?? Icons.person,
        color: Colors.white,
        size: size.value * 0.6,
      ),
    );
  }

  /// Membuat badge di pojok kanan bawah
  Widget _buildBadge(BuildContext context) {
    final badgeDiameter = size.badgeSize;
    // Ketebalan border dibatasi minimal 1.5px
    final borderWidth = (badgeDiameter * 0.15).clamp(1.5, 3.0);

    Widget badgeContent = const SizedBox();
    Color badgeColor = Colors.transparent;

    // Warna status dari Figma
    switch (badgeType) {
      case AvatarBadgeType.online:
        badgeColor = const Color(0xFF34C759); // Figma Green
        break;
      case AvatarBadgeType.offline:
        badgeColor = const Color(0xFFB0B0B0); // Figma Grey
        break;
      case AvatarBadgeType.notification:
        badgeColor = const Color(0xFFFF3B30); // Figma Red
        badgeContent = Center(
          child: Text(
            notificationCount > 9 ? '9+' : notificationCount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: badgeDiameter * 0.55,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
        );
        break;
      case AvatarBadgeType.none:
        break;
    }

    double offsetBottom;
    double offsetRight;

    if (shape == AvatarShape.circle) {
      // Jika lingkaran, badge masuk ke dalam kurva
      offsetBottom = size.value * 0.02;
      offsetRight = size.value * 0.02;
    } else {
      // Jika kotak, badge sedikit menonjol keluar sudut
      offsetBottom = -badgeDiameter * 0.15;
      offsetRight = -badgeDiameter * 0.15;
    }

    return Positioned(
      bottom: offsetBottom,
      right: offsetRight,
      child: Container(
        width: badgeDiameter,
        height: badgeDiameter,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white, // Border putih pelindung badge
            width: borderWidth,
          ),
        ),
        child: badgeContent,
      ),
    );
  }
}