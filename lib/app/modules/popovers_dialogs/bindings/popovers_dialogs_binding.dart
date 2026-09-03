import 'package:get/get.dart';
import '../controllers/popovers_dialogs_controller.dart';

class PopoversDialogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopoversDialogsController>(() => PopoversDialogsController());
  }
}
