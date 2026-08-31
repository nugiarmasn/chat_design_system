import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<String> _menus = [
    // --- Dev 1: Controls & Inputs ---
    'Controls / Buttons',
    'Controls / Text Fields',
    'Controls / Toggles & Choices',
    // --- Dev 2: Navigation & Bars ---
    'Bars / Nav Bars',
    'Navigation / Bottom & Tabs',
    'Bars / Search Bars',
    // --- Dev 3: Popups & Modals ---
    'Views / Popovers & Dialogs',
    'Views / Snackbars & Bottom Sheets',
    'Popup / Chat Interactions',
    // --- Dev 4: Lists & Data Display ---
    'Lists / Chat & Users',
    'Message Area',
    'Views / Avatars & Badges',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
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
                  child: ListView.builder(
                    itemCount: _menus.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _menus[index],
                          style: TextStyle(
                            fontWeight: _selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedIndex == index
                                ? const Color(0xFF0052CC)
                                : Colors.black87,
                          ),
                        ),
                        selected: _selectedIndex == index,
                        selectedTileColor: Colors.blue.withOpacity(0.1),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Halaman ${_menus[_selectedIndex]} akan dirender di sini.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}