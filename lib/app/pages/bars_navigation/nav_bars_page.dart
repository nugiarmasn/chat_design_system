import 'package:flutter/material.dart';

/// Halaman "Bars / Nav Bars: Standard" dan "Bars / Nav Bars: Large".
/// Pure Flutter, TANPA GetX di dalam komponennya.
class NavBarsPage extends StatelessWidget {
  const NavBarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Bars / Nav Bars: Standard'),
          const SizedBox(height: 12),
          const AppNavBarStandard(title: 'Title'),
          const SizedBox(height: 8),
          const AppNavBarStandard(title: 'Title', actionLabel: 'Action'),
          const SizedBox(height: 8),
          const AppNavBarStandard(
            title: 'Title',
            actionLabel: 'Action',
            filledAction: true,
          ),
          const SizedBox(height: 32),
          const _SectionTitle('Bars / Nav Bars: Large'),
          const SizedBox(height: 12),
          const AppNavBarLarge(title: 'Large Title'),
          const SizedBox(height: 8),
          const AppNavBarLarge(title: 'Large Title', actionLabel: 'Button'),
          const SizedBox(height: 8),
          const AppNavBarLarge(
            title: 'Large Title',
            caption: 'Caption',
            actionLabel: 'Button',
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

/// Reusable component: Nav Bar Standard (dengan back icon, title, action).
class AppNavBarStandard extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final bool filledAction;
  final VoidCallback? onBack;
  final VoidCallback? onAction;

  const AppNavBarStandard({
    super.key,
    required this.title,
    this.actionLabel,
    this.filledAction = false,
    this.onBack,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: onBack),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: actionLabel == null ? 48 : 100,
            child: actionLabel == null
                ? const Icon(Icons.settings_outlined)
                : Align(
                    alignment: Alignment.centerRight,
                    child: filledAction
                        ? _FilledActionChip(
                            label: actionLabel!,
                            onTap: onAction,
                          )
                        : TextButton(
                            onPressed: onAction ?? () {},
                            child: Text(actionLabel!),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Reusable component: Nav Bar Large (dengan large title, caption, action).
class AppNavBarLarge extends StatelessWidget {
  final String title;
  final String? caption;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppNavBarLarge({
    super.key,
    required this.title,
    this.caption,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (caption != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      caption!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
          if (actionLabel != null)
            _FilledActionChip(label: actionLabel!, onTap: onAction),
        ],
      ),
    );
  }
}

class _FilledActionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _FilledActionChip({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    // onTap default ke no-op (bukan null), biar ElevatedButton nggak
    // otomatis di-render dengan style "disabled" (abu-abu) oleh Flutter.
    return ElevatedButton(
      onPressed: onTap ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A1750),
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        maxLines: 1,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }
}
