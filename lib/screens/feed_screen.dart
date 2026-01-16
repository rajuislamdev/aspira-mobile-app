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
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              /// Collapsible header (disappears on scroll)
              const SliverToBoxAdapter(child: _TopAppBar()),

              /// Sticky categories
              SliverPersistentHeader(
                pinned: true,
                delegate: _CategoryHeaderDelegate(),
              ),
            ];
          },
          body: const _FeedThreadList(),
        ),
      ),
    );
  }
}

/// ================= CATEGORY HEADER DELEGATE =================
class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFF111214),
      padding: const EdgeInsets.only(top: 8),
      alignment: Alignment.centerLeft,
      child: const _CategoryChips(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

/// ================= TOP APP BAR =================
class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            color: const Color(0xFF111214).withOpacity(0.8),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.06)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Profile + Greeting
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1E3B8A).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://i.pravatar.cc/150?img=12',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

              /// Notification Button
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF171A29),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= CATEGORY CHIPS =================
class _CategoryChips extends StatelessWidget {
  const _CategoryChips();

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Discover',
      'Communication',
      'Soft Skills',
      'Design',
      'Leadership',
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isActive = index == 0;
          return _ChipItem(label: categories[index], active: isActive);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: categories.length,
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String label;
  final bool active;

  const _ChipItem({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF14B8A6) : const Color(0xFF171A29),
        borderRadius: BorderRadius.circular(14),
        boxShadow: active
            ? [
                BoxShadow(
                  color: const Color(0xFF14B8A6).withOpacity(0.2),
                  blurRadius: 10,
                ),
              ]
            : [],
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

/// ================= POSTS LIST =================
class _FeedThreadList extends StatelessWidget {
  const _FeedThreadList({super.key});

  static final List<Map> posts = [
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
      primary: false, // ❌ Must be false inside NestedScrollView
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
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
