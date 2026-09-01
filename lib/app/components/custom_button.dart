import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    BorderSide bs = BorderSide.none;

    switch (type) {
      case ButtonType.secondary:
        bg = const Color(0xFFE5ECF6); // Biru muda
        fg = AppColors.primary;
        break;
      case ButtonType.outline:
        bg = Colors.transparent;
        fg = AppColors.textPrimary;
        bs = const BorderSide(color: AppColors.border);
        break;
      case ButtonType.text:
        bg = Colors.transparent;
        fg = AppColors.primary;
        break;
      case ButtonType.primary:
      default:
        bg = AppColors.primary;
        fg = Colors.white;
        break;
    }

    final style = ElevatedButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: fg,
      disabledBackgroundColor: const Color(0xFFDFE1E6),
      disabledForegroundColor: AppColors.textSecondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: bs,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
