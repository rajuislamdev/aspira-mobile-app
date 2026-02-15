import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommentCardShimmer extends StatelessWidget {
  final bool isChild;
  const CommentCardShimmer({super.key, this.isChild = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF1C1F24) : Colors.grey.shade300;
    final highlightColor = isDark ? const Color(0xFF2F343B) : Colors.grey.shade100;
    final cardColor = isDark
        ? (isChild ? const Color(0xFF23272D) : const Color(0xFF272B31))
        : Colors.white;

    final card = Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: EdgeInsets.all(isChild ? 10 : 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF1C1F24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _circle(size: isChild ? 28 : 32),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: isChild ? 80 : 110, height: 12),
                    const SizedBox(height: 6),
                    _line(width: isChild ? 60 : 80, height: 10),
                  ],
                ),
                const Spacer(),
                _circle(size: 16),
              ],
            ),
            const SizedBox(height: 8),
            _line(width: double.infinity, height: isChild ? 12 : 14),
            const SizedBox(height: 6),
            _line(width: double.infinity, height: isChild ? 12 : 14),
            const SizedBox(height: 8),
            Row(
              children: [
                _reactionPlaceholder(),
                const SizedBox(width: 16),
                _line(width: 36, height: 12),
              ],
            ),
          ],
        ),
      ),
    );

    if (!isChild) return card;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: const Color(0xFF14B8A2).withOpacity(0.35), width: 2),
        ),
      ),
      child: Padding(padding: const EdgeInsets.only(left: 8), child: card),
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
      children: [_circle(size: 18), const SizedBox(width: 6), _line(width: 20, height: 12)],
    );
  }
}
