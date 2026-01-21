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

  final List<Widget> _pages = [
    const FeedScreen(),
    SizedBox.shrink(), // Placeholder for add button
    _ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      // Handle add button tap
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Color(0xFF111317),
        builder: (_) => const SizedBox(height: double.infinity, child: CreatePostModal()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF171A29),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onItemTapped(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: _selectedIndex == 0 ? const Color(0xFF14B8A6) : Colors.white38,
                        size: 28,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Feed',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _selectedIndex == 0 ? const Color(0xFF14B8A6) : Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(width: 56), // Space for FAB
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onItemTapped(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_rounded,
                        color: _selectedIndex == 2 ? const Color(0xFF14B8A6) : Colors.white38,
                        size: 28,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Profile',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _selectedIndex == 2 ? const Color(0xFF14B8A6) : Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 16,
          shadowColor: const Color(0xFF14B8A6),
          shape: BoxShape.circle,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF14B8A6),
            foregroundColor: const Color(0xFF111214),
            elevation: 0, // Remove default FAB shadow
            shape: const CircleBorder(),
            onPressed: () => _onItemTapped(1),
            child: const Icon(Icons.add, size: 32),
          ),
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
