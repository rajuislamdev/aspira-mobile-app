import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AspiraLoadingView extends StatefulWidget {
  const AspiraLoadingView({super.key});

  @override
  State<AspiraLoadingView> createState() => _AspiraLoadingViewState();
}

class _AspiraLoadingViewState extends State<AspiraLoadingView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Rings
              SizedBox(
                width: 220,
                height: 220,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        _ring(200, 0.2),
                        _ring(160, 0.15),
                        _rotatingRing(120),
                        _coreIcon(),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // App Name Animation
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  final scale = 1 + (_controller.value * 0.04);
                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: 0.7 + (math.sin(_controller.value * math.pi * 2) * 0.3),
                      child: Text(
                        'Aspira',
                        style: GoogleFonts.manrope(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const CircularProgressIndicator(strokeWidth: 3, color: Color(0xFF14B8A6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ring(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF14B8A6).withOpacity(opacity), width: 2),
      ),
    );
  }

  Widget _rotatingRing(double size) {
    return Transform.rotate(
      angle: _controller.value * math.pi * 2,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF1E3B8A).withOpacity(0.4), width: 3),
        ),
      ),
    );
  }

  Widget _coreIcon() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1E3B8A).withOpacity(0.25),
      ),
      child: const Icon(Icons.auto_graph_rounded, size: 34, color: Colors.white70),
    );
  }
}
