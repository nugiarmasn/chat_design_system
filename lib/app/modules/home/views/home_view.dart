import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../text_fields/views/text_fields_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Deteksi apakah layarnya lebar (Web/Tablet) atau sempit (HP)
    final isDesktop = MediaQuery.of(context).size.width > 600;

    // Kita pisah widget Sidebar-nya biar bisa dipanggil ulang
    final sidebar = Container(
      width: 280,
      color: const Color(0xFFF4F5F7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Component Library',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              final currentIndex = controller.selectedIndex.value;
              return ListView.builder(
                itemCount: controller.menus.length,
                itemBuilder: (context, index) {
                  final isSelected = currentIndex == index;
                  return ListTile(
                    title: Text(
                      controller.menus[index],
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? const Color(0xFF0052CC) : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: Colors.blue.withOpacity(0.1),
                    onTap: () {
                      controller.changeMenu(index);
                      // Kalau di HP, otomatis tutup menu samping setelah diklik
                      if (!isDesktop) Get.back();
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );

    // Area konten kanan
    final content = Obx(() {
      final selectedMenu = controller.menus[controller.selectedIndex.value];

      if (selectedMenu == 'Controls / Text Fields') {
        return const TextFieldsView();
      }

      return Center(
        child: Text(
          'Halaman $selectedMenu belum disambungkan.',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      // Kalau di HP, munculin AppBar buat tombol hamburger menu
      appBar: isDesktop ? null : AppBar(title: const Text('Design System')),
      // Kalau di HP, sidebar jadi Drawer (menu geser)
      drawer: isDesktop ? null : Drawer(child: sidebar),
      // Atur layout berdasarkan ukuran layar
      body: isDesktop
          ? Row(
        children: [
          sidebar,
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: content),
        ],
      )
          : content,
    );
  }
}