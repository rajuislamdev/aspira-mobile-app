import 'package:aspira/core/utils/app_constants.dart';
import 'package:aspira/core/utils/exptensions.dart';
import 'package:aspira/screens/widgets/loading/cummunity_thread_card_shimmer.dart';
import 'package:aspira/screens/widgets/post_card.dart';
import 'package:aspira/view_models/post/fetch_bookmarked_posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkedPostsScreen extends ConsumerWidget {
  const BookmarkedPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(fetchBookmarkedPostsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111214),
        elevation: 0,
        title: Text(
          'Bookmarked Posts',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: AppConstants.switchAnimationDuration,
        child: viewModel.when(
          loading: () =>
              const BookmarkedPostsShimmerList(key: ValueKey('shimmer')),
          error: (error, _) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.white54),
            ),
          ),
          data: (bookmarks) => RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(fetchBookmarkedPostsViewModelProvider.notifier)
                  .fetchBookmarkedPosts();
            },
            child: bookmarks.isEmpty
                ? ListView(
                    key: const ValueKey('empty'),
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [_EmptyState()],
                  )
                : ListView.separated(
                    key: const ValueKey('bookmarks'),
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: bookmarks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final post = bookmarks[index];
                      return CommunityThreadCard(
                        avatarUrl: 'https://i.pravatar.cc/150?img=47',
                        name:
                            '${post.author?.firstName} ${post.author?.lastName}',
                        role: 'Product Director',
                        time: post.createdAt?.postTime ?? '',
                        title: post.title ?? '',
                        description: post.content ?? '',
                        likes: post.count?.reactions ?? 0,
                        comments: post.count?.replies ?? 0,
                        liked: post.hasReacted,
                        post: post,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 64,
              color: const Color(0xFF14B8A6).withOpacity(0.18),
            ),
            const SizedBox(height: 24),
            Text(
              'No Bookmarks Yet',
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Save posts you want to revisit. Bookmarked threads will show up here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 15,
                color: Colors.white54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkedPostsShimmerList extends StatelessWidget {
  const BookmarkedPostsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) => const CommunityThreadCardShimmer(),
    );
  }
}
