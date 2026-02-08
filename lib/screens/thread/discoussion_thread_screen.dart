import 'package:aspira/core/utils/app_constants.dart';
import 'package:aspira/core/utils/exptensions.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/models/thread_model/child.dart';
import 'package:aspira/screens/widgets/loading/comment_card_shimmer.dart';
import 'package:aspira/view_models/post/add_comment_view_model.dart';
import 'package:aspira/view_models/post/fetch_threads_view_model.dart';
import 'package:aspira/view_models/post/react_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscussionThreadScreen extends ConsumerStatefulWidget {
  final PostModel post;
  const DiscussionThreadScreen({super.key, required this.post});

  @override
  ConsumerState<DiscussionThreadScreen> createState() =>
      _DiscussionThreadScreenState();
}

class _DiscussionThreadScreenState
    extends ConsumerState<DiscussionThreadScreen> {
  late final TextEditingController _commentController;
  String? _replyParentId;
  String? _replyParentName;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _refreshThreads() {
    final postId = widget.post.id;
    if (postId == null || postId.isEmpty) return;
    ref
        .read(fetchThreadsViewModelProvider(postId).notifier)
        .fetchThreads(postId: postId);
  }

  void _setReplyTarget({required String? parentId, required String name}) {
    setState(() {
      _replyParentId = parentId;
      _replyParentName = name;
    });
  }

  void _clearReplyTarget() {
    setState(() {
      _replyParentId = null;
      _replyParentName = null;
    });
  }

  String _authorName({String? firstName, String? lastName}) {
    final name = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    return name.isEmpty ? 'Unknown' : name;
  }

  List<Widget> _buildChildComments(List<Child> children, {double indent = 16}) {
    return children.expand((child) {
      final childName = _authorName(
        firstName: child.author?.firstName,
        lastName: child.author?.lastName,
      );
      final widgets = <Widget>[
        Padding(
          padding: EdgeInsets.only(left: indent, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: const Color(0xFF14B8A2).withOpacity(0.35),
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CommentCard(
                avatar: child.author?.profilePicture?.toString(),
                name: childName,
                time: child.createdAt?.postTime ?? 'Just now',
                text: child.content ?? '',
                likes: 0,
                isChild: true,
                onReply: () =>
                    _setReplyTarget(parentId: child.id, name: childName),
              ),
            ),
          ),
        ),
      ];

      final nested = child.children ?? const [];
      if (nested.isNotEmpty) {
        widgets.addAll(_buildChildComments(nested, indent: indent + 16));
      }

      return widgets;
    }).toList();
  }

  Future<void> _handleAddComment({required String? parentId}) async {
    final postId = widget.post.id;
    final message = _commentController.text.trim();
    if (postId == null || postId.isEmpty) return;
    if (message.isEmpty) {
      Ui.showErrorSnackBar(context, message: 'Comment cannot be empty');
      return;
    }
    await ref
        .read(addCommentViewModelProvider.notifier)
        .addComment(postId: postId, comment: message, parentId: parentId);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addCommentViewModelProvider, (_, next) {
      next.whenOrNull(
        data: (message) {
          if (message == null) return;
          _commentController.clear();
          _clearReplyTarget();
          _refreshThreads();
          Ui.showSuccessSnackBar(context, message: message);
        },
        error: (error, _) {
          Ui.showErrorSnackBar(context, message: error.toString());
        },
      );
    });

    final postId = widget.post.id ?? '';
    final threadsState = ref.watch(fetchThreadsViewModelProvider(postId));
    final isSubmitting = ref.watch(addCommentViewModelProvider).isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121416),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Discussion Thread',
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: Colors.grey[400],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAwe3NC7E_R5vwqoFcp3G6M6setwfYMOZ2aNsGSifoBTP_hl5AGODzPOQphnidN9_wlbx9We4mUK6qHIQGTZrP9z8_9_Hrf2jGPEGeUu3B3Iec68iP-uS5JOnNEfbNQgmwK43AWldbIic3ozD8ae-2TNdxZaDye9Yp9fW9lYXV4CX2LylRY6cyHMb9Cf8jyXSKh-YsR2Yf9ffRjGz_tQqx0ZFvz_xlTar0LqykWp5u8blFSNCKUyPGNnbH4XVho_2QXx9jZ9rGC14_l',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color(0xFF14B8A2),
                                border: Border.all(
                                  color: const Color(0xFF121416),
                                  width: 1.5,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.post.author?.firstName} ${widget.post.author?.lastName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Lead Instructor • ${widget.post.createdAt?.postTime}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.post.title ?? '',
                    style: GoogleFonts.manrope(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.post.content ?? '',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final reactPostViewModel = ref.watch(
                            reactPostViewModelProvider,
                          );
                          if (reactPostViewModel.isLoading) {
                            return _PostAction(
                              icon: Icons.favorite,
                              count: widget.post.count?.reactions ?? 0,
                              active: widget.post.hasReacted,
                              onTap: () {},
                            );
                          }
                          return _PostAction(
                            icon: Icons.favorite,
                            count: widget.post.count?.reactions ?? 0,
                            active: widget.post.hasReacted,
                            onTap: () {
                              ref
                                  .read(reactPostViewModelProvider.notifier)
                                  .reactPost(postId: widget.post.id!);
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 24),
                      _PostAction(
                        icon: Icons.chat_bubble_outline,
                        count: widget.post.count?.replies ?? 0,
                      ),
                      const SizedBox(width: 24),
                      _PostAction(icon: Icons.share, count: 0),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  threadsState.when(
                    data: (threads) => Text(
                      'Replies (${threads.length})',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    error: (_, __) => const Text(
                      'Replies',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    loading: () => const Text(
                      'Replies',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Text(
                        'LATEST',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF14B8A2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.expand_more, color: Color(0xFF14B8A2)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppConstants.switchAnimationDuration,
                child: threadsState.when(
                  loading: () => const KeyedSubtree(
                    key: ValueKey('threads-loading'),
                    child: _CommentShimmerList(),
                  ),
                  error: (error, _) => KeyedSubtree(
                    key: const ValueKey('threads-error'),
                    child: Center(
                      child: Text(
                        error.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  data: (threads) {
                    if (threads.isEmpty) {
                      return const KeyedSubtree(
                        key: ValueKey('threads-empty'),
                        child: Center(
                          child: Text(
                            'No replies yet. Be the first to comment.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }
                    return KeyedSubtree(
                      key: const ValueKey('threads-data'),
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: threads.length,
                        itemBuilder: (context, index) {
                          final thread = threads[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommentCard(
                                  avatar: thread.author?.profilePicture
                                      ?.toString(),
                                  name: _authorName(
                                    firstName: thread.author?.firstName,
                                    lastName: thread.author?.lastName,
                                  ),
                                  time:
                                      thread.createdAt?.postTime ?? 'Just now',
                                  text: thread.content ?? '',
                                  likes: thread.count?.reactions ?? 0,
                                  onReply: () => _setReplyTarget(
                                    parentId: thread.id,
                                    name: _authorName(
                                      firstName: thread.author?.firstName,
                                      lastName: thread.author?.lastName,
                                    ),
                                  ),
                                ),
                                if (thread.children != null &&
                                    thread.children!.isNotEmpty)
                                  ..._buildChildComments(
                                    thread.children!,
                                    indent: 20,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
            color: const Color(0xFF121416).withOpacity(0.95),
            border: const Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_replyParentId != null &&
                  _replyParentName != null &&
                  _replyParentName!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1F24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Replying to ${_replyParentName ?? 'this comment'}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _clearReplyTarget,
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: _replyParentId == null
                            ? 'Write a reply...'
                            : 'Write a reply to ${_replyParentName ?? 'this comment'}...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFF1C1F24),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: isSubmitting
                        ? null
                        : () => _handleAddComment(parentId: _replyParentId),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: isSubmitting
                          ? const Color(0xFF14B8A2).withOpacity(0.5)
                          : const Color(0xFF14B8A2),
                      child: isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentShimmerList extends StatelessWidget {
  const _CommentShimmerList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final isChild = index % 3 == 2;
        return isChild
            ? const Padding(
                padding: EdgeInsets.only(left: 20),
                child: CommentCardShimmer(isChild: true),
              )
            : const CommentCardShimmer();
      },
    );
  }
}

/// ================= POST ACTIONS =================
class _PostAction extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool active;
  final Function? onTap;
  const _PostAction({
    required this.icon,
    required this.count,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: active ? const Color(0xFF14B8A2) : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              color: active ? const Color(0xFF14B8A2) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= COMMENT CARD =================
class CommentCard extends StatelessWidget {
  final String? avatar;
  final String name;
  final String time;
  final String text;
  final int likes;
  final VoidCallback? onReply;
  final bool isChild;
  const CommentCard({
    required this.avatar,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
    this.onReply,
    this.isChild = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatar != null && avatar!.trim().isNotEmpty;
    final initials = name.isNotEmpty
        ? name
              .trim()
              .split(RegExp(r'\s+'))
              .take(2)
              .map((part) => part.isEmpty ? '' : part[0])
              .join()
              .toUpperCase()
        : '?';
    return Container(
      padding: EdgeInsets.all(isChild ? 10 : 12),
      decoration: BoxDecoration(
        color: isChild ? const Color(0xFF23272D) : const Color(0xFF272B31),
        borderRadius: BorderRadius.circular(isChild ? 14 : 16),
        border: Border.all(color: const Color(0xFF1C1F24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: isChild ? 14 : 16,
                backgroundColor: const Color(0xFF1C1F24),
                backgroundImage: hasAvatar ? NetworkImage(avatar!) : null,
                child: hasAvatar
                    ? null
                    : Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: isChild ? 9 : 10,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_vert, color: Colors.grey, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: isChild ? 13 : 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up, size: 18, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    likes.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onReply,
                child: const Text(
                  'Reply',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
