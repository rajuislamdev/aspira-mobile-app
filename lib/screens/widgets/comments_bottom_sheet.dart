import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/utils/exptensions.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/models/thread_model/child.dart';
import 'package:aspira/screens/widgets/loading/comment_card_shimmer.dart';
import 'package:aspira/view_models/post/add_comment_view_model.dart';
import 'package:aspira/view_models/post/fetch_threads_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsBottomSheet extends ConsumerStatefulWidget {
  final PostModel post;

  const CommentsBottomSheet({super.key, required this.post});

  @override
  ConsumerState<CommentsBottomSheet> createState() =>
      _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends ConsumerState<CommentsBottomSheet> {
  late final TextEditingController _commentController;
  String? _replyParentId;
  String? _replyParentName;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _scrollController = ScrollController();
    _refreshThreads();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
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
          padding: EdgeInsets.only(left: indent, bottom: 0),
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
              child: _CommentCard(
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
          final errorMessage = error is Failure
              ? error.message
              : 'Something went wrong';
          Ui.showErrorSnackBar(context, message: errorMessage);
        },
      );
    });

    final postId = widget.post.id ?? '';
    final threadsState = ref.watch(fetchThreadsViewModelProvider(postId));
    final isSubmitting = ref.watch(addCommentViewModelProvider).isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          /// Handle Bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          /// Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Comments',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: isDark ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.grey.shade200,
          ),

          /// Comments List
          Expanded(
            child: threadsState.when(
              data: (threads) => threads.isEmpty
                  ? _buildEmptyState(isDark)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: threads.length,
                      itemBuilder: (context, index) {
                        final thread = threads[index];
                        final authorName = _authorName(
                          firstName: thread.author?.firstName,
                          lastName: thread.author?.lastName,
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _CommentCard(
                              avatar: thread.author?.profilePicture?.toString(),
                              name: authorName,
                              time: thread.createdAt?.postTime ?? 'Just now',
                              text: thread.content ?? '',
                              likes: thread.count?.reactions ?? 0,
                              isChild: false,
                              onReply: () => _setReplyTarget(
                                parentId: thread.id,
                                name: authorName,
                              ),
                            ),
                            if (thread.children != null &&
                                thread.children!.isNotEmpty)
                              ..._buildChildComments(thread.children!),
                            if (index < threads.length - 1)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Divider(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.06)
                                      : Colors.grey.shade200,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
              loading: () => ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CommentCardShimmer(),
                ),
              ),
              error: (error, _) => _buildErrorState(isDark, error),
            ),
          ),

          Divider(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.grey.shade200,
            height: 0,
          ),

          /// Comment Input
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              12,
              16,
              MediaQuery.of(context).viewInsets.bottom + 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_replyParentName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF14B8A2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_made,
                            size: 16,
                            color: const Color(0xFF14B8A2),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Replying to $_replyParentName',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                color: const Color(0xFF14B8A2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _clearReplyTarget,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: const Color(0xFF14B8A2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          maxLines: null,
                          minLines: 1,
                          enabled: !isSubmitting,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            hintStyle: GoogleFonts.manrope(
                              fontSize: 14,
                              color: isDark
                                  ? Colors.white38
                                  : Colors.grey.shade400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF14B8A2),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF14B8A2),
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: isSubmitting
                                ? null
                                : () => _handleAddComment(
                                    parentId: _replyParentId,
                                  ),
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: isSubmitting
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              isDark
                                                  ? Colors.black87
                                                  : Colors.white,
                                            ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.send,
                                      color: isDark
                                          ? Colors.black87
                                          : Colors.white,
                                      size: 20,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 48,
            color: isDark ? Colors.white24 : Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No comments yet',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to comment',
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: isDark ? Colors.white54 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(bool isDark, dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: isDark ? Colors.white24 : Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load comments',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: isDark ? Colors.white54 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final String? avatar;
  final String name;
  final String time;
  final String text;
  final int likes;
  final bool isChild;
  final VoidCallback? onReply;

  const _CommentCard({
    this.avatar,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
    required this.isChild,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: avatar != null
                ? NetworkImage(avatar!)
                : const AssetImage('assets/placeholder.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        text,
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          color: isDark ? Colors.white70 : Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      time,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (likes > 0)
                      Text(
                        '$likes likes',
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          color: isDark ? Colors.white54 : Colors.grey.shade600,
                        ),
                      ),
                    if (onReply != null) ...[
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: onReply,
                        child: Text(
                          'Reply',
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF14B8A2),
                          ),
                        ),
                      ),
                    ],
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
