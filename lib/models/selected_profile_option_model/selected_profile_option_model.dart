class SelectedProfileOptionModel {
  final List<String> interests;
  final int goal;
  final int experience;
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
    int? goal,
    int? experience,
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
  SelectedProfileOptionModel.empty() : interests = [], goal = 0, experience = 0, position = '';
}
