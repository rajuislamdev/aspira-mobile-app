import 'package:aspira/screens/discoussion_thread_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityThreadCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String role;
  final String time;
  final String title;
  final String description;
  final int likes;
  final int comments;
  final bool liked;

  const CommunityThreadCard({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.role,
    required this.time,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
    this.liked = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedScale(
      scale: 1,
      duration: const Duration(milliseconds: 120),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A4B9E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF13B49F).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(avatarUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '$time • $role',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),

            const SizedBox(height: 12),

            /// Title
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            /// Description
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 14,
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 14),

            /// Footer
            Divider(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.grey.shade200,
            ),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscussionThreadScreen(),
                ),
              ),
              child: Row(
                children: [
                  _Reaction(icon: Icons.favorite, count: likes, active: liked),
                  const SizedBox(width: 16),
                  _Reaction(icon: Icons.chat_bubble_outline, count: comments),
                  const Spacer(),
                  Text(
                    'VIEW THREAD →',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: const Color(0xFF13B49F),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Reaction extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool active;

  const _Reaction({
    required this.icon,
    required this.count,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: active ? const Color(0xFF13B49F) : Colors.grey,
        ),
        const SizedBox(width: 4),
        Text('$count', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
