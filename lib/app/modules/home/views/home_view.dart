import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // KIRI: Sidebar
          Container(
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
                  child: Obx(() => ListView.builder(
                    itemCount: controller.menus.length,
                    itemBuilder: (context, index) {
                      final isSelected = controller.selectedIndex.value == index;
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
                        onTap: () => controller.changeMenu(index),
                      );
                    },
                  )),
                ),
              ],
            ),
          ),

          const VerticalDivider(thickness: 1, width: 1),

          // KANAN: Area Konten
          Expanded(
            child: Obx(() => Center(
              child: Text(
                'Halaman ${controller.menus[controller.selectedIndex.value]} akan dirender di sini.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )),
          ),
        ],
      ),
    );
  }
}