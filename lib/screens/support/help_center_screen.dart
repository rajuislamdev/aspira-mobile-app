import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111214),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Help Center',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= SEARCH =================
                  TextField(
                    style: GoogleFonts.manrope(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search for help',
                      hintStyle: GoogleFonts.manrope(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF171A29),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// ================= CATEGORIES =================
                  Text(
                    'Popular Topics',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _HelpTile(
                    icon: Icons.person_outline,
                    title: 'Account & Profile',
                    subtitle: 'Manage your account and profile settings',
                  ),
                  _HelpTile(
                    icon: Icons.lock_outline,
                    title: 'Privacy & Security',
                    subtitle: 'Your data, privacy and security',
                  ),
                  _HelpTile(
                    icon: Icons.school_outlined,
                    title: 'Learning & Interests',
                    subtitle: 'How Aspira learning works',
                  ),
                  _HelpTile(
                    icon: Icons.bug_report_outlined,
                    title: 'Troubleshooting',
                    subtitle: 'Fix common issues',
                  ),

                  const SizedBox(height: 32),

                  /// ================= FAQ =================
                  Text(
                    'Frequently Asked Questions',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _FaqTile(
                    question: 'How do I update my profile?',
                    answer:
                        'Go to Profile → Profile Information and update your details.',
                  ),
                  _FaqTile(
                    question: 'How do interests work?',
                    answer:
                        'Interests help personalize your feed and learning experience.',
                  ),
                  _FaqTile(
                    question: 'Is my data secure?',
                    answer:
                        'Yes. We follow best practices to protect your data.',
                  ),

                  const SizedBox(height: 32),

                  /// ================= CONTACT =================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF171A29),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.support_agent,
                          color: Color(0xFF14B8A6),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Still need help?\nContact our support team.',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: open support email / chat
                          },
                          child: Text(
                            'Contact',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF14B8A6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HelpTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        tileColor: const Color(0xFF171A29),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: const Color(0xFF14B8A6)),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.manrope(color: Colors.white54, fontSize: 13),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: () {
          // TODO: navigate to detail page
        },
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      collapsedIconColor: Colors.white38,
      iconColor: const Color(0xFF14B8A6),
      title: Text(
        question,
        style: GoogleFonts.manrope(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: GoogleFonts.manrope(color: Colors.white54, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
