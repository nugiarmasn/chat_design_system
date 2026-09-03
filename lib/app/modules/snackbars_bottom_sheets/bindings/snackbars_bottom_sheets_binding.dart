import 'package:get/get.dart';
import '../controllers/snackbars_bottom_sheets_controller.dart';

class PopoversDialogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SnackbarsBottomSheetsController>(
      () => SnackbarsBottomSheetsController(),
    );
  }
}
