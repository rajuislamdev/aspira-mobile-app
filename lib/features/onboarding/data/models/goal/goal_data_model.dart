class GoalDataModel {
  final String id;
  final String name;
  final String duration;

  GoalDataModel({required this.id, required this.name, required this.duration});

  factory GoalDataModel.fromJson(Map<String, dynamic> json) {
    return GoalDataModel(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
    );
  }
}
