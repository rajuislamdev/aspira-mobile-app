import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommunityThreadCardShimmer extends StatelessWidget {
  const CommunityThreadCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A4B9E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.shade200),
      ),
      child: Shimmer.fromColors(
        baseColor: isDark ? const Color(0xFF3A4F8F) : Colors.grey.shade300,
        highlightColor: isDark ? const Color(0xFF4A5F9F) : Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= HEADER =================
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: 100, height: 14),
                    const SizedBox(height: 6),
                    _line(width: 140, height: 12),
                  ],
                ),
                const Spacer(),
                _circle(size: 20),
              ],
            ),

            const SizedBox(height: 14),

            /// ================= TITLE =================
            _line(width: double.infinity, height: 16),
            const SizedBox(height: 6),
            _line(width: MediaQuery.of(context).size.width * 0.6, height: 16),

            const SizedBox(height: 10),

            /// ================= DESCRIPTION =================
            _line(width: double.infinity, height: 14),
            const SizedBox(height: 6),
            _line(width: MediaQuery.of(context).size.width * 0.8, height: 14),

            const SizedBox(height: 16),

            Divider(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.shade200),

            const SizedBox(height: 10),

            /// ================= FOOTER =================
            Row(
              children: [
                _reactionPlaceholder(),
                const SizedBox(width: 16),
                _reactionPlaceholder(),
                const Spacer(),
                _line(width: 90, height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _line({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
    );
  }

  Widget _circle({double size = 24}) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    );
  }

  Widget _reactionPlaceholder() {
    return Row(
      children: [_circle(size: 20), const SizedBox(width: 6), _line(width: 20, height: 12)],
    );
  }
}
