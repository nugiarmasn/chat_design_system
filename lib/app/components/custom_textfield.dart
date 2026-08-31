import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final String? caption;
  final String? errorText;
  final Widget? suffixIcon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.label,
    required this.hintText,
    this.caption,
    this.errorText,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          obscureText: obscureText,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),

            errorText: errorText != null ? '' : null,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
          ),
        ),
        if (errorText != null || caption != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText ?? caption!,
            style: AppTextStyles.body.copyWith(
              fontSize: 12,
              color: errorText != null ? AppColors.error : AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}