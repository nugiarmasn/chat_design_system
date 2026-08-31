import 'package:get/get.dart';
import '../controllers/component_library_controller.dart';

class ComponentLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComponentLibraryController>(
      () => ComponentLibraryController(),
    );
  }
}
