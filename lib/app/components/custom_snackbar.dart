import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_theme.dart';

class CustomSnackbar {
  // Memory-efficient caching untuk UI Idempotency
  static DateTime? _lastShownTime;
  static String? _lastMessage;

  static void show(
    BuildContext context, {
    required String message,
    String? caption,
    IconData? leadingIcon,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    final now = DateTime.now();

    // 1. Strict Throttling: Menahan spam klik dalam jendela 500ms
    if (_lastShownTime != null &&
        now.difference(_lastShownTime!) < const Duration(milliseconds: 500)) {
      return;
    }

    // 2. State Idempotency: Abaikan jika pesan yang sama persis sedang dirender
    if (Get.isSnackbarOpen && _lastMessage == message) {
      return;
    }

    // 3. Force Dismissal: Bersihkan instance sebelumnya secara instan
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    _lastShownTime = now;
    _lastMessage = message;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF130C88) : const Color(0xFF1A1A1A);
    const textColor = Colors.white;

    // --- POLA GHOST WRAPPER MULAI DI SINI ---
    Get.rawSnackbar(
      // A. Konfigurasi Cangkang Hantu (Menangani Swipe Kiri/Kanan)
      backgroundColor: Colors.transparent, // Transparan penuh
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.zero, // Margin dipindah ke dalam
      padding: EdgeInsets.zero, // Padding dipindah ke dalam
      borderRadius: 0,
      boxShadows: [], // Hapus shadow bawaan GetX
      dismissDirection: DismissDirection.horizontal, // GetX handle kiri & kanan
      snackPosition: SnackPosition.TOP,

      // B. Injeksi Konten Custom (Menangani Swipe Atas + Desain Visual)
      messageText: Dismissible(
        key: UniqueKey(), // Wajib ada untuk Dismissible
        direction: DismissDirection.up, // Hanya merespons gesekan ke atas
        onDismissed: (_) {
          // Ketika UI bergeser ke atas dan menghilang, beri tahu GetX untuk menutup route-nya
          if (Get.isSnackbarOpen) {
            Get.closeAllSnackbars();
          }
        },
        child: Container(
          // Margin dan desain visual diletakkan di dalam sini
          margin: const EdgeInsets.only(
            top: 24, // Jarak dari status bar / notch
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: 8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          // --- Struktur Konten (Teks, Ikon, Tombol) ---
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, color: textColor, size: 20),
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      style: AppTypography.bodyMedium.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (caption != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        caption,
                        style: AppTypography.caption.copyWith(
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actionLabel != null && onActionPressed != null) ...[
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: () {
                    Get.back();
                    onActionPressed();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    actionLabel,
                    style: AppTypography.bodyMedium.copyWith(
                      color: isDark ? Colors.white : AppColors.primaryBlueLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),

      // Matikan parameter title dan icon bawaan karena sudah ditangani di dalam messageText
      titleText: const SizedBox.shrink(),
      icon: const SizedBox.shrink(),
      mainButton: const SizedBox.shrink(),

      animationDuration: const Duration(milliseconds: 250),
      duration: const Duration(seconds: 4),
    );
  }
}
