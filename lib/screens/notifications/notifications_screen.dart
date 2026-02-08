import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = _demoSections();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111214),
        elevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final section = sections[index];
          return _Section(title: section.title, items: section.items);
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_NotificationItem> items;

  const _Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.manrope(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _NotificationCard(item: item),
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final _NotificationItem item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF171A29),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF14B8A6).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: const Color(0xFF14B8A6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.message,
                  style: GoogleFonts.manrope(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (item.isUnread)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF14B8A6).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF14B8A6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    if (item.isUnread) const SizedBox(width: 8),
                    Text(
                      item.time,
                      style: GoogleFonts.manrope(
                        color: Colors.white38,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationSection {
  final String title;
  final List<_NotificationItem> items;

  const _NotificationSection({required this.title, required this.items});
}

class _NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final bool isUnread;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.isUnread,
  });
}

List<_NotificationSection> _demoSections() {
  return const [
    _NotificationSection(
      title: 'Today',
      items: [
        _NotificationItem(
          title: 'New reply on your thread',
          message: 'Marcus Lee replied to your post about focus rituals.',
          time: '5 min ago',
          icon: Icons.chat_bubble_outline,
          isUnread: true,
        ),
        _NotificationItem(
          title: 'Post bookmarked',
          message: 'You saved “Leading Remote Teams” to your library.',
          time: '32 min ago',
          icon: Icons.bookmark_border,
          isUnread: false,
        ),
        _NotificationItem(
          title: 'Weekly summary ready',
          message: 'You received 12 reactions and 4 replies this week.',
          time: '1 hr ago',
          icon: Icons.insights,
          isUnread: true,
        ),
      ],
    ),
    _NotificationSection(
      title: 'Yesterday',
      items: [
        _NotificationItem(
          title: 'New follower',
          message: 'David Chen started following your updates.',
          time: 'Yesterday • 4:18 PM',
          icon: Icons.person_add_alt,
          isUnread: false,
        ),
        _NotificationItem(
          title: 'Thread recommendation',
          message: '“Designing Career Ladders” was added to your feed.',
          time: 'Yesterday • 2:07 PM',
          icon: Icons.recommend,
          isUnread: false,
        ),
      ],
    ),
    _NotificationSection(
      title: 'Earlier',
      items: [
        _NotificationItem(
          title: 'Milestone unlocked',
          message: 'You reached 1,000 profile views. Keep it up!',
          time: 'Jan 28 • 9:42 AM',
          icon: Icons.emoji_events,
          isUnread: false,
        ),
      ],
    ),
  ];
}
