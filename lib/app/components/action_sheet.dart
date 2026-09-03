import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_theme.dart';

class CustomActionSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String cancelText;
  final Function(int) onOptionSelected;
  final VoidCallback? onCancel;

  const CustomActionSheet({
    super.key,
    required this.title,
    required this.options,
    required this.onOptionSelected,
    this.cancelText = 'Cancel',
    this.onCancel,
  });

  /// Helper statis untuk memanggil Action Sheet secara global
  static void show({
    required String title,
    required List<String> options,
    required Function(int) onOptionSelected,
  }) {
    Get.bottomSheet(
      CustomActionSheet(
        title: title,
        options: options,
        onOptionSelected: onOptionSelected,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      ignoreSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Drag Handle Indicator
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: context.appDivider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Header Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: AppTypography.heading2.adapt(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Options List
            ...List.generate(options.length, (index) {
              return InkWell(
                onTap: () {
                  Get.back(); // Tutup sheet sebelum mengeksekusi aksi
                  onOptionSelected(index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.radio_button_unchecked,
                        color: context.appTextSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          options[index],
                          style: AppTypography.body.adapt(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            Divider(height: 1, color: context.appDivider),
            // Cancel Button
            InkWell(
              onTap: () {
                Get.back();
                if (onCancel != null) onCancel!();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                alignment: Alignment.center,
                child: Text(
                  cancelText,
                  style: AppTypography.bodyMedium
                      .copyWith(color: context.appTextSecondary)
                      .adapt(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
