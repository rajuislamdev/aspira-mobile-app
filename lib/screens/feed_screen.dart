import 'dart:ui';

import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/core/utils/app_constants.dart';
import 'package:aspira/core/utils/exptensions.dart';
import 'package:aspira/models/profile_model/interest.dart';
import 'package:aspira/screens/widgets/create_post_model.dart';
import 'package:aspira/screens/widgets/loading/chip_item_shimmer.dart';
import 'package:aspira/screens/widgets/loading/cummunity_thread_card_shimmer.dart';
import 'package:aspira/screens/widgets/loading/top_appbar_shimmer_feed.dart';
import 'package:aspira/screens/widgets/post_card.dart';
import 'package:aspira/view_models/post/fetch_posts_view_model.dart';
import 'package:aspira/view_models/profile/fetch_profile_view_model.dart'
    show fetchProfileViewModelProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      expandedHeight: 82,
      collapsedHeight: 56, // ❌ must NOT be zero
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final progress = (constraints.maxHeight - kToolbarHeight) / (82 - kToolbarHeight);
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
          child: Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(fetchProfileViewModelProvider);
              return AnimatedSwitcher(
                duration: AppConstants.switchAnimationDuration,
                child: viewModel.when(
                  data: (profile) => Row(
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
                              border: Border.all(
                                color: const Color(0xFF14B8A6).withOpacity(0.4),
                                width: 2,
                              ),
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
                                profile?.position ?? 'Update your job title',
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  color: const Color(0xFF14B8A6),
                                ),
                              ),
                              Text(
                                '${DateTime.now().compactGreeting}, ${profile?.firstName ?? 'User'}',
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
                      GestureDetector(
                        onTap: () => context.pushNamed(RouteLocationName.notifications),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF171A29),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(Icons.notifications_none, color: Colors.white),
                              Positioned(
                                top: 8,
                                right: 10,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF14B8A6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  loading: () => TopAppBarShimmer(),
                  error: (error, stackTrace) => const SizedBox.shrink(),
                ),
              );
            },
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
class _CategoryChips extends ConsumerStatefulWidget {
  const _CategoryChips();

  @override
  ConsumerState<_CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends ConsumerState<_CategoryChips> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index, int itemCount) {
    // Estimate chip width + spacing
    const chipWidth = 90.0;
    const spacing = 12.0;
    const padding = 16.0;
    final offset = (chipWidth + spacing) * index - padding;
    final maxScroll = (chipWidth + spacing) * itemCount - chipWidth;
    _scrollController.animateTo(
      offset.clamp(0, maxScroll),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedCategoryIndex);
    final viewModel = ref.watch(fetchProfileViewModelProvider);

    return SizedBox(
      height: 48,
      child: AnimatedSwitcher(
        duration: AppConstants.switchAnimationDuration,
        child: viewModel.when(
          data: (profile) {
            final interests = profile?.interests ?? [];
            final itemCount = interests.length + 1; // +1 for "For you"

            // Scroll to selected chip when it changes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToIndex(selectedIndex, itemCount);
            });

            return ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) {
                final isActive = selectedIndex == index;
                if (index == 0) {
                  return _ChipItem(
                    label: 'For you',
                    active: isActive,
                    onTap: () {
                      if (ref.read(selectedCategoryIndex.notifier).state == 0) return;
                      ref.read(selectedCategoryIndex.notifier).state = 0;
                      ref.read(fetchPostsViewModelProvider.notifier).fetchPosts(interestId: null);
                    },
                  );
                }
                return _ChipItem(
                  label: interests[index - 1].name ?? '',
                  active: isActive,
                  onTap: () {
                    if (ref.read(selectedCategoryIndex.notifier).state == index) return;
                    ref.read(selectedCategoryIndex.notifier).state = index;
                    final interest = interests[index - 1];
                    ref.read(selectedInterestProvider.notifier).state = interest;
                    ref
                        .read(fetchPostsViewModelProvider.notifier)
                        .fetchPosts(interestId: interest.id);
                  },
                );
              },
            );
          },
          loading: () => SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) => const ChipItemShimmer(),
            ),
          ),
          error: (error, stackTrace) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  const _ChipItem({required this.label, this.active = false, this.onTap});

  final String label;
  final bool active;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF14B8A6) : const Color(0xFF171A29),
          borderRadius: BorderRadius.circular(6),
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
      ),
    );
  }
}

/// =============================================================
/// Feed Posts List
/// =============================================================
class _FeedThreadList extends StatelessWidget {
  const _FeedThreadList({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(fetchPostsViewModelProvider);
        final selectedInterest = ref.watch(selectedInterestProvider);
        return AnimatedSwitcher(
          duration: AppConstants.switchAnimationDuration,
          child: viewModel.when(
            data: (posts) => posts.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.forum_outlined,
                            size: 64,
                            color: const Color(0xFF14B8A6).withOpacity(0.18),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'No Threads Yet',
                            style: GoogleFonts.manrope(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Be the first to start a discussion or ask a question. Your post will help others learn and grow!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              color: Colors.white54,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF14B8A6),
                              foregroundColor: const Color(0xFF111214),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 6,
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                            ),
                            onPressed: () {
                              // Open create post modal or navigate to create post screen
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => FractionallySizedBox(
                                  heightFactor: 0.82,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF111317),
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                                    ),
                                    child: const CreatePostModal(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: Text(
                              'Start a Thread',
                              style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      // ref.invalidate(fetchPostsViewModelProvider, asReload: true);
                      ref
                          .read(fetchPostsViewModelProvider.notifier)
                          .fetchPosts(interestId: selectedInterest?.id);
                    },
                    child: ListView.separated(
                      key: const ValueKey('feed-thread-list'),
                      physics: const BouncingScrollPhysics(),
                      itemCount: posts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 1),
                      itemBuilder: (_, index) {
                        final post = posts[index];
                        return CommunityThreadCard(
                          avatarUrl: 'https://i.pravatar.cc/150?img=47',
                          name: '${post.author?.firstName} ${post.author?.lastName}',
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
            error: (error, s) {
              return SizedBox.shrink();
            },
            loading: () => ListView.separated(
              key: const ValueKey('feed-thread-list-loading'),
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(height: 1),
              itemBuilder: (_, index) {
                return CommunityThreadCardShimmer();
              },
            ),
          ),
        );
      },
    );
  }
}

final selectedCategoryIndex = StateProvider<int>((ref) => 0);
final selectedInterestProvider = StateProvider<Interest?>((ref) => null);
