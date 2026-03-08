import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopAppBarShimmer extends StatelessWidget {
  const TopAppBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            color: const Color(0xFF111214).withOpacity(0.85),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.06)),
            ),
          ),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFF2A2D3E),
            highlightColor: const Color(0xFF3A3D4F),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Profile + Text
                Row(
                  children: [
                    /// Avatar
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),

                    /// Text placeholders
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 10,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 16,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Notification icon placeholder
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
