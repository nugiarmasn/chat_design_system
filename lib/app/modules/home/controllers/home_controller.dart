import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  final menus = [
    'Controls / Buttons',
    'Controls / Text Fields',
    'Controls / Toggles & Choices',
    'Bars / Nav Bars',
    'Navigation / Bottom & Tabs',
    'Bars / Search Bars',
    'Views / Popovers & Dialogs',
    'Views / Snackbars & Bottom Sheets',
    'Popup / Chat Interactions',
    'Lists / Chat & Users',
    'Message Area',
    'Views / Avatars & Badges',
  ];

  void changeMenu(int index) {
    selectedIndex.value = index;
  }
}