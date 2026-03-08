import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceLevelScreen extends StatefulWidget {
  const ExperienceLevelScreen({super.key});

  @override
  State<ExperienceLevelScreen> createState() => _ExperienceLevelScreenState();
}

class _ExperienceLevelScreenState extends State<ExperienceLevelScreen> {
  String selected = 'Beginner';

  final List<_ExperienceOption> options = const [
    _ExperienceOption(
      title: 'Beginner',
      description:
          'Starting fresh or have very limited knowledge in this field.',
      icon: Icons.child_care,
    ),
    _ExperienceOption(
      title: 'Intermediate',
      description:
          'Comfortable with the basics and ready for complex challenges.',
      icon: Icons.trending_up,
    ),
    _ExperienceOption(
      title: 'Expert',
      description: 'Highly skilled professional seeking specialized insights.',
      icon: Icons.workspace_premium,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 12),
                    // ================= TOP NAV =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  _StepBar(active: true),
                                  _StepBar(active: true),
                                  _StepBar(active: true),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'STEP 3 OF 3',
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.4,
                                  color: Colors.white38,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Skip',
                            style: GoogleFonts.manrope(
                              color: Colors.white60,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ================= HEADER =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.manrope(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                              ),
                              children: const [
                                TextSpan(
                                  text: "What's your\n",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'experience?',
                                  style: TextStyle(color: Color(0xFF14B8A6)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "We'll tailor the difficulty and content recommendations based on your level.",
                            style: GoogleFonts.manrope(
                              color: Colors.white54,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ================= OPTIONS =================
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView(
                          padding: const EdgeInsets.only(top: 16, bottom: 140),
                          children: options.map((option) {
                            final isSelected = selected == option.title;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _ExperienceCard(
                                option: option,
                                selected: isSelected,
                                onTap: () {
                                  setState(() {
                                    selected = option.title;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
                // ================= STICKY CTA =================
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xFF111214)],
                      ),
                    ),
                    child: SizedBox(
                      height: 64,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF14B8A6),
                          foregroundColor: const Color(0xFF111214),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 10,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                selected,
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
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

class _ExperienceOption {
  final String title;
  final String description;
  final IconData icon;

  const _ExperienceOption({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _ExperienceCard extends StatelessWidget {
  final _ExperienceOption option;
  final bool selected;
  final VoidCallback onTap;

  const _ExperienceCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF171A29),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF14B8A6) : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF14B8A6).withOpacity(0.15),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF14B8A6).withOpacity(0.2)
                    : Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                option.icon,
                color: selected ? const Color(0xFF14B8A6) : Colors.white60,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        option.title,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (selected) ...[
                        const Spacer(),
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF14B8A6),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    option.description,
                    style: GoogleFonts.manrope(
                      color: Colors.white38,
                      fontSize: 13,
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
}

class _StepBar extends StatelessWidget {
  final bool active;

  const _StepBar({this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: 24,
      height: 4,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF14B8A6) : Colors.white24,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
