import 'package:aspira/core/utils/exptensions.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscussionThreadScreen extends StatelessWidget {
  final PostModel post;
  const DiscussionThreadScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121416),
      body: SafeArea(
        child: Stack(
          children: [
            /// Main scrollable content
            CustomScrollView(
              slivers: [
                /// Sticky header
                SliverAppBar(
                  backgroundColor: const Color(0xFF121416).withOpacity(0.8),
                  pinned: true,
                  floating: false,
                  expandedHeight: 64,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    title: Text(
                      "Discussion Thread",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Colors.grey[400],
                      ),
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

                /// Original Post
                SliverToBoxAdapter(
                  child: Padding(
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
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuAwe3NC7E_R5vwqoFcp3G6M6setwfYMOZ2aNsGSifoBTP_hl5AGODzPOQphnidN9_wlbx9We4mUK6qHIQGTZrP9z8_9_Hrf2jGPEGeUu3B3Iec68iP-uS5JOnNEfbNQgmwK43AWldbIic3ozD8ae-2TNdxZaDye9Yp9fW9lYXV4CX2LylRY6cyHMb9Cf8jyXSKh-YsR2Yf9ffRjGz_tQqx0ZFvz_xlTar0LqykWp5u8blFSNCKUyPGNnbH4XVho_2QXx9jZ9rGC14_l",
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
                                  "${post.author?.firstName} ${post.author?.lastName}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Lead Instructor • ${post.createdAt?.postTime}",
                                  style: TextStyle(
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
                          "How do you handle conflict in remote teams?",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post.content ?? '',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _PostAction(
                              icon: Icons.favorite,
                              count: post.count?.reactions ?? 0,
                              active: true,
                            ),
                            const SizedBox(width: 24),
                            _PostAction(icon: Icons.chat_bubble_outline, count: 32),
                            const SizedBox(width: 24),
                            _PostAction(icon: Icons.share, count: 12),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                /// Comments Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Replies (32)",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  "LATEST",
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
                        const SizedBox(height: 8),
                        const CommentCard(
                          avatar:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuBhRpmhAnDJKrx5taCHzOwiwsCVgOgRYGzAfec4ik1bc4_KOLPNW7zhIkcVvLngRquf1RRnNkDGRzlY45gvQXIO4ylNG_tImvXvTbOUqbKF1yGRiLInL5jt-xPHv6bbfmiPcYxXYZSyjT5Y7Kg3gOkxzZXIoALMvLmqPZQ8Z561Mv24lzBMzSd5H-89N6blXYqTq1S8-FHMn_fQUDmMi1WtOjt2iAMpEsAyNZC4wkVlNrG6Bcvb1GpQe1ljDotxSxWIkmsfScomOVfA",
                          name: "Marcus Lee",
                          time: "45m ago",
                          text:
                              "I find that video calls resolve 90% of misunderstandings. Text lacks the nuances of tone. If a Slack thread goes over 5 messages without a resolution, it's an automatic Zoom call.",
                          likes: 24,
                        ),
                        const SizedBox(height: 8),
                        const CommentCard(
                          avatar:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuD6C15tbRz-rILlBZ2yQN9e-4e18t4_sFQ1vadzJsrnsnRDZtQpLrnGoORWmdzj1qIYPB_WB1I8SxJRxtegs6fmhPrAbZh9BPm9GvyukEzbIfl6jgQ2KsTA7bq9q1tNL6GGar2_02FHiffgG9MTwdRy1tyyohRvWRDWuCIGQ3SKQDjxI6Axga-z-VjnZPiRn2-UrYmt8ecxweYlUnlwGy1XWAd1L2L7K2PSAZZEP-bLHGt6OhZxHCOFIi5mQYBMBy-htik7xgqL-9RF",
                          name: "David Chen",
                          time: "1h ago",
                          text:
                              "Agreed. We also started \"no-work\" coffee chats on Fridays. Building those social bonds makes it much harder to assume negative intent during the week.",
                          likes: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Bottom input bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF121416).withOpacity(0.95),
                  border: const Border(top: BorderSide(color: Colors.grey, width: 0.3)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Write a reply...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFF1C1F24),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFF14B8A2),
                      child: const Icon(Icons.send, color: Colors.white),
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

/// ================= POST ACTIONS =================
class _PostAction extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool active;
  const _PostAction({required this.icon, required this.count, this.active = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: active ? const Color(0xFF14B8A2) : Colors.grey),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            color: active ? const Color(0xFF14B8A2) : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// ================= COMMENT CARD =================
class CommentCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String time;
  final String text;
  final int likes;
  const CommentCard({
    required this.avatar,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF272B31),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1C1F24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatar)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_vert, color: Colors.grey, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.4)),
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
              Text(
                "Reply",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
