import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/text_fields_controller.dart';
import '../../../components/custom_textfield.dart';
import '../../../core/app_theme.dart';

class TextFieldsView extends GetView<TextFieldsController> {
  const TextFieldsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text('Text Fields', style: AppTextStyles.heading),
          const SizedBox(height: 32),

          const CustomTextField(
            hintText: 'Input text',
          ),
          const SizedBox(height: 24),

          const CustomTextField(
            hintText: 'Password',
            suffixIcon: Icon(Icons.visibility_off, color: AppColors.textSecondary),
            obscureText: true,
          ),
          const SizedBox(height: 24),

          const CustomTextField(
            label: 'Input Label',
            hintText: 'Input text',
            caption: 'Caption description here',
          ),
          const SizedBox(height: 24),

          const CustomTextField(
            label: 'Input Label',
            hintText: 'Input text',
            errorText: 'Error Message',
          ),
        ],
      ),
    );
  }
}