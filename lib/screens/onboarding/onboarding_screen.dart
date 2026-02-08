import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/core/utils/app_constants.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/models/selected_profile_option_model/selected_profile_option_model.dart';
import 'package:aspira/screens/onboarding/widgets/step_one_widget.dart';
import 'package:aspira/screens/onboarding/widgets/step_three_widget.dart';
import 'package:aspira/screens/onboarding/widgets/step_two_widget.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:aspira/view_models/auth/update_profile_view_model.dart';
import 'package:aspira/view_models/profile_option_service_view_model/selected_profile_option_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void _goToNextStep({
    required SelectedProfileOptionModel? selectedProfileOption,
    WidgetRef? ref,
  }) {
    if (_step == 0) {
      if (selectedProfileOption!.interests.isEmpty) return;
    } else if (_step == 1) {
      if (selectedProfileOption?.goal == null &&
          selectedProfileOption?.goal == 0)
        return;
    } else if (_step == 2) {
      if (selectedProfileOption?.experience == null &&
          selectedProfileOption?.experience == 0) {
        return;
      }
    }

    setState(() {
      if (_step < 2) {
        _step++;
      } else {
        ref
            ?.read(updateProfileViewModelProvider.notifier)
            .updateProfile(payload: selectedProfileOption!.toJson());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              right: 16,
              bottom: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  ref.listen(updateProfileViewModelProvider, (previous, next) {
                    if (next is AsyncData) {
                      // Handle successful profile update
                      final message = next.value;
                      if (message != null && message.isNotEmpty) {
                        LocalStorageService().saveIsOnboardingComplete(true);
                        // Ui.showSuccessSnackBar(context, message: message);
                        context.goNamed(RouteLocationName.feed);
                      }
                    } else if (next is AsyncError) {
                      // Handle error
                      final message = next.error is Failure
                          ? (next.error as Failure).message
                          : next.error.toString();
                      Ui.showErrorSnackBar(context, message: message);
                    }
                  });

                  final selectedProfileOption = ref.watch(
                    selectedProfileOptionViewModel,
                  );
                  final profileUpdateViewModel = ref.watch(
                    updateProfileViewModelProvider,
                  );
                  return AnimatedSwitcher(
                    duration: AppConstants.switchAnimationDuration,
                    child: profileUpdateViewModel.when(
                      data: (message) => FloatingActionButton(
                        key: ValueKey('initial_button'),
                        shape: const CircleBorder(),
                        backgroundColor: _getButtonColor(
                          selectedProfileOption: selectedProfileOption,
                        ),
                        onPressed: () {
                          _goToNextStep(
                            selectedProfileOption: selectedProfileOption,
                            ref: ref,
                          );
                        },
                        child: Icon(
                          _step == 2 ? Icons.done : Icons.arrow_forward_ios,
                        ),
                      ),

                      // CustomButton(
                      //   key: ValueKey('initial_button'),
                      //   buttonText: 'Continue',
                      //   color: _getButtonColor(
                      //     selectedProfileOption: selectedProfileOption,
                      //   ),
                      //   onTap: () {
                      //     _goToNextStep(
                      //       selectedProfileOption: selectedProfileOption,
                      //       ref: ref,
                      //     );
                      //   },
                      // ),
                      error: (error, stack) => FloatingActionButton(
                        key: ValueKey('error_button'),
                        backgroundColor: _getButtonColor(
                          selectedProfileOption: selectedProfileOption,
                        ),
                        onPressed: () {
                          _goToNextStep(
                            selectedProfileOption: selectedProfileOption,
                          );
                        },
                        child: Icon(
                          _step == 2 ? Icons.done : Icons.arrow_forward_ios,
                        ),
                      ),

                      //  CustomButton(
                      //   key: ValueKey('error_button'),
                      //   buttonText: 'Continue',
                      //   color: _getButtonColor(selectedProfileOption: selectedProfileOption),
                      //   onTap: () {
                      //     _goToNextStep(selectedProfileOption: selectedProfileOption);
                      //   },
                      // ),
                      loading: () => CircularProgressIndicator(
                        key: ValueKey('loading_button'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor({
    required SelectedProfileOptionModel? selectedProfileOption,
  }) {
    if (_step == 0) {
      return selectedProfileOption?.interests.isNotEmpty == true
          ? const Color(0xFF14B8A6)
          : Colors.grey;
    } else if (_step == 1) {
      return (selectedProfileOption?.goal != null &&
              selectedProfileOption?.goal != 0)
          ? const Color(0xFF14B8A6)
          : Colors.grey;
    } else if (_step == 2) {
      return (selectedProfileOption?.experience != null &&
              selectedProfileOption?.experience != 0)
          ? const Color(0xFF14B8A6)
          : Colors.grey;
    }
    return Colors.grey;
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
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ).copyWith(top: 16),
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
    );
  }
}

/// ================= COMPONENTS =================

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
