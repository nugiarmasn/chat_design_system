import 'package:flutter/material.dart';
import '../../../components/action_sheet.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/custom_button.dart';
import '../../../core/theme/app_theme.dart';

class SnackbarsBottomSheetsView extends StatelessWidget {
  const SnackbarsBottomSheetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Text(
                'Snackbars & Bottom Sheets',
                style: AppTypography.heading1.adapt(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Transient notifications and context-specific bottom menus.',
                style: AppTypography.bodySecondary.adapt(context),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Bagian Bottom Sheets
              Text(
                'Bottom Sheets',
                style: AppTypography.heading2.adapt(context),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.appDivider),
                ),
                child: _buildShowcaseItem(
                  context: context,
                  title: 'Action Sheet Menu',
                  description:
                      'A modal bottom sheet presenting a set of contextual actions.',
                  action: CustomButton(
                    label: 'Trigger',
                    onPressed: () => CustomActionSheet.show(
                      title: 'Select action',
                      options: [
                        'Download',
                        'Save to my favorite',
                        'Comment',
                        'Share',
                        'Report this',
                      ],
                      onOptionSelected: (index) {
                        CustomSnackbar.show(
                          context,
                          message: 'Action ${index + 1} Selected',
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Bagian Snackbars
              Text('Snackbars', style: AppTypography.heading2.adapt(context)),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.appDivider),
                ),
                child: Column(
                  children: [
                    _buildShowcaseItem(
                      context: context,
                      title: 'Standard Snackbar',
                      description: 'Brief, auto-expiring notification.',
                      action: CustomButton(
                        label: 'Show',
                        type: ButtonType.secondary,
                        onPressed: () => CustomSnackbar.show(
                          context,
                          message: 'Item has been removed',
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appDivider),
                    _buildShowcaseItem(
                      context: context,
                      title: 'Caption Snackbar',
                      description:
                          'Snackbar featuring additional descriptive text.',
                      action: CustomButton(
                        label: 'Show',
                        type: ButtonType.secondary,
                        onPressed: () => CustomSnackbar.show(
                          context,
                          message: 'Connection Error',
                          caption: 'Please check your internet and try again.',
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appDivider),
                    _buildShowcaseItem(
                      context: context,
                      title: 'Complex Snackbar',
                      description:
                          'Snackbar with leading icon and action button.',
                      action: CustomButton(
                        label: 'Show',
                        type: ButtonType.outline,
                        onPressed: () => CustomSnackbar.show(
                          context,
                          message: 'File downloaded',
                          caption: 'Size: 2.4 MB',
                          leadingIcon: Icons.check_circle_outline,
                          actionLabel: 'OPEN',
                          onActionPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Private helper method untuk standardisasi baris showcase
  Widget _buildShowcaseItem({
    required BuildContext context,
    required String title,
    required String description,
    required Widget action,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600)
                      .adapt(context),
                ),
                const SizedBox(height: 4),
                Text(description, style: AppTypography.caption.adapt(context)),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          action,
        ],
      ),
    );
  }
}
