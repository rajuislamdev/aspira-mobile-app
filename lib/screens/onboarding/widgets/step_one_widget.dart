import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/models/interest/interest_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/fetch_profile_option_service_view_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/selected_profile_option_view_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

/// ------------------ STEP ONE ------------------

class StepOneWidget extends StatefulWidget {
  const StepOneWidget({super.key});

  @override
  State<StepOneWidget> createState() => _StepOneWidgetState();
}

class _StepOneWidgetState extends State<StepOneWidget> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ------------------ TITLE ------------------
          RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(fontSize: 30, fontWeight: FontWeight.w800, height: 1.15),
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

          /// ------------------ ANIMATED DESCRIPTION ------------------
          AnimatedSize(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            alignment: Alignment.topLeft,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              offset: _hideDescription ? const Offset(0.35, 0) : Offset.zero,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _hideDescription ? 0 : 1,
                child: _hideDescription
                    ? const SizedBox.shrink()
                    : Text(
                        'Select the topics you want to explore to personalize your learning path.',
                        style: GoogleFonts.manrope(
                          color: Colors.white54,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// ------------------ LIST ------------------
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final viewModel = ref.watch(fetchProfileOptionViewModel);
                return viewModel.when(
                  data: (profileOptions) {
                    if (profileOptions == null) {
                      return const SizedBox.shrink();
                    }
                    return ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 16, bottom: 100),
                      itemCount: profileOptions.interests.length,
                      itemBuilder: (context, index) {
                        final title = profileOptions.interests[index].name;
                        final interests = profileOptions.interests[index].interestList;

                        return InterestCategorySection(
                          title: title,
                          interests: interests,

                          onTap: (value) => ref
                              .read(selectedProfileOptionViewModel.notifier)
                              .updateInterest(interestId: value.id),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                    );
                  },
                  error: (error, s) {
                    final message = error is Failure ? error.message : error.toString();
                    return Text(message);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator(color: Color(0xFF14B8A6))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------ CATEGORY SECTION ------------------

class InterestCategorySection extends StatelessWidget {
  final String title;
  final List<InterestModel> interests;
  final Function(InterestModel) onTap;

  const InterestCategorySection({
    super.key,
    required this.title,
    required this.interests,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),

        /// Chips
        Consumer(
          builder: (context, ref, child) {
            final selectedOptionViewModel = ref.watch(selectedProfileOptionViewModel);
            final selectedOptions = selectedOptionViewModel?.interests ?? [];
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: interests.mapIndexed((index, interest) {
                final isSelected = selectedOptions.contains(interest.id);
                return GestureDetector(
                  onTap: () => onTap(interest),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF14B8A6) : const Color(0xFF171A29),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF14B8A6) : Colors.white12,
                      ),
                    ),
                    child: Text(
                      interest.name,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: isSelected ? const Color(0xFF111214) : Colors.white70,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
