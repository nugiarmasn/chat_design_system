import 'package:flutter/material.dart';

/// Halaman "Navigation / Bottom & Tabs".
/// Pure Flutter, TANPA GetX di dalam komponennya.
class BottomAndTabsPage extends StatelessWidget {
  const BottomAndTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Navigation / Bottom Tab Bar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          AppBottomTabBar(
            items: const [
              AppBottomTabItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              AppBottomTabItem(
                icon: Icons.search,
                activeIcon: Icons.search,
                label: 'Search',
              ),
              AppBottomTabItem(
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: 'Saved',
              ),
              AppBottomTabItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
            currentIndex: 0,
            onTap: (_) {},
          ),
          const SizedBox(height: 32),
          const Text(
            'Bars / Tab Bars: Icon & Text',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          AppSegmentedTabBar(
            labels: const ['Title', 'Title'],
            selectedIndex: 0,
            onChanged: (_) {},
          ),
          const SizedBox(height: 8),
          AppSegmentedTabBar(
            labels: const ['Title', 'Title', 'Title'],
            selectedIndex: 1,
            onChanged: (_) {},
          ),
          const SizedBox(height: 8),
          AppSegmentedTabBar(
            labels: const ['Title', 'Title', 'Title', 'Title'],
            selectedIndex: 2,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

/// Data model 1 item bottom tab -- murni data, bukan widget stateful.
class AppBottomTabItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const AppBottomTabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// Reusable component: Bottom Tab Bar (Home/Search/Saved/Profile style).
/// State (currentIndex) dioper dari luar -- widget ini stateless murni.
class AppBottomTabBar extends StatelessWidget {
  final List<AppBottomTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = index == currentIndex;
          final color = isActive ? const Color(0xFF1A1750) : Colors.grey;
          return InkWell(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isActive ? item.activeIcon : item.icon, color: color),
                const SizedBox(height: 4),
                Text(item.label, style: TextStyle(color: color, fontSize: 12)),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// Reusable component: Segmented Tab Bar (garis bawah untuk tab aktif).
class AppSegmentedTabBar extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AppSegmentedTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isActive = index == selectedIndex;
          final color = isActive ? const Color(0xFF3D31E0) : Colors.grey;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle_outlined, size: 16, color: color),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(color: color, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
