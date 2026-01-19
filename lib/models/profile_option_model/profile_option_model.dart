import 'package:aspira/models/experience_model/experience_data_model.dart';
import 'package:aspira/models/goal/goal_data_model.dart';
import 'package:aspira/models/interest/interest_category_model.dart';

class ProfileOptionModel {
  final List<InterestCategoryModel> interests;
  final List<GoalDataModel> goals;
  final List<ExperienceDataModel> experienceLevels;

  ProfileOptionModel({
    required this.interests,
    required this.goals,
    required this.experienceLevels,
  });

  factory ProfileOptionModel.fromJson(Map<String, dynamic> json) {
    return ProfileOptionModel(
      interests: (json['interests'] as List).map((e) => InterestCategoryModel.fromJson(e)).toList(),
      goals: (json['goals'] as List).map((e) => GoalDataModel.fromJson(e)).toList(),
      experienceLevels: (json['experienceLevels'] as List)
          .map((e) => ExperienceDataModel.fromJson(e))
          .toList(),
    );
  }
}
