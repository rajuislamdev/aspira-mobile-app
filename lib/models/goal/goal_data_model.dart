class GoalDataModel {
  final int id;
  final String label;

  GoalDataModel({required this.id, required this.label});

  factory GoalDataModel.fromJson(Map<String, dynamic> json) {
    return GoalDataModel(id: json['id'], label: json['label']);
  }
}
