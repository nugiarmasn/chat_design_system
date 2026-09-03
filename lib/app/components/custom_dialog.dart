import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_theme.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;
  final String? imageUrl;
  final Widget? topIcon;
  final bool showTextField;
  final String? textFieldHint;
  final TextEditingController? textController;

  const CustomDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.imageUrl,
    this.topIcon,
    this.showTextField = false,
    this.textFieldHint,
    this.textController,
  });

  /// Helper statis untuk memanggil dialog secara global melalui GetX
  static void show({
    required String title,
    required String description,
    required String primaryButtonText,
    required VoidCallback onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
    String? imageUrl,
    Widget? topIcon,
    bool showTextField = false,
    String? textFieldHint,
    TextEditingController? textController,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: CustomDialog(
          title: title,
          description: description,
          primaryButtonText: primaryButtonText,
          onPrimaryPressed: onPrimaryPressed,
          secondaryButtonText: secondaryButtonText,
          onSecondaryPressed: onSecondaryPressed,
          imageUrl: imageUrl,
          topIcon: topIcon,
          showTextField: showTextField,
          textFieldHint: textFieldHint,
          textController: textController,
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 340),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      // Mencegah bottom overflow saat keyboard muncul pada input dialog
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderMedia(context),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTypography.heading2.adapt(context),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySecondary.adapt(context),
                  ),
                  if (showTextField) ...[
                    const SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      hintText: textFieldHint ?? 'Input text',
                      // Menggunakan internal controller jika tidak disediakan dari luar
                      // Di production nyata, Anda mem-passing controller dari View/Controller
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      label: primaryButtonText,
                      onPressed: onPrimaryPressed,
                    ),
                  ),
                  if (secondaryButtonText != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        label: secondaryButtonText!,
                        type: ButtonType.text,
                        onPressed: onSecondaryPressed ?? () => Get.back(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Menangani varian Header: Full Image, Small Icon, atau Kosong
  Widget _buildHeaderMedia(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Image.network(
          imageUrl!,
          height: 140,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            height: 140,
            color: context.appDivider,
            child: const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      );
    } else if (topIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSpacing.lg),
        child: topIcon!,
      );
    }
    return const SizedBox.shrink();
  }
}
