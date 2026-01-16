import 'dart:ui';

import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121416),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildProfileHeader(),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Account Management'),
                        _buildSettingsCard([
                          _buildListItem(
                            icon: Icons.person,
                            title: 'Profile Information',
                            subtitle: 'Name, email, and bio',
                            onTap: () {},
                          ),
                          _buildListItem(
                            icon: Icons.lock,
                            title: 'Password & Security',
                            subtitle: '2FA and login history',
                            onTap: () {},
                          ),
                          _buildListItem(
                            icon: Icons.payments,
                            title: 'Subscription Plan',
                            subtitle: 'Manage billing and renewals',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Preferences'),
                        _buildSettingsCard([
                          _buildToggleItem(
                            icon: Icons.notifications,
                            title: 'Push Notifications',
                            value: pushNotifications,
                            onChanged: (val) => setState(() => pushNotifications = val),
                          ),
                          _buildCustomItem(
                            icon: Icons.dark_mode,
                            title: 'Dark Mode',
                            trailing: const Text(
                              'System Default',
                              style: TextStyle(
                                color: Color(0xFF14B8A6),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Support'),
                        _buildSettingsCard([
                          _buildListItem(
                            icon: Icons.help,
                            title: 'Help Center',
                            trailingIcon: Icons.open_in_new,
                            onTap: () {},
                          ),
                          _buildListItem(
                            icon: Icons.description,
                            title: 'Terms of Service',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _buildLogoutSection(),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            'Version 4.2.0 (Build 942)',
                            style: GoogleFonts.manrope(
                              color: Colors.white24,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Tab Bar
          Align(alignment: Alignment.bottomCenter, child: _buildBottomTabBar()),
        ],
      ),
    );
  }

  /// ===================== Top AppBar =====================
  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF121416),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
          ),
          const Expanded(child: SizedBox()),
          Text(
            'Settings',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  /// ===================== Profile Header =====================
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1e3b8a),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            /// Profile Image
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAhmsfnbjP8bVSVrX2XY5N6oWTsKYxJQA7jTSxPVvCcGJcub1ZZuRmGipU_t_QGbvkoCK7LSmJhKDOUjp-PII0jAlKtpziPGdwfYT_f_p2jwaTT85xqGG5ET5lcyzgYYfc2ouuR0AhYtSz6tATHfh9egizT42lW3Kc6KPHvxCRGSl21Ee9xdqPcxwAOXGFeBLzoWKUPogy9R613aWhUWWUTYc4jwPdphqS7iTJ1Btao41sV6oXmwVQWK8fLf4TSna58iKMK1srrRw',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Julian Sterling',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'j.sterling@learnspace.edu',
                    style: GoogleFonts.manrope(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14b8a6).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF14b8a6).withOpacity(0.3)),
                    ),
                    child: const Text(
                      'Pro Scholar',
                      style: TextStyle(
                        color: Color(0xFF14b8a6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===================== Section Title =====================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.manrope(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  /// ===================== Settings Card =====================
  Widget _buildSettingsCard(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF171a29),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(children: children),
      ),
    );
  }

  /// ===================== Standard List Item =====================
  Widget _buildListItem({
    required IconData icon,
    required String title,
    String? subtitle,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(subtitle != null ? 0.05 : 0)),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF14b8a6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: const Color(0xFF14b8a6)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  if (subtitle != null)
                    Text(subtitle, style: GoogleFonts.manrope(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
            if (trailingIcon != null) Icon(trailingIcon, color: Colors.white24, size: 20),
            if (trailingIcon == null) const Icon(Icons.chevron_right, color: Colors.white24),
          ],
        ),
      ),
    );
  }

  /// ===================== Toggle Item =====================
  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF14b8a6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: const Color(0xFF14b8a6)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(value: value, activeThumbColor: const Color(0xFF14b8a6), onChanged: onChanged),
        ],
      ),
    );
  }

  /// ===================== Custom Item =====================
  Widget _buildCustomItem({required IconData icon, required String title, Widget? trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF14b8a6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: const Color(0xFF14b8a6)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  /// ===================== Logout Section =====================
  Widget _buildLogoutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.withOpacity(0.1),
          foregroundColor: Colors.red,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        icon: const Icon(Icons.logout),
        label: const Text('Logout Account', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          showLogoutDialog(context, () {
            // Your logout logic here
            LocalStorageService().logout();
            context.go('/${RouteLocationName.login}');
          });
        },
      ),
    );
  }

  /// ===================== Bottom Tab Bar =====================
  Widget _buildBottomTabBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF171a29).withOpacity(0.8),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(icon: Icons.school, label: 'Learn', active: false),
          _buildTabItem(icon: Icons.search, label: 'Discover', active: false),
          _buildTabItem(icon: Icons.bookmark, label: 'Library', active: false),
          _buildTabItem(icon: Icons.person, label: 'Settings', active: true),
        ],
      ),
    );
  }

  Widget _buildTabItem({required IconData icon, required String label, required bool active}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? const Color(0xFF14b8a6) : Colors.white38),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            color: active ? const Color(0xFF14b8a6) : Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

void showLogoutDialog(BuildContext context, VoidCallback onLogout) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Glassy backdrop
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF111214).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Icon decoration
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1D23),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.logout, size: 32, color: Colors.redAccent),
                      ),
                      const SizedBox(height: 16),

                      /// Title
                      Text(
                        'Log out of your account?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// Subtitle
                      Text(
                        'You will need to sign back in to access your saved courses, certificates, and interest-based recommendations.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Buttons
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF14B8A6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: onLogout,
                              child: Text(
                                'Log Out',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
