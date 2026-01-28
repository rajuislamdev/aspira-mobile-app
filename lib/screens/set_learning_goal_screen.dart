import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLearningGoalScreen extends StatefulWidget {
  const SetLearningGoalScreen({super.key});

  @override
  State<SetLearningGoalScreen> createState() => _SetLearningGoalScreenState();
}

class _SetLearningGoalScreenState extends State<SetLearningGoalScreen> {
  String selectedGoal = 'Regular';

  final List<_GoalOption> goals = const [
    _GoalOption(title: 'Casual', subtitle: '5 mins / day', icon: Icons.coffee),
    _GoalOption(
      title: 'Regular',
      subtitle: '15 mins / day',
      icon: Icons.schedule,
      recommended: true,
    ),
    _GoalOption(title: 'Serious', subtitle: '30 mins / day', icon: Icons.menu_book),
    _GoalOption(title: 'Intense', subtitle: '60+ mins / day', icon: Icons.bolt),
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
                                children: const [
                                  _StepBar(active: true),
                                  _StepBar(active: true),
                                  _StepBar(),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'STEP 2 OF 3',
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

                    /// ================= HEADER =================
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

                    /// ================= LIST =================
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView(
                          padding: const EdgeInsets.only(bottom: 140, top: 16),
                          children: [
                            ...goals.map(
                              (goal) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _GoalCard(
                                  goal: goal,
                                  selected: selectedGoal == goal.title,
                                  onTap: () {
                                    setState(() {
                                      selectedGoal = goal.title;
                                    });
                                  },
                                ),
                              ),
                            ),
                            // ================= TIP =================
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
                        onPressed: () {},
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
                                selectedGoal,
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

/// ================= MODELS =================

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

/// ================= WIDGETS =================

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        goal.title,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (goal.recommended)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF14B8A6).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Recommended',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF14B8A6),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
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
                    goal.subtitle,
                    style: GoogleFonts.manrope(color: Colors.white38, fontSize: 13),
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
