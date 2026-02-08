import 'package:aspira/core/errors/error_view.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/models/experience_model/experience_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/fetch_profile_option_service_view_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/selected_profile_option_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            child: Consumer(
              builder: (context, ref, child) {
                final viewModel = ref.watch(fetchProfileOptionViewModel);
                final selectedProfileOption = ref.watch(
                  selectedProfileOptionViewModel,
                );
                return viewModel.when(
                  data: (profileOptions) {
                    if (profileOptions == null) {
                      return const Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final isSelected =
                            selectedProfileOption?.experience ==
                            profileOptions.experienceLevels[index].id;
                        return ExperienceCard(
                          option: ExperienceOption(
                            title: profileOptions.experienceLevels[index].name,
                            description: profileOptions
                                .experienceLevels[index]
                                .shortDescription,
                            icon: Icons.child_care,
                          ),
                          selected: isSelected,
                          onTap: () => ref
                              .read(selectedProfileOptionViewModel.notifier)
                              .updateExperience(
                                experienceId:
                                    profileOptions.experienceLevels[index].id,
                              ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: profileOptions.experienceLevels.length,
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF14B8A6)),
                  ),
                  error: (error, stackTrace) {
                    final message = error is Failure
                        ? error.message
                        : error.toString();
                    return ErrorView(message: message);
                  },
                );
              },
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
              ? [
                  BoxShadow(
                    color: const Color(0xFF14B8A6).withOpacity(0.15),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
