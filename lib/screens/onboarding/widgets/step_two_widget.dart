import 'package:aspira/core/errors/error_view.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/models/goal/goal_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/fetch_profile_option_service_view_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/selected_profile_option_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class StepTwoWidget extends StatefulWidget {
  const StepTwoWidget({super.key});

  @override
  State<StepTwoWidget> createState() => _StepTwoWidgetState();
}

class _StepTwoWidgetState extends State<StepTwoWidget> {
  late ScrollController _scrollController;

  bool _hideDescription = false;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final isStartPosition = offset == 0;

      // Scroll to top → show
      if (isStartPosition && _hideDescription) {
        setState(() => _hideDescription = false);
      }
      // Scroll down → hide
      if (offset > _lastOffset && !_hideDescription) {
        setState(() => _hideDescription = true);
      }

      // Scroll up → show
      if (isStartPosition && _hideDescription) {
        setState(() => _hideDescription = false);
      }

      _lastOffset = offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: 'daily goal?',
                      style: TextStyle(color: Color(0xFF14B8A6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              AnimatedSize(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOut,
                alignment: Alignment.topLeft,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  offset: _hideDescription
                      ? const Offset(0.35, 0)
                      : Offset.zero,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _hideDescription ? 0 : 1,
                    child: _hideDescription
                        ? const SizedBox.shrink()
                        : Text(
                            'Commit to a daily learning habit that fits your lifestyle. You can change this anytime.',
                            style: GoogleFonts.manrope(
                              color: Colors.white54,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Consumer(
              builder: (context, ref, child) {
                final viewModel = ref.watch(fetchProfileOptionViewModel);
                final selectedProfileOption = ref.watch(
                  selectedProfileOptionViewModel,
                );

                return viewModel.when(
                  data: (profileOptions) {
                    if (profileOptions == null) {
                      return ErrorView(message: 'No profile options found.');
                    }
                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: 80),
                      itemCount: profileOptions.goals.length + 1,
                      itemBuilder: (context, index) {
                        bool isSelected =
                            selectedProfileOption?.goal ==
                            profileOptions
                                .goals[index == profileOptions.goals.length
                                    ? index - 1
                                    : index]
                                .id;
                        if (index == profileOptions.goals.length) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF14B8A6).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(
                                  0xFF14B8A6,
                                ).withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.tips_and_updates,
                                  color: Color(0xFF14B8A6),
                                ),
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
                          );
                        }
                        return GoalCard(
                          goal: GoalOption(
                            title: profileOptions.goals[index].name,
                            subtitle: profileOptions.goals[index].duration,
                            icon: Icons.schedule,
                            recommended:
                                profileOptions.goals[index].name
                                    .toLowerCase() ==
                                'regular',
                          ),
                          selected: isSelected,
                          onTap: () => ref
                              .read(selectedProfileOptionViewModel.notifier)
                              .updateGoal(
                                goalId: profileOptions.goals[index].id,
                              ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    );
                  },
                  error: (error, s) {
                    final message = error is Failure
                        ? error.message
                        : error.toString();
                    return ErrorView(message: message);
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              },
            ),

            // ListView(
            //   controller: _scrollController,
            //   padding: const EdgeInsets.only(top: 16, bottom: 140),
            //   children: [
            //     GoalCard(
            //       goal: GoalOption(title: 'Casual', subtitle: '5 mins / day', icon: Icons.coffee),
            //       selected: selectedGoal == 'Casual',
            //       onTap: () {},
            //     ),
            //     const SizedBox(height: 16),
            //     GoalCard(
            //       goal: GoalOption(
            //         title: 'Regular',
            //         subtitle: '15 mins / day',
            //         icon: Icons.schedule,
            //         recommended: true,
            //       ),
            //       selected: selectedGoal == 'Regular',
            //       onTap: () {},
            //     ),
            //     const SizedBox(height: 16),
            //     GoalCard(
            //       goal: GoalOption(
            //         title: 'Serious',
            //         subtitle: '30 mins / day',
            //         icon: Icons.menu_book,
            //       ),
            //       selected: selectedGoal == 'Serious',
            //       onTap: () {},
            //     ),
            //     const SizedBox(height: 16),
            //     GoalCard(
            //       goal: GoalOption(title: 'Intense', subtitle: '60+ mins / day', icon: Icons.bolt),
            //       selected: selectedGoal == 'Intense',
            //       onTap: () {},
            //     ),
            //     const SizedBox(height: 24),

            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}

class GoalCard extends StatelessWidget {
  final GoalOption goal;
  final bool selected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.goal,
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
                goal.icon,
                color: selected ? const Color(0xFF14B8A6) : Colors.white60,
              ),
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
                  style: GoogleFonts.manrope(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
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
