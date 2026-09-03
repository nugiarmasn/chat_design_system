import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_button.dart';
import '../../../core/theme/app_theme.dart';

class PopoversDialogsView extends StatelessWidget {
  const PopoversDialogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      body: Center(
        child: ConstrainedBox(
          // Membatasi lebar maksimal untuk tampilan Web/Desktop agar UI tidak meregang
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Text(
                'Popovers & Dialogs',
                style: AppTypography.heading1.adapt(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Interactive overlays requiring user attention or confirmation.',
                style: AppTypography.bodySecondary.adapt(context),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Pembungkus Card untuk pengelompokan semantik
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
                      title: 'Standard Dialog',
                      description:
                          'Basic confirmation dialog with two actions.',
                      action: CustomButton(
                        label: 'Show',
                        onPressed: () => CustomDialog.show(
                          title: 'Remove Item?',
                          description:
                              'Are you sure you want to remove this item from your cart?',
                          primaryButtonText: 'Sure',
                          onPrimaryPressed: () => Get.back(),
                          secondaryButtonText: 'No, thanks',
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appDivider),
                    _buildShowcaseItem(
                      context: context,
                      title: 'Error Dialog',
                      description:
                          'Alert dialog to inform users about an issue.',
                      action: CustomButton(
                        label: 'Show',
                        type: ButtonType.secondary,
                        onPressed: () => CustomDialog.show(
                          title: 'Opps!\nSomething went wrong',
                          description: 'Please try again later.',
                          primaryButtonText: 'Okay',
                          onPrimaryPressed: () => Get.back(),
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appDivider),
                    _buildShowcaseItem(
                      context: context,
                      title: 'Input Dialog',
                      description:
                          'Dialog containing a text field for user input.',
                      action: CustomButton(
                        label: 'Show',
                        type: ButtonType.secondary,
                        onPressed: () => CustomDialog.show(
                          title: 'What\'s your team name',
                          description:
                              'The team name will be shown for all members.',
                          showTextField: true,
                          textFieldHint: 'Name',
                          primaryButtonText: 'Confirm',
                          onPrimaryPressed: () => Get.back(),
                          secondaryButtonText: 'Cancel',
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appDivider),
                    _buildShowcaseItem(
                      context: context,
                      title: 'Media Header Dialog',
                      description:
                          'Dialog enhanced with an image or custom icon header.',
                      action: CustomButton(
                        label: 'Show',
                        type: ButtonType.outline,
                        onPressed: () => CustomDialog.show(
                          title: 'Introducing Virtual Reality',
                          description: 'Please check out all-new feature',
                          imageUrl:
                              'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=400&auto=format&fit=crop',
                          primaryButtonText: 'Sure',
                          onPrimaryPressed: () => Get.back(),
                          secondaryButtonText: 'No, thanks',
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
