import 'dart:ui';

import 'package:aspira/screens/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => const [
          _CollapsingTopBar(),
          SliverPersistentHeader(pinned: true, delegate: _CategoryHeaderDelegate()),
        ],
        body: const _FeedThreadList(),
      ),
    );
  }
}

/// =============================================================
/// Collapsing Top AppBar with Profile + Greeting
/// =============================================================
class _CollapsingTopBar extends StatelessWidget {
  const _CollapsingTopBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: false,
      floating: false,
      elevation: 0,
      expandedHeight: 92,
      collapsedHeight: 56, // ❌ must NOT be zero
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final progress = (constraints.maxHeight - kToolbarHeight) / (92 - kToolbarHeight);
          final clamped = progress.clamp(0.0, 1.0);

          return Opacity(
            opacity: clamped,
            child: Transform.translate(
              offset: Offset(0, (1 - clamped) * -20),
              child: _TopAppBarContent(),
            ),
          );
        },
      ),
    );
  }
}

/// =============================================================
/// Top AppBar Content (Profile + Greeting + Notification)
/// =============================================================
class _TopAppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            color: const Color(0xFF111214).withOpacity(0.85),
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.06))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile + Greeting
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF14B8A6).withOpacity(0.4), width: 2),
                    ),
                    child: const ClipOval(
                      child: Image(
                        image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MEMBER PRO',
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: const Color(0xFF14B8A6),
                        ),
                      ),
                      Text(
                        'Good morning, Alex',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Notification
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(color: Color(0xFF171A29), shape: BoxShape.circle),
                child: const Icon(Icons.notifications_none, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =============================================================
/// Sticky Category Header
/// =============================================================
class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _CategoryHeaderDelegate();

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFF111214),
      padding: const EdgeInsets.only(top: 0, bottom: 8),
      alignment: Alignment.centerLeft,
      child: const _CategoryChips(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

/// =============================================================
/// Category Chips
/// =============================================================
class _CategoryChips extends StatelessWidget {
  const _CategoryChips();

  static const categories = ['Discover', 'Communication', 'Soft Skills', 'Design', 'Leadership'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) => _ChipItem(label: categories[index], active: index == 0),
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  const _ChipItem({required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF14B8A6) : const Color(0xFF171A29),
        borderRadius: BorderRadius.circular(14),
        boxShadow: active
            ? [BoxShadow(color: const Color(0xFF14B8A6).withOpacity(0.25), blurRadius: 10)]
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          color: active ? const Color(0xFF111214) : Colors.white60,
        ),
      ),
    );
  }
}

/// =============================================================
/// Feed Posts List
/// =============================================================
class _FeedThreadList extends StatelessWidget {
  const _FeedThreadList({super.key});

  static const List<Map<String, dynamic>> posts = [
    {
      'avatarUrl': 'https://i.pravatar.cc/150?img=12',
      'name': 'Sarah J.',
      'role': 'Lead Designer',
      'time': '2h ago',
      'title': 'How do you handle conflict in remote teams?',
      'description':
          'I’ve noticed some tension in Slack lately. Tone is often misinterpreted during code reviews...',
      'likes': 120,
      'comments': 45,
      'liked': true,
    },
    {
      'avatarUrl': 'https://i.pravatar.cc/150?img=32',
      'name': 'Marcus L.',
      'role': 'Engineering Manager',
      'time': '5h ago',
      'title': 'Best books for first-time managers?',
      'description':
          'I just got promoted to Lead and want to start my journey right. Any recommendations?',
      'likes': 85,
      'comments': 32,
      'liked': false,
    },
    {
      'avatarUrl': 'https://i.pravatar.cc/150?img=47',
      'name': 'Elena R.',
      'role': 'Product Director',
      'time': '8h ago',
      'title': 'Transitioning from IC to Manager: hardest part?',
      'description':
          'For those who made the leap, what was the one thing you were not prepared for?',
      'likes': 214,
      'comments': 67,
      'liked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      physics: const BouncingScrollPhysics(),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final post = posts[index];
        return CommunityThreadCard(
          avatarUrl: post['avatarUrl'],
          name: post['name'],
          role: post['role'],
          time: post['time'],
          title: post['title'],
          description: post['description'],
          likes: post['likes'],
          comments: post['comments'],
          liked: post['liked'],
        );
      },
    );
  }
}
