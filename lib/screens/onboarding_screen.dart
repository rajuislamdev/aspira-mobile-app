import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final Set<String> selected = {'Communication', 'Personal Dev'};
  int _step = 0;
  String selectedGoal = 'Regular';
  String experienceLevel = 'Beginner';

  final List<_Interest> interests = const [
    _Interest('Communication', 'Soft Skills', Icons.forum),
    _Interest('Coding', 'Development', Icons.terminal),
    _Interest('Leadership', 'Management', Icons.leaderboard),
    _Interest('Personal Dev', 'Mindset', Icons.psychology),
    _Interest('Data Science', 'Analytics', Icons.bar_chart),
    _Interest('Design', 'UI / UX', Icons.palette),
    _Interest('Marketing', 'Growth', Icons.campaign),
    _Interest('Finance', 'Investing', Icons.account_balance),
  ];

  void _goToNextStep() {
    setState(() {
      if (_step < 2) {
        _step++;
      } else {
        // Navigate to core screen after last step
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const CoreScreen()));
      }
    });
  }

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

                    /// ================= TOP NAV =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  _StepBar(active: _step >= 0),
                                  _StepBar(active: _step >= 1),
                                  _StepBar(active: _step >= 2),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'STEP  OF 3'.replaceFirst('\u0001', (_step + 1).toString()),
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

                    /// ================= HEADER & CONTENT =================
                    if (_step == 0) ...[
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
                                    text: 'What are you\n',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: 'interested',
                                    style: TextStyle(color: Color(0xFF14B8A6)),
                                  ),
                                  TextSpan(
                                    text: ' in?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Select the topics you want to explore to personalize your learning path.',
                              style: GoogleFonts.manrope(
                                color: Colors.white54,
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search topics...',
                            hintStyle: const TextStyle(color: Colors.white30),
                            filled: true,
                            fillColor: const Color(0xFF171A29),
                            prefixIcon: const Icon(Icons.search, color: Colors.white38),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: GridView.builder(
                            itemCount: interests.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.15,
                            ),
                            itemBuilder: (context, index) {
                              final item = interests[index];
                              final isSelected = selected.contains(item.title);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelected
                                        ? selected.remove(item.title)
                                        : selected.add(item.title);
                                  });
                                },
                                child: _InterestCard(interest: item, selected: isSelected),
                              );
                            },
                          ),
                        ),
                      ),
                    ] else if (_step == 1) ...[
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
                                    text: 'daily goal?',
                                    style: TextStyle(color: Color(0xFF14B8A6)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Commit to a daily learning habit that fits your lifestyle. You can change this anytime.',
                              style: GoogleFonts.manrope(
                                color: Colors.white54,
                                fontSize: 15,
                                height: 1.5,
                              ),
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
                              _GoalCard(
                                goal: _GoalOption(
                                  title: 'Casual',
                                  subtitle: '5 mins / day',
                                  icon: Icons.coffee,
                                ),
                                selected: selectedGoal == 'Casual',
                                onTap: () {
                                  setState(() {
                                    selectedGoal = 'Casual';
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              _GoalCard(
                                goal: _GoalOption(
                                  title: 'Regular',
                                  subtitle: '15 mins / day',
                                  icon: Icons.schedule,
                                  recommended: true,
                                ),
                                selected: selectedGoal == 'Regular',
                                onTap: () {
                                  setState(() {
                                    selectedGoal = 'Regular';
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              _GoalCard(
                                goal: _GoalOption(
                                  title: 'Serious',
                                  subtitle: '30 mins / day',
                                  icon: Icons.menu_book,
                                ),
                                selected: selectedGoal == 'Serious',
                                onTap: () {
                                  setState(() {
                                    selectedGoal = 'Serious';
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              _GoalCard(
                                goal: _GoalOption(
                                  title: 'Intense',
                                  subtitle: '60+ mins / day',
                                  icon: Icons.bolt,
                                ),
                                selected: selectedGoal == 'Intense',
                                onTap: () {
                                  setState(() {
                                    selectedGoal = 'Intense';
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF14B8A6).withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFF14B8A6).withOpacity(0.15),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.tips_and_updates, color: Color(0xFF14B8A6)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '"Small daily actions lead to massive results over time. 15 minutes a day is perfect for steady progress."',
                                        style: GoogleFonts.manrope(
                                          fontSize: 13,
                                          color: Colors.white70,
                                          height: 1.5,
                                          fontStyle: FontStyle.italic,
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
                    ] else if (_step == 2) ...[
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ListView(
                            padding: const EdgeInsets.only(top: 16, bottom: 140),
                            children: [
                              _ExperienceCard(
                                option: _ExperienceOption(
                                  title: 'Beginner',
                                  description:
                                      'Starting fresh or have very limited knowledge in this field.',
                                  icon: Icons.child_care,
                                ),
                                selected: experienceLevel == 'Beginner',
                                onTap: () {
                                  setState(() {
                                    experienceLevel = 'Beginner';
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              _ExperienceCard(
                                option: _ExperienceOption(
                                  title: 'Intermediate',
                                  description:
                                      'Comfortable with the basics and ready for complex challenges.',
                                  icon: Icons.trending_up,
                                ),
                                selected: experienceLevel == 'Intermediate',
                                onTap: () {
                                  setState(() {
                                    experienceLevel = 'Intermediate';
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              _ExperienceCard(
                                option: _ExperienceOption(
                                  title: 'Expert',
                                  description:
                                      'Highly skilled professional seeking specialized insights.',
                                  icon: Icons.workspace_premium,
                                ),
                                selected: experienceLevel == 'Expert',
                                onTap: () {
                                  setState(() {
                                    experienceLevel = 'Expert';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 120),
                  ],
                ),

                /// ================= STICKY CTA =================
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 10,
                        ),
                        onPressed: _goToNextStep,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _step == 0
                                    ? selected.length.toString()
                                    : (_step == 1 ? selectedGoal : experienceLevel),
                                style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
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

/// ================= COMPONENTS =================

class _Interest {
  final String title;
  final String subtitle;
  final IconData icon;

  const _Interest(this.title, this.subtitle, this.icon);
}

class _InterestCard extends StatelessWidget {
  final _Interest interest;
  final bool selected;

  const _InterestCard({required this.interest, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
            ? [BoxShadow(color: const Color(0xFF14B8A6).withOpacity(0.15), blurRadius: 12)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF14B8A6).withOpacity(0.2) : Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(interest.icon, color: selected ? const Color(0xFF14B8A6) : Colors.white60),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              interest.title,
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              interest.subtitle,
              style: GoogleFonts.manrope(color: Colors.white38, fontSize: 11),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
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

class _GoalOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool recommended;

  const _GoalOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.recommended = false,
  });
}

class _GoalCard extends StatelessWidget {
  final _GoalOption goal;
  final bool selected;
  final VoidCallback onTap;

  const _GoalCard({required this.goal, required this.selected, required this.onTap});

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
              ? [BoxShadow(color: const Color(0xFF14B8A6).withOpacity(0.15), blurRadius: 12)]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF14B8A6).withOpacity(0.2) : Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(goal.icon, color: selected ? const Color(0xFF14B8A6) : Colors.white60),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  goal.subtitle,
                  style: GoogleFonts.manrope(color: Colors.white38, fontSize: 11),
                ),
                if (goal.recommended)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Recommended',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF14B8A6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceOption {
  final String title;
  final String description;
  final IconData icon;

  const _ExperienceOption({required this.title, required this.description, required this.icon});
}

class _ExperienceCard extends StatelessWidget {
  final _ExperienceOption option;
  final bool selected;
  final VoidCallback onTap;

  const _ExperienceCard({required this.option, required this.selected, required this.onTap});

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
