class SelectedProfileOptionModel {
  final List<String> interests;
  final String goal;
  final String experience;
  final String position;

  SelectedProfileOptionModel({
    required this.interests,
    required this.goal,
    required this.experience,
    required this.position,
  });

  // copy with method
  SelectedProfileOptionModel copyWith({
    List<String>? interests,
    String? goal,
    String? experience,
    String? position,
  }) {
    return SelectedProfileOptionModel(
      interests: interests ?? this.interests,
      goal: goal ?? this.goal,
      experience: experience ?? this.experience,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toJson() {
    return {'interests': interests, 'goal': goal, 'experience': experience, 'position': position};
  }

  /// empty constructor
  SelectedProfileOptionModel.empty() : interests = [], goal = '', experience = '', position = '';
}
