import 'package:aspira/core/router/route_location_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                /// ================= HERO SECTION =================
                Expanded(
                  flex: 5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// Gradient background
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x661E3B8A), Color(0xFF111214)],
                          ),
                        ),
                      ),

                      /// Circular illustration container
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: SizedBox(
                          width: 280,
                          height: 280,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _CircleBorder(
                                size: 260,
                                color: const Color(0xFF14B8A6).withOpacity(0.3),
                              ),
                              _CircleBorder(
                                size: 220,
                                color: const Color(0xFF1E3B8A).withOpacity(0.2),
                              ),
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF1E3B8A).withOpacity(0.1),
                                ),
                                child: const Icon(
                                  Icons.auto_graph_rounded,
                                  size: 72,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ================= CONTENT SECTION =================
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Headline
                          Text(
                            'Learn What Matters\nto You',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Join a community of lifelong learners and master the skills that shape your future.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              color: const Color(0xFFB8B9BD),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 32),

                          /// Email CTA
                          _PrimaryButton(
                            label: 'Get Started with Email',
                            background: const Color(0xFF14B8A6),
                            textColor: const Color(0xFF111214),
                            onTap: () {
                              context.pushNamed(RouteLocationName.loginWithEmail);
                            },
                          ),

                          const SizedBox(height: 12),

                          /// Google Button
                          _SocialButton(
                            label: 'Continue with Google',
                            icon: Icons.g_mobiledata_rounded,
                            onTap: () {},
                          ),

                          const SizedBox(height: 12),

                          /// Apple Button
                          _SocialButton(
                            label: 'Continue with Apple',
                            icon: Icons.apple,
                            onTap: () {},
                          ),

                          const SizedBox(height: 24),

                          /// Footer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFFB8B9BD),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Log In',
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF14B8A6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _FooterLink('Terms of Service'),
                              const SizedBox(width: 12),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 12),
                              _FooterLink('Privacy Policy'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// iOS home indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
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

/// ================= COMPONENTS =================

class _CircleBorder extends StatelessWidget {
  final double size;
  final Color color;

  const _CircleBorder({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color textColor;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.background,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onTap,
        child: Text(label, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon, size: 22, color: Colors.white),
        label: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF171A29),
          side: const BorderSide(color: Colors.white10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onTap,
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;

  const _FooterLink(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.manrope(fontSize: 11, color: const Color(0xFFB8B9BD).withOpacity(0.6)),
    );
  }
}
