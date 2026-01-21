import 'dart:ui';

import 'package:aspira/screens/profile/profile_screen.dart';
import 'package:aspira/screens/widgets/create_post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'feed_screen.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key});

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  int _selectedIndex = 0;

  // Pages
  final List<Widget> _pages = const [
    FeedScreen(key: ValueKey(0)),
    SizedBox.shrink(), // Placeholder for FAB
    ProfileScreen(key: ValueKey(1)),
  ];

  // Navigation handler
  void _onItemTapped(int index) {
    if (index == 1) {
      _openCreatePostModal();
      return;
    }

    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
    }
  }

  // Create post modal
  void _openCreatePostModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF111317),
      builder: (_) =>
          const SizedBox(height: double.infinity, child: CreatePostModal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content under BottomAppBar
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(
        bottom: false,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: _GlassBottomBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _CreatePostFab(onPressed: () => _onItemTapped(1)),
    );
  }
}

/// ------------------------------------------------------------
/// Glass Bottom Navigation Bar
/// ------------------------------------------------------------
class _GlassBottomBar extends StatelessWidget {
  const _GlassBottomBar({required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: BottomAppBar(
          elevation: 0,
          color: Color(0xFF111214).withValues(alpha: 0.1),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            children: [
              _NavItem(
                label: 'Feed',
                icon: Icons.home_rounded,
                isActive: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              const SizedBox(width: 56), // FAB space
              _NavItem(
                label: 'Profile',
                icon: Icons.person_rounded,
                isActive: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Bottom Navigation Item
/// ------------------------------------------------------------
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF14B8A6);
    final inactiveColor = Colors.white54;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: isActive ? activeColor : inactiveColor),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Floating Action Button (Create Post)
/// ------------------------------------------------------------
class _CreatePostFab extends StatelessWidget {
  const _CreatePostFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 16,
        shadowColor: const Color(0xFF14B8A6).withOpacity(0.4),
        shape: BoxShape.circle,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: const Color(0xFF14B8A6),
          foregroundColor: const Color(0xFF111214),
          shape: const CircleBorder(),
          onPressed: onPressed,
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }
}
