import 'package:flutter/material.dart';

/// Halaman "Bars / Search Bars".
/// Pure Flutter, TANPA GetX di dalam komponennya.
class SearchBarsPage extends StatelessWidget {
  const SearchBarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bars / Search Bars',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const AppSearchBar(hintText: 'Search', showMic: true),
          const SizedBox(height: 12),
          const AppSearchBar(hintText: 'Search', showCancel: true),
          const SizedBox(height: 12),
          const AppSearchBar(
            hintText: 'Search',
            initialText: 'Colorado',
            showCancel: true,
            showClear: true,
          ),
        ],
      ),
    );
  }
}

/// Reusable component: Search Bar. State teks di-handle lewat controller
/// yang dioper dari luar (atau dibuat internal kalau dipakai standalone),
/// tanpa dependency ke GetX sama sekali.
class AppSearchBar extends StatefulWidget {
  final String hintText;
  final String? initialText;
  final bool showMic;
  final bool showCancel;
  final bool showClear;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCancel;

  const AppSearchBar({
    super.key,
    this.hintText = 'Search',
    this.initialText,
    this.showMic = false,
    this.showCancel = false,
    this.showClear = false,
    this.onChanged,
    this.onCancel,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (widget.showClear)
                  InkWell(
                    onTap: () => setState(() => _controller.clear()),
                    child: const Icon(Icons.close, size: 18, color: Colors.grey),
                  )
                else if (widget.showMic)
                  const Icon(Icons.mic_none, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (widget.showCancel) ...[
          const SizedBox(width: 8),
          TextButton(
            onPressed: widget.onCancel,
            child: const Text('Cancel'),
          ),
        ],
      ],
    );
  }
}