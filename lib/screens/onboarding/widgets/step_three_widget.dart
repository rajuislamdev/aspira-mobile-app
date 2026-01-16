import 'package:aspira/models/experience_model/experience_model.dart';
import 'package:aspira/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepThreeWidget extends StatelessWidget {
  const StepThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                style: GoogleFonts.manrope(color: Colors.white54, fontSize: 15, height: 1.5),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              padding: const EdgeInsets.only(top: 16, bottom: 140),
              children: [
                ExperienceCard(
                  option: ExperienceOption(
                    title: 'Beginner',
                    description: 'Starting fresh or have very limited knowledge in this field.',
                    icon: Icons.child_care,
                  ),
                  selected: experienceLevel == 'Beginner',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                ExperienceCard(
                  option: ExperienceOption(
                    title: 'Intermediate',
                    description: 'Comfortable with the basics and ready for complex challenges.',
                    icon: Icons.trending_up,
                  ),
                  selected: experienceLevel == 'Intermediate',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                ExperienceCard(
                  option: ExperienceOption(
                    title: 'Expert',
                    description: 'Highly skilled professional seeking specialized insights.',
                    icon: Icons.workspace_premium,
                  ),
                  selected: experienceLevel == 'Expert',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final ExperienceOption option;
  final bool selected;
  final VoidCallback onTap;

  const ExperienceCard({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 80), // Prevent overflow
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF171A29),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF14B8A6) : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? [BoxShadow(color: const Color(0xFF14B8A6).withOpacity(0.15), blurRadius: 12)]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF14B8A6).withOpacity(0.2) : Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(option.icon, color: selected ? const Color(0xFF14B8A6) : Colors.white60),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          option.title,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (selected) ...[
                        const Spacer(),
                        const Icon(Icons.check_circle, color: Color(0xFF14B8A6)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    option.description,
                    style: GoogleFonts.manrope(color: Colors.white38, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
