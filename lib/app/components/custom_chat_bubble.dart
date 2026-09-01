import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSender;
  final bool isRead;
  final bool showAvatar;
  final String? avatarUrl;

  const CustomChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isSender,
    this.isRead = false,
    this.showAvatar = false,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSender && showAvatar) ...[
            CircleAvatar(
              radius: 14,
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              backgroundColor: theme.outline,
            ),
            const SizedBox(width: 8),
          ] else if (!isSender && !showAvatar) ...[
            const SizedBox(width: 36),
          ],

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSender ? theme.primary : theme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isSender ? 16 : 4),
                  bottomRight: Radius.circular(isSender ? 4 : 16),
                ),
                border: isSender ? null : Border.all(color: theme.outline),
              ),
              child: Column(
                crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: isSender ? Colors.white : theme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: isSender ? Colors.white70 : theme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                      if (isSender) ...[
                        const SizedBox(width: 4),
                        Icon(
                          isRead ? Icons.done_all : Icons.check,
                          size: 14,
                          color: isRead ? Colors.blue[300] : Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (isSender) const SizedBox(width: 36),
        ],
      ),
    );
  }
}