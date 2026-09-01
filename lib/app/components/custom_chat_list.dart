import 'package:flutter/material.dart';

enum ChatListType { chat, attachment, call, contact, groupHeader }

class CustomChatList extends StatelessWidget {
  final ChatListType type;
  final String name;
  final String? time;
  final String? subtitle;
  final String? avatarUrl;
  final IconData? attachmentIcon;
  final int unreadCount;
  final bool isMissedCall;
  final String? headerText;

  const CustomChatList({
    super.key,
    this.type = ChatListType.chat,
    required this.name,
    this.time,
    this.subtitle,
    this.avatarUrl,
    this.attachmentIcon,
    this.unreadCount = 0,
    this.isMissedCall = false,
    this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    // Jika ini adalah Header Abjad (A, B, C)
    if (type == ChatListType.groupHeader) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Text(
          headerText ?? '',
          style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: theme.outline,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null ? Icon(Icons.person, color: theme.onSurface) : null,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.w600,
                color: isMissedCall ? Colors.red : theme.onSurface,
              ),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ),
          if (time != null)
            Text(
              time!,
              style: TextStyle(fontSize: 12, color: theme.onSurfaceVariant),
            ),
        ],
      ),
      subtitle: _buildSubtitle(theme),
      trailing: _buildTrailing(theme),
    );
  }

  Widget _buildSubtitle(ColorScheme theme) {
    if (type == ChatListType.call) {
      return Row(
        children: [
          Icon(isMissedCall ? Icons.call_missed : Icons.call_made,
              size: 16, color: isMissedCall ? Colors.red : Colors.green),
          const SizedBox(width: 4),
          Text(subtitle ?? 'Call', style: TextStyle(color: theme.onSurfaceVariant)),
        ],
      );
    }

    if (type == ChatListType.attachment && attachmentIcon != null) {
      return Row(
        children: [
          Icon(attachmentIcon, size: 16, color: theme.onSurfaceVariant),
          const SizedBox(width: 4),
          Expanded(child: Text(subtitle ?? '', style: TextStyle(color: theme.onSurfaceVariant))),
        ],
      );
    }

    return Text(
      subtitle ?? '',
      style: TextStyle(
        color: unreadCount > 0 ? theme.onSurface : theme.onSurfaceVariant,
        fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
      ),
      maxLines: 1, overflow: TextOverflow.ellipsis,
    );
  }

  Widget? _buildTrailing(ColorScheme theme) {
    if (type == ChatListType.call) {
      return Icon(Icons.call, color: theme.onSurfaceVariant);
    }
    if (unreadCount > 0) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: theme.primary, shape: BoxShape.circle),
        child: Text(
          unreadCount.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      );
    }
    return null;
  }
}