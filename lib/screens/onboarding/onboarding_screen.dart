import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/screens/onboarding/widgets/step_one_widget.dart';
import 'package:aspira/screens/onboarding/widgets/step_three_widget.dart';
import 'package:aspira/screens/onboarding/widgets/step_two_widget.dart';
import 'package:aspira/screens/widgets/button/custom_button.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

final Set<String> selected = {'Communication', 'Personal Dev'};

String selectedGoal = 'Regular';
String experienceLevel = 'Beginner';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  String selectedGoal = 'Regular';
  String experienceLevel = 'Beginner';

  void _goToNextStep() {
    setState(() {
      if (_step < 2) {
        _step++;
      } else {
        LocalStorageService().saveIsOnboardingComplete(true);
        // Navigate to core screen after last step
        context.go(RouteLocationName.feed);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(height: 12),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: _buildStep(),
            ),

            /// ================= STICKY CTA =================
            Positioned(
              left: 16,
              right: 16,
              bottom: 0,
              child: CustomButton(
                buttonText: 'Continue',
                onTap: () {
                  _goToNextStep();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return const StepOneWidget(key: ValueKey(0));
      case 1:
        return const StepTwoWidget(key: ValueKey(1));
      case 2:
        return const StepThreeWidget(key: ValueKey(2));
      default:
        return const SizedBox.shrink();
    }
  }
}

class TopNavWidget extends StatelessWidget {
  const TopNavWidget({super.key, required int step}) : _step = step;

  final int _step;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24).copyWith(top: 16),
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
            style: GoogleFonts.manrope(color: Colors.white60, fontWeight: FontWeight.w600),
          ),
        ],
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

final Map<String, List<String>> categorizedInterests = {
  'Communication & Soft Skills': [
    'Public Speaking',
    'Active Listening',
    'Conversation Skills'
        'Storytelling',
    'Body Language',
    'Presentation Skills',
    'Conflict Resolution',
    'Negotiation',
    'Emotional Intelligence',
    'Interpersonal Communication',
  ],
  'Technology & Coding': [
    'Flutter Development',
    'Web Development',
    'Backend Development',
    'AI',
    'Machine Learning'
        'System Design',
    'Cyber Security',
    'Database',
  ],
  'Business & Leadership': [
    'Leadership',
    'Entrepreneurship',
    'Startup Building',
    'Marketing',
    'Personal Branding',
  ],
  'Personal Growth': [
    'Self Discipline',
    'Confidence',
    'Time Management',
    'Critical Thinking',
    'Mindset',
  ],
};
