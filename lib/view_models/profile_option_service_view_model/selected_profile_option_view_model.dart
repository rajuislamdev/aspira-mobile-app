import 'package:aspira/models/selected_profile_option_model/selected_profile_option_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedProfileOptionViewModel =
    StateNotifierProvider<
      SelectedProfileOptionViewModel,
      SelectedProfileOptionModel?
    >((ref) => SelectedProfileOptionViewModel());

class SelectedProfileOptionViewModel
    extends StateNotifier<SelectedProfileOptionModel?> {
  SelectedProfileOptionViewModel() : super(SelectedProfileOptionModel.empty());

  void updateInterest({required String interestId}) {
    if (state?.interests.contains(interestId) ?? false) {
      state = state?.copyWith(
        interests: state!.interests
            .where((element) => element != interestId)
            .toList(),
      );
      return;
    }
    state = state?.copyWith(interests: [...?state?.interests, interestId]);
  }

  void updateGoal({required String goalId}) {
    state = state?.copyWith(goal: goalId);
  }

  void updateExperience({required String experienceId}) {
    state = state?.copyWith(experience: experienceId);
  }
}
