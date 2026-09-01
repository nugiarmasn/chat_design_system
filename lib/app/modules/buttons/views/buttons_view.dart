import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buttons_controller.dart';
import '../../../components/custom_button.dart';
import '../../../core/app_theme.dart';

class ButtonsView extends GetView<ButtonsController> {
  const ButtonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text('Buttons', style: AppTextStyles.heading),
          const SizedBox(height: 32),

          Text('Primary', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: [
              CustomButton(label: 'Button', onPressed: () {}),
              CustomButton(label: 'With Icon', icon: Icons.add, onPressed: () {}),
              const CustomButton(label: 'Disabled', onPressed: null),
            ],
          ),
          const Divider(height: 48),

          Text('Secondary', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: [
              CustomButton(label: 'Button', type: ButtonType.secondary, onPressed: () {}),
              CustomButton(label: 'With Icon', type: ButtonType.secondary, icon: Icons.bookmark_border, onPressed: () {}),
              const CustomButton(label: 'Disabled', type: ButtonType.secondary, onPressed: null),
            ],
          ),
          const Divider(height: 48),

          Text('Outline & Text', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: [
              CustomButton(label: 'Outline', type: ButtonType.outline, onPressed: () {}),
              CustomButton(label: 'Text Only', type: ButtonType.text, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
