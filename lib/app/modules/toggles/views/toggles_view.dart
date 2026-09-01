import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/toggles_controller.dart';
import '../../../core/app_theme.dart';

class TogglesView extends GetView<TogglesController> {
  const TogglesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller secara manual karena kita memanggilnya dari Sidebar
    Get.put(TogglesController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text('Toggles & Choices', style: AppTextStyles.heading),
          const SizedBox(height: 32),

          // 1. SWITCHES
          Text('Switches', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Obx(() => Row(
                children: [
                  Switch(
                    value: controller.switchValue1.value,
                    activeColor: AppColors.primary,
                    onChanged: (val) => controller.switchValue1.value = val,
                  ),
                  const SizedBox(width: 24),
                  Switch(
                    value: controller.switchValue2.value,
                    activeColor: AppColors.primary,
                    onChanged: (val) => controller.switchValue2.value = val,
                  ),
                ],
              )),
          const Divider(height: 48),

          // 2. CHECKBOXES
          Text('Checkboxes', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Obx(() => Row(
                children: [
                  Checkbox(
                    value: controller.checkValue1.value,
                    activeColor: AppColors.primary,
                    onChanged: (val) => controller.checkValue1.value = val ?? false,
                  ),
                  Text('Option 1', style: AppTextStyles.body),
                  const SizedBox(width: 32),
                  Checkbox(
                    value: controller.checkValue2.value,
                    activeColor: AppColors.primary,
                    onChanged: (val) => controller.checkValue2.value = val ?? false,
                  ),
                  Text('Option 2', style: AppTextStyles.body),
                ],
              )),
          const Divider(height: 48),

          // 3. RADIO BUTTONS
          Text('Radio Buttons', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Obx(() => Row(
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: controller.radioValue.value,
                    activeColor: AppColors.primary,
                    onChanged: (val) => controller.radioValue.value = val!,
                  ),
                  Text('Choice 1', style: AppTextStyles.body),
                  const SizedBox(width: 32),
                  Radio<int>(
                    value: 2,
                    groupValue: controller.radioValue.value,
                    activeColor: AppColors.primary,
                    onChanged: (val) => controller.radioValue.value = val!,
                  ),
                  Text('Choice 2', style: AppTextStyles.body),
                ],
              )),
        ],
      ),
    );
  }
}
