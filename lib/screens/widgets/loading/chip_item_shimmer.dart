import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChipItemShimmer extends StatelessWidget {
  const ChipItemShimmer({super.key, this.width = 80});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF171A29),
      highlightColor: const Color(0xFF1F2937),
      child: Container(
        height: 36,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
