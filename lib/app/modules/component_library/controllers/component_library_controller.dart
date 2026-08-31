import 'package:get/get.dart';

class ComponentLibraryController extends GetxController {
  final RxString selectedMenu = 'Views / Avatars'.obs;
  
  final List<String> menuItems = [
    'Views / Avatars',
    'Lists / Chat & Users',
    'Forms / Message Area',
  ];

  void selectMenu(String menu) {
    selectedMenu.value = menu;
  }
}
