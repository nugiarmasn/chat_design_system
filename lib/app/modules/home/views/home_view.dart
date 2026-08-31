import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../pages/bars_navigation/nav_bars_page.dart';
import '../../../pages/bars_navigation/bottom_and_tabs_page.dart';
import '../../../pages/bars_navigation/search_bars_page.dart';
import '../../text_fields/views/text_fields_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // Breakpoint: di bawah lebar ini, sidebar disembunyikan jadi Drawer.
  static const double _mobileBreakpoint = 700;

  Widget _buildContent(int index, String menuTitle) {
    switch (index) {
      case 1: // Controls / Text Fields
        return const TextFieldsView();
      case 3: // Bars / Nav Bars
        return const NavBarsPage();
      case 4: // Navigation / Bottom & Tabs
        return const BottomAndTabsPage();
      case 5: // Bars / Search Bars
        return const SearchBarsPage();
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Halaman $menuTitle akan dirender di sini.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        );
    }
  }

  Widget _sidebarContent(BuildContext context, {required bool isDrawer}) {
    return Container(
      width: isDrawer ? null : 280,
      color: const Color(0xFFF4F5F7),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      'Component Library',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        controller.isDarkMode.value
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      tooltip: 'Toggle Light/Dark Mode',
                      onPressed: controller.toggleTheme,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final selected = controller.selectedIndex.value;
                return ListView.builder(
                  itemCount: controller.menus.length,
                  itemBuilder: (context, index) {
                    final isSelected = selected == index;
                    return ListTile(
                      title: Text(
                        controller.menus[index],
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF0052CC)
                              : Colors.black87,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: Colors.blue.withOpacity(0.1),
                      onTap: () {
                        controller.changeMenu(index);
                        if (isDrawer) Navigator.of(context).pop(); // tutup drawer
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        final contentArea = Obx(() {
          final index = controller.selectedIndex.value;
          final title = controller.menus[index];
          return _buildContent(index, title);
        });

        if (isMobile) {
          // Layar sempit: sidebar jadi Drawer, ada AppBar dengan tombol menu.
          return Scaffold(
            appBar: AppBar(
              title: Obx(
                () => Text(controller.menus[controller.selectedIndex.value]),
              ),
            ),
            drawer: Drawer(child: _sidebarContent(context, isDrawer: true)),
            body: contentArea,
          );
        }

        // Layar lebar: sidebar permanen di kiri.
        return Scaffold(
          body: Row(
            children: [
              _sidebarContent(context, isDrawer: false),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: contentArea),
            ],
          ),
        );
      },
    );
  }
}