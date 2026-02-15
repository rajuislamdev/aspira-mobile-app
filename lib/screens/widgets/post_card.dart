import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/view_models/post/bookmark_post_view_model.dart';
import 'package:aspira/view_models/post/react_post_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final PostModel post;

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
    required this.post,
    this.liked = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedScale(
      scale: 1,
      duration: const Duration(milliseconds: 120),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A4B9E) : Colors.white,
          // borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.shade200),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12).copyWith(top: 8),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF13B49F).withOpacity(0.3), width: 2),
                    ),
                    child: ClipOval(child: Image.network(avatarUrl, fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700),
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
            ),

            const SizedBox(height: 12),

            /// Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(height: 6),

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Image
            /// Modern Image Loader
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1499914485622-a88fac536970?q=80&w=1470",
                fit: BoxFit.cover,

                /// Smooth fade animation
                fadeInDuration: const Duration(milliseconds: 300),

                /// Modern shimmer placeholder
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),

                /// Clean error UI
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.broken_image_outlined, size: 28, color: Colors.grey),
                  ),
                ),
              ),
            ),

            /// Footer
            Divider(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.shade200),

            const SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
              child: GestureDetector(
                onTap: () => context.pushNamed(RouteLocationName.threadDiscussion, extra: post),
                child: Row(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        ref.listen(reactPostViewModelProvider, (_, next) {
                          next.whenOrNull(
                            error: (error, s) {
                              final message = error is Failure
                                  ? error.message
                                  : 'Something went wrong';
                              Ui.showErrorSnackBar(context, message: message);
                            },
                          );
                        });
                        return _Reaction(
                          icon: Icons.favorite,
                          count: likes,
                          active: liked,
                          onTap: () {
                            if (post.id == null) return;
                            ref
                                .read(reactPostViewModelProvider.notifier)
                                .reactPost(postId: post.id ?? '');
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _Reaction(icon: Icons.chat_bubble_outline, count: comments),
                    const SizedBox(width: 16),
                    Consumer(
                      builder: (context, ref, child) {
                        ref.listen(bookmarkPostViewModelProvider, (_, next) {
                          next.whenOrNull(
                            error: (error, s) {
                              final message = error is Failure
                                  ? error.message
                                  : 'Something went wrong';
                              Ui.showErrorSnackBar(context, message: message);
                            },
                          );
                        });
                        return _ActionIcon(
                          icon: Icons.bookmark_border,
                          onTap: () {
                            if (post.id == null) return;
                            ref
                                .read(bookmarkPostViewModelProvider.notifier)
                                .bookmarkPost(postId: post.id ?? '');
                          },
                        );
                      },
                    ),
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
  final Function()? onTap;

  const _Reaction({required this.icon, required this.count, this.active = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: active ? const Color(0xFF13B49F) : Colors.grey),
          const SizedBox(width: 4),
          Text('$count', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 20, color: Colors.grey),
    );
  }
}
