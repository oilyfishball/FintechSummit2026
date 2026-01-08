import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mingle/components/mingle-title.dart';
import 'package:mingle/screens/matches/matches-chat.dart';
import 'package:mingle/styles/colors.dart';

/// =======================
/// Match Preview Model
/// =======================
class MatchPreview {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;

  MatchPreview({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}

/// =======================
/// Matches Page
/// =======================
class MatchesPage extends StatelessWidget {
  MatchesPage({super.key});

  final List<MatchPreview> matches = [
    MatchPreview(
      id: "1",
      name: "Ryan",
      avatarUrl: "https://i.pravatar.cc/150?img=12",
      lastMessage: "That’s actually hilarious 😂",
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      unreadCount: 2,
      isOnline: true,
    ),
    MatchPreview(
      id: "2",
      name: "Ethan",
      avatarUrl: "https://i.pravatar.cc/150?img=3",
      lastMessage: "Okay yeah I’m down",
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isOnline: true,
    ),
    MatchPreview(
      id: "3",
      name: "Daniel",
      avatarUrl: "https://i.pravatar.cc/150?img=8",
      lastMessage: "HAHA fair enough",
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: mingleTitle(size: 30),
      ),
      body: matches.isEmpty
          ? const Center(
              child: Text(
                "No matches yet",
                style: TextStyle(fontSize: 16, color: black),
              ),
            )
          : ListView.separated(
              itemCount: matches.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final match = matches[index];
                return _MatchTile(match: match);
              },
            ),
    );
  }
}

/// =======================
/// Match Tile
/// =======================
class _MatchTile extends StatelessWidget {
  final MatchPreview match;

  const _MatchTile({required this.match});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(match.avatarUrl),
          ),
          if (match.isOnline)
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        match.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        match.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color:
              match.unreadCount > 0 ? Colors.black : Colors.black54,
          fontWeight:
              match.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTime(match.timestamp),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 6),
          if (match.unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                match.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        Get.to(
          () => MatchesChat(
            matchName: match.name,
            matchAvatar: match.avatarUrl,
          ),
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inDays >= 1) {
      return "${time.day}/${time.month}";
    }
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
