import 'package:get/get.dart';

class TogglesController extends GetxController {
  // Variabel reaktif untuk Switch
  final switchValue1 = true.obs;
  final switchValue2 = false.obs;

  // Variabel reaktif untuk Checkbox
  final checkValue1 = true.obs;
  final checkValue2 = false.obs;

  // Variabel reaktif untuk Radio (1 = terpilih pertama)
  final radioValue = 1.obs;
}
